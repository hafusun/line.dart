import 'dart:convert';
import 'dart:typed_data';
import 'dart:math' as math;
import 'package:pointycastle/export.dart' hide Mac;
import 'package:crypto/crypto.dart' hide Hmac;
import 'package:cryptography/cryptography.dart';
import '../../thrift/line_types.dart' as LINETypes;
import '../core/core.dart';
import '../core/utils/error.dart';
import './cbc.dart';

class E2EE {
  final BaseClient client;

  E2EE({
    required this.client
  });

  Future<dynamic> getE2EESelfKeyData(String mid) async {
    try {
      dynamic keyData = jsonDecode(
        await client.storage.get("e2eeKeys:$mid") as String
      );
      if (keyData != null && keyData["privKey"] && keyData["pubKey"]) return keyData;
    } catch(_e) {
      /* :( */
    }
    dynamic keys = await client.talk.getE2EEPublicKeys();
    for (int i = 0; i < keys.length; i++) {
      dynamic key = keys[i];
      dynamic keyId = key["keyId"] ?? key[2] as String?;
      dynamic keyData0 = await getE2EESelfKeyDataByKeyId(keyId);
      if (keyData0 != null) {
        await saveE2EESelfKeyData(keyData0);
        return keyData0;
      }
    }
    throw InternalError(
      "NoE2EEKey",
      "E2EE Key has not been saved, try register `saveE2EESelfKeyDataByKeyId` or use E2EE Login",
    );
  }

  Future<dynamic> getE2EESelfKeyDataByKeyId(dynamic keyId) async {
    try {
      return jsonDecode(
        await client.storage.get("e2eeKeys:" + keyId) as String
      );
    } catch (_e) {
      /* :) */
    }
  }

  void saveE2EESelfKeyDataByKeyId(dynamic keyId, dynamic value) async {
    await client.storage.set(
      "e2eeKeys:" + keyId,
      jsonEncode(value)
    );
  }

  Future<void> saveE2EESelfKeyData(dynamic value) async {
    await client.storage.set(
      "e2eeKeys:${client.profile!.mid}",
      jsonEncode(value)
    );
  }

  Future<dynamic> getE2EELocalPublicKey(String mid, dynamic keyId) async {
    dynamic toType = client.getToType(mid);

    if (toType  == LINETypes.MIDType.USER.value) {
      String? key;
      if (keyId != null) {
        key = (await client.storage.get(
          "e2eePublicKeys:" + keyId
        )) as String?;
      }
      LINETypes.E2EENegotiationResult receiverKeyData;
      if (key == null || key == false) {
        receiverKeyData = await client.talk.negotiateE2EEPublicKey(
          { "mid": mid }
        );
        dynamic specVersion = receiverKeyData.specVersion;
        if (specVersion == -1) {
          throw InternalError("Not Support E2EE", mid);
        }
        dynamic publicKey = receiverKeyData.publicKey;
        int receiverKeyId = publicKey.keyId;
        if (receiverKeyId == keyId) {
          key = base64.encode(Uint8List.fromList(utf8.encode(publicKey.keyData)));
          await client.storage.set(
            "e2eePublicKeys:" + keyId,
            key
          );
        } else {
          throw InternalError(
            "No E2EEKey",
            "${"E2EE key id " + keyId}not found on $mid, key id  should be $receiverKeyId"
          );
        }
      }
      return base64.decode(key);
    } else {
      String? key;
      key = (await client.storage.get(
        "e2eegroupKeys:$mid",
      )) as String?;
      if (keyId != null && key != null) {
        Map keyData = jsonDecode(key);
        if (keyId != keyData["keyId"]) {
          e2eeLog("getE2EELocalPublicKey, keyId mismatch", mid);
          key = null;
        } else {
          return keyData;
        }
      }
      if (key == null || key == false) {
        dynamic e2eeGroupSharedKey;
        try {
          e2eeGroupSharedKey = await client.talk.getLastE2EEGroupSharedKey({
            "keyVersion": 2,
            "chatMid": mid
          });
        } catch(error) {
          if (error is InternalError && error.data["code"] == "NOT_FOUND") {
            e2eeGroupSharedKey = await tryRegisterE2EEGroupKey(
              mid,
            );
          } else {
            rethrow;
          }
        }
        int groupKeyId = e2eeGroupSharedKey.groupKeyId;
        String creator = e2eeGroupSharedKey.creator;
        int creatorKeyId = e2eeGroupSharedKey.creatorKeyId;
        int receiverKeyId = e2eeGroupSharedKey.receiverKeyId;
        Uint8List encryptedSharedKey = base64.decode(e2eeGroupSharedKey.encryptedSharedKey);
        Uint8List selfKey = base64.decode(
          (await getE2EESelfKeyDataByKeyId(receiverKeyId))["privKey"] as String
        );
        dynamic creatorKey = await getE2EELocalPublicKey(
          creator,
          creatorKeyId
        );

        dynamic aesKey = await generateSharedSecret(
          selfKey,
          creatorKey as Uint8List
        );
        aesKey = getSHA256Sum([base64.decode(aesKey), "Key"]);
        dynamic aesIv = xor(
          getSHA256Sum([base64.decode(aesKey), "IV"]),
        );

        e2eeLog("getE2EELocalPublicKeyAESInfo", {
          aesKey, aesIv, encryptedSharedKey,
        });
        Uint8List plainText = decryptAESCBC(key: aesKey, iv: aesIv, ciphertext: encryptedSharedKey);
        e2eeLog("getE2EELocalPublicKeyDecryptedLength", plainText.length);
        String decrypted = base64.encode(plainText);
        e2eeLog("getE2EELocalPublicKeyDecrypted", decrypted);
        Map data = { "privKey": decrypted, "keyId": groupKeyId };
        key = jsonEncode(data);
        await client.storage.set("e2eegroupKeys:$mid", key);
        return data;
      }
      return jsonDecode(key);
    }
  }

  Future<LINETypes.Pb1_U3> tryRegisterE2EEGroupKey(String chatMid) async {
    Map e2eePublicKeys = await client.talk.getLastE2EEPublicKeys({
      "chatMid": chatMid
    });
    List<String> members = [];
    List<int> keyIds = [];
    List encryptedSharedKeys = [];
    int selfKeyId = e2eePublicKeys[client.profile!.mid].keyId;
    dynamic selfKeyData = await getE2EESelfKeyDataByKeyId(selfKeyId);
    if (selfKeyData == null) {
      throw InternalError(
        "NoE2EEKey",
        "E2EE Key has not been saved, try register `saveE2EESelfKeyDataByKeyId` or use E2EE Login",
      );
    }
    Uint8List selfKey = base64.decode(selfKeyData["privKey"]);
    dynamic privateKey = generateRandomBytes(32);
    for (var entry in e2eePublicKeys.entries) {
      String mid = entry.key;
      if (e2eePublicKeys.containsKey(mid)) {
        dynamic key = e2eePublicKeys[mid];
        members.add(mid);
        dynamic keyId = key["keyId"], keyData = key["keyData"];
        keyIds.add(keyId);

        dynamic aesKey = await generateSharedSecret(
          selfKey,
          base64.decode(keyData)
        );
        aesKey = getSHA256Sum([base64.decode(aesKey), "Key"]);
        dynamic aesIv = xor(
          getSHA256Sum([base64.decode(aesKey), "IV"]),
        );

        Uint8List cipher = decryptAESCBC(key: aesKey, iv: aesIv, ciphertext: privateKey);
        encryptedSharedKeys.add(cipher);
      }
    }
    return client.talk.registerE2EEGroupKey({
      "keyVersion": 3,
      "chatMid": chatMid,
      "keyIds": keyIds,
      "members": members,
      "encryptedSharedKeys": encryptedSharedKeys,
    });
  }

  Future<Uint8List> generateSharedSecret(Uint8List privateKey_, Uint8List publicKey_) async {
    final algorithm = X25519();
    e2eeLog("generateSharedSecretKeyInfo", { "privateKey": privateKey_.length, "publicKey": publicKey_.length });
    final privateKey = await algorithm.newKeyPairFromSeed(privateKey_);
    final publicKey = SimplePublicKey(publicKey_, type: KeyPairType.x25519);

    // 共通鍵を生成
    final sharedSecret = await algorithm.sharedSecretKey(
      keyPair: privateKey,
      remotePublicKey: publicKey,
    );

    // バイト配列として返す
    final sharedSecretBytes = await sharedSecret.extractBytes();
    return Uint8List.fromList(sharedSecretBytes);
  }

  Uint8List xor(Uint8List buf) {
    int bufLength = (buf.length / 2).round();
    Uint8List buf2 = Uint8List(bufLength);
    for (int i = 0; i < buf.length; i++) {
      buf2[i] = buf[i] ^ buf[bufLength + i];
    }
    return buf2;
  }

  Uint8List getSHA256Sum(dynamic args) {
    final sha256Digest = sha256.convert(
      args.expand((arg) {
        if (arg is String) {
          return utf8.encode(arg);
        } else if (arg is Uint8List) {
          return arg;
        } else if (arg is List<int>) {
          return arg;
        } else {
          throw ArgumentError('Unsupported argument type: ${arg.runtimeType}');
        }
      }).toList(),
    );
    return Uint8List.fromList(sha256Digest.bytes);
  }

  Uint8List encryptAESECB(Uint8List aesKey, Uint8List plainData) {
    final cipher = ECBBlockCipher(AESEngine())
      ..init(
        true,
        KeyParameter(aesKey),
      );

    final paddedLength = (plainData.length / cipher.blockSize).ceil() * cipher.blockSize;
    final paddedData = Uint8List(paddedLength)..setRange(0, plainData.length, plainData);

    final output = Uint8List(paddedLength);

    for (int offset = 0; offset < paddedData.length; offset += cipher.blockSize) {
      cipher.processBlock(paddedData, offset, output, offset);
    }

    return output;
  }

  Future<dynamic> decodeE2EEKeyV1(dynamic data, Uint8List secret) async {
    if (data != null && data.encryptedKeyChain) {
      Uint8List encryptedKeyChain = base64.decode(data.encryptedKeyChain);
      int keyId = data.keyId;
      Uint8List publicKey = base64.decode(data.publicKey);
      int e2eeVersion = data.e2eeVersion;
      List decryptedKeyChain = await decryptKeyChain(
        publicKey,
        secret,
        encryptedKeyChain
      );
      Uint8List privKey = decryptedKeyChain[0];
      Uint8List pubKey = decryptedKeyChain[1];
      e2eeLog("decodeE2EEKeyV1KeyInfo", { "e2eeKey" :{ keyId, privKey, pubKey, e2eeVersion } });
      await client.storage.set(
        "e2eeKeys:$keyId",
        jsonEncode({ "keyId": keyId, "privKey": base64.encode(privKey), "pubKey": base64.encode(pubKey), "e2eeVersion": e2eeVersion })
      );
      return {
        "keyId": keyId,
        "privKey": privKey,
        "pubKey": pubKey,
        "e2eeVersion": e2eeVersion
      };
    }
  }

  Future<List> decryptKeyChain(Uint8List publicKey, Uint8List privateKey, Uint8List encryptedKeyChain) async {
    e2eeLog("decryptKeyChainKeyInfo", { "decryptKeyChain": { "publicKey": base64.encode(publicKey), "privateKey": base64.encode(privateKey), "encryptedKeyChain": base64.encode(encryptedKeyChain) } });
    Uint8List sharedSecret = await generateSharedSecret(privateKey, publicKey);
    Uint8List aesKey = getSHA256Sum([sharedSecret, "Key"]);
    Uint8List aesIv = xor(
      getSHA256Sum([sharedSecret, "IV"])
    );
    Uint8List keyChainData = decryptAESCBC(key: aesKey, iv: aesIv, ciphertext: encryptedKeyChain);
    e2eeLog("decryptKeyChainBinKeyInfo", { "binkey": keyChainData });
    dynamic key = client.thrift.readThriftStruct(keyChainData)[1];
    Uint8List publicKeyBytes = Uint8List.fromList(utf8.encode(key[0][4]));
    Uint8List privateKeyBytes = Uint8List.fromList(utf8.encode(key[0][5]));
    return [privateKeyBytes, publicKeyBytes];
  }

  Future<Uint8List> encryptDeviceSecret(Uint8List publicKey, Uint8List privateKey, Uint8List encryptedKeyChain) async {
    Uint8List sharedSecret = await generateSharedSecret(privateKey, publicKey);
    Uint8List aesKey = getSHA256Sum([sharedSecret, "Key"]);
    encryptedKeyChain = xor(getSHA256Sum(encryptedKeyChain));
    Uint8List keychainData = encryptAESECB(aesKey, encryptedKeyChain);
    return keychainData;
  }

  Uint8List generateAAD(String a, String b, int c, int d, {int e = 2, int f = 0}) {
    final aad = BytesBuilder();
    aad.add(utf8.encode(a));
    aad.add(utf8.encode(b));
    aad.addByte(c);
    aad.addByte(d);
    aad.addByte(e);
    aad.addByte(f);
    return aad.toBytes();
  }

  Uint8List getIntBytes(int i) {
    int j = 4;
    Uint8List res;

    if (math.pow(j, 2) == 16 ) {
      Uint8List buffer = Uint8List(4);
      ByteData.view(buffer.buffer).setInt32(0, i, Endian.big);
      res = Uint8List.fromList(buffer);
    } else {
      Uint8List buffer = Uint8List(8);
      ByteData.view(buffer.buffer).setInt64(0, i, Endian.big);
      res = Uint8List.fromList(buffer);
    }
    return res;
  }

  Future<dynamic> encryptE2EEMessage(String to, dynamic data, {LINETypes.ContentType contentType = LINETypes.ContentType.NONE, int specVersion = 2}) async {
    int ContentType = contentType.value;
    String from = client.profile?.mid as String;
    dynamic selfKeyData = await getE2EESelfKeyData(from);

    if (to.isEmpty || !([0, 1, 2].contains(client.getToType(to) ?? -1))) {
      throw InternalError("Invalid mid", to);
    }

    dynamic senderKeyId = selfKeyData.keyId;
    dynamic receiverKeyId, keyData;

    if (client.getToType(to) == LINETypes.MIDType.USER.value) {
      Uint8List privateKey = base64.decode(selfKeyData.privKey);
      dynamic receiverKeyData = await client.talk.negotiateE2EEPublicKey({ "mid": to });
      specVersion = receiverKeyData.specVersion;
      if (specVersion == -1) {
        throw InternalError("Not Support E2EE", to);
      }

      dynamic publicKey = receiverKeyData.publicKey;
      receiverKeyId = publicKey.keyId;
      Uint8List receiverKeyDataBuffer = base64.decode(publicKey.keyData);
      keyData = await generateSharedSecret(privateKey, receiverKeyDataBuffer);
    } else {
      Map groupK = (await getE2EELocalPublicKey(to, null)) as Map;
      Uint8List privK = base64.decode(groupK["privKey"]);
      Uint8List pubK = base64.decode(groupK["pubKey"]);
      receiverKeyId = groupK["keyId"];
      keyData = await generateSharedSecret(privK, pubK);
    }
    if (ContentType == LINETypes.ContentType.LOCATION.value && (data is Map || data is Set)) {
      return encryptE2EELocationMessage(
        senderKeyId,
        receiverKeyId,
        keyData,
        specVersion,
        data as LINETypes.Location,
        to,
        from
      );
    } else if (data is String) {
      return encryptE2EETextMessage(
        senderKeyId,
        receiverKeyId,
        keyData,
        specVersion,
        data,
        to,
        from
      );
    } else {
      return encryptE2EEMessageByData(
        senderKeyId,
        receiverKeyId,
        keyData,
        specVersion,
        data,
        to,
        from,
        ContentType
      );
    }
  }

  List<dynamic> encryptE2EETextMessage(
    int senderKeyId,
    int receiverKeyId,
    Uint8List keyData,
    int specVersion,
    String text,
    String to,
    String from
  ) {
    Uint8List salt = generateRandomBytes(16);
    Uint8List gcmKey = getSHA256Sum([keyData, salt, utf8.encode("Key")]);
    Uint8List aad = generateAAD(to, from, senderKeyId, receiverKeyId, e: specVersion, f: 0);
    Uint8List sign = generateRandomBytes(12);
    Uint8List data = utf8.encode(jsonEncode({ "text": text }));
    dynamic encData = encryptE2EEMessageV2(data, gcmKey, sign, aad);

    Uint8List bSenderKeyId = getIntBytes(senderKeyId);
    Uint8List bReceiverKeyId = getIntBytes(receiverKeyId);

    e2eeLog("encryptE2EETextMessageSenderKeyId", bSenderKeyId);
    e2eeLog("encryptE2EETextMessageReceiverKeyId", bReceiverKeyId);

    return [salt, encData, sign, bSenderKeyId, bReceiverKeyId];
  }

  List<dynamic> encryptE2EEMessageByData(
    int senderKeyId,
    int receiverKeyId,
    Uint8List keydata,
    int specVersion,
    Map rawdata,
    String to,
    String from,
    int contentType
  ) {
    Uint8List salt = generateRandomBytes(16);
    Uint8List gcmKey = getSHA256Sum([keydata, salt, utf8.encode("Key")]);
    Uint8List aad = generateAAD(to, from, senderKeyId, receiverKeyId, e: specVersion, f: contentType);
    Uint8List sign = generateRandomBytes(12);
    Uint8List data = utf8.encode(jsonEncode(rawdata));
    dynamic encdata = encryptE2EEMessageV2(data, gcmKey, sign, aad);

    Uint8List bSenderKeyId = getIntBytes(senderKeyId);
    Uint8List bReceiverKeyId = getIntBytes(receiverKeyId);

    e2eeLog("encryptE2EEMessageByDataSenderKeyId", bSenderKeyId);
    e2eeLog("encryptE2EEMessageByDataReceiverKeyId", bReceiverKeyId);

    return [salt, encdata, sign, bSenderKeyId, bReceiverKeyId];
  }

  List<dynamic> encryptE2EELocationMessage(
    int senderKeyId,
    int receiverKeyId,
    Uint8List keydata,
    int specVersion,
    LINETypes.Location location,
    String to,
    String from,
  ) {
    Uint8List salt = generateRandomBytes(16);
    Uint8List gcmKey = getSHA256Sum([keydata, salt, utf8.encode("Key")]);
    Uint8List aad = generateAAD(
      to, from, senderKeyId, receiverKeyId, e: specVersion, f: 15
    );
    Uint8List sign = generateRandomBytes(12);
    Uint8List data = utf8.encode(jsonEncode({ "location": location }));
    dynamic encData = encryptE2EEMessageV2(data, gcmKey, sign, aad);

    Uint8List bSenderKeyId = getIntBytes(senderKeyId);
    Uint8List bReceiverKeyId = getIntBytes(receiverKeyId);

    e2eeLog("encryptE2EETextMessageSenderKeyId", bSenderKeyId);
    e2eeLog("encryptE2EETextMessageReceiverKeyId", bReceiverKeyId);

    return [salt, encData, sign, bSenderKeyId, bReceiverKeyId];
  }

  Uint8List encryptE2EEMessageV2(Uint8List data, Uint8List gcmKey, Uint8List nonce, Uint8List aad) {
    e2eeLog("createCipheriv", { data, gcmKey, nonce, aad });
    Uint8List encrypted = encryptAesGcm(gcmKey, nonce, aad, data);
    return encrypted;
  }

  Future<LINETypes.Message> decryptE2EEMessage(LINETypes.Message messageObj) async {
    if ((messageObj.contentType == "NONE" || messageObj.contentType == LINETypes.ContentType.NONE) && messageObj.chunks.isNotEmpty) {
      List decrypted = await decryptE2EETextMessage(messageObj);
      String text = decrypted[0];
      Map meta = decrypted[1];
      messageObj.text = text;
      messageObj.contentMetadata.addAll(meta as Map<String, String>);
    } else if ((messageObj.contentType == "LOCATION" || messageObj.contentType == LINETypes.ContentType.LOCATION) && messageObj.chunks.isNotEmpty) {
      messageObj.location = await decryptE2EELocationMessage(messageObj) as LINETypes.Location;
    }
    return messageObj;
  }

  Future<List> decryptE2EETextMessage(LINETypes.Message messageObj, {bool isSelf = false}) async {
    String from = messageObj.from;
    String to = messageObj.to;
    if (from == client.profile?.mid) {
      isSelf = true;
    }
    dynamic toType = messageObj.toType;
    Map metadata = messageObj.contentMetadata;
    String specVersion = metadata["e2eeVersion"] ?? "2";
    dynamic contentType = messageObj.contentType;
    dynamic chunks = messageObj.chunks.map((chunk) => chunk is String ? utf8.encode(chunk) : chunk as Uint8List);

    int senderKeyId = byte2int(chunks[3]);
    int receiverKeyId = byte2int(chunks[4]);
    e2eeLog("decryptE2EETextMessageSenderKeyId", senderKeyId);
    e2eeLog("decryptE2EETextMessageReceiverKeyId", receiverKeyId);

    Map selfKey = await getE2EESelfKeyData(client.profile!.mid);
    Uint8List privK = base64.decode(selfKey["privKey"]);
    dynamic pubK;

    if (toType == LINETypes.MIDType.USER || toType == "USER" || toType == LINETypes.MIDType.USER.value) {
      pubK = await getE2EELocalPublicKey(isSelf ? to : from, isSelf ? receiverKeyId : senderKeyId);
    } else {
      Map groupK = await getE2EELocalPublicKey(to, receiverKeyId);
      privK = base64.decode(groupK["privKey"]);
      pubK = base64.decode(groupK["pubKey"]);
      if (from != client.profile?.mid) {
        pubK = await getE2EELocalPublicKey(from, senderKeyId);
      }
    }

    dynamic decrypted;
    if (specVersion == "2") {
      decrypted = await decryptE2EEMessageV2(
        to, from, chunks, privK, pubK, specVersion: int.parse(specVersion), contentType: contentType as int
      );
    } else {
      decrypted = await decryptE2EEMessageV1(chunks, privK, pubK);
    }
    String text = decrypted.text ?? "";
    Map meta = {};
    for (var key in decrypted.keys) {
      if (key == "text") {
        continue;
      }
      if (decrypted.containsKey(key)) {
        dynamic val = decrypted[key];
        if (val is String) {
          meta[key] = val;
        } else {
          meta[key] = jsonEncode(val);
        }
      }
    }
    return [text, meta];
  }

  Future<LINETypes.Location?> decryptE2EELocationMessage(LINETypes.Message messageObj, { bool isSelf = true }) async {
    String from = messageObj.from;
    String to = messageObj.to;
    dynamic toType = messageObj.toType;
    Map metadata = messageObj.contentMetadata;
    String specVersion = metadata["e2eeVersion"] ?? "2";
    dynamic contentType = messageObj.contentType;
    dynamic chunks = messageObj.chunks.map((chunk) => chunk is String ? utf8.encode(chunk) : chunk as Uint8List);
    int senderKeyId = byte2int(chunks[3]);
    int receiverKeyId = byte2int(chunks[4]);
    e2eeLog("decryptE2EELocationMessageSenderKeyId", senderKeyId);
    e2eeLog("decryptE2EELocationMessageReceiverKeyId", receiverKeyId);

    Map selfKey = await getE2EESelfKeyData(client.profile!.mid);
    Uint8List privK = base64.decode(selfKey["privKey"]);
    dynamic pubK;

    if (toType == LINETypes.MIDType.USER || toType == "USER" || toType == LINETypes.MIDType.USER.value) {
      pubK = await getE2EELocalPublicKey(to, isSelf ? receiverKeyId : senderKeyId);
    } else {
      Map groupK = await getE2EELocalPublicKey(to, receiverKeyId);
      privK = base64.decode(groupK["privKey"]);
      pubK = base64.decode(groupK["pubKey"]);
      if (from != client.profile!.mid) {
        pubK = await getE2EELocalPublicKey(from, senderKeyId);
      }
    }
    dynamic decrypted;
    if (specVersion == "2") {
      decrypted = await decryptE2EEMessageV2(to, from, chunks, privK, pubK, specVersion:int.parse(specVersion), contentType: contentType as int);
    } else {
      decrypted = await decryptE2EEMessageV1(chunks, privK, pubK);
    }
    return decrypted.location;
  }

  Future<Map?> decryptE2EEDataMessage(LINETypes.Message messageObj, { bool isSelf = true }) async {
    String from = messageObj.from;
    String to = messageObj.to;
    dynamic toType = messageObj.toType;
    Map metadata = messageObj.contentMetadata;
    String specVersion = metadata["e2eeVersion"] ?? "2";
    dynamic contentType = messageObj.contentType;
    dynamic chunks = messageObj.chunks.map((chunk) => chunk is String ? utf8.encode(chunk) : chunk as Uint8List);
    int senderKeyId = byte2int(chunks[3]);
    int receiverKeyId = byte2int(chunks[4]);
    e2eeLog("decryptE2EEDataMessageSenderKeyId", senderKeyId);
    e2eeLog("decryptE2EEDataMessageReceiverKeyId", receiverKeyId);

    Map selfKey = await getE2EESelfKeyData(client.profile!.mid);
    Uint8List privK = base64.decode(selfKey["privKey"]);
    dynamic pubK;

    if (toType == LINETypes.MIDType.USER || toType == "USER" || toType == LINETypes.MIDType.USER.value) {
      pubK = await getE2EELocalPublicKey(to, isSelf ? receiverKeyId : senderKeyId);
    } else {
      Map groupK = await getE2EELocalPublicKey(to, receiverKeyId);
      privK = base64.decode(groupK["privKey"]);
      pubK = base64.decode(groupK["pubKey"]);
      if (from != client.profile!.mid) {
        pubK = await getE2EELocalPublicKey(from, senderKeyId);
      }
    }
    dynamic decrypted;
    if (specVersion == "2") {
      decrypted = await decryptE2EEMessageV2(to, from, chunks, privK, pubK, specVersion: int.parse(specVersion), contentType: contentType as int);
    } else {
      decrypted = await decryptE2EEMessageV1(chunks, privK, pubK);
    }
    return decrypted ?? {};
  }

  Future<dynamic> decryptE2EEMessageV1(List chunks, Uint8List privK, Uint8List pubK) async {
    e2eeLog("decryptE2EEMessageV1_arg", { chunks, privK, pubK });
    Uint8List salt = chunks[0];
    Uint8List message = chunks[1];
    Uint8List aesKey = await generateSharedSecret(privK, pubK);
    aesKey = getSHA256Sum([aesKey, salt, "Key"]);
    Uint8List aesIv = xor(
      getSHA256Sum([aesKey, salt, "IV"])
    );
    e2eeLog("decryptE2EEMessageV1", { aesKey, aesIv, message });
    dynamic decrypted;
    try {
      decrypted = decryptAESCBC(key: aesKey, iv: aesIv, ciphertext: message);
    } catch (_e) {
      decrypted = decryptAESCBC(key: aesKey, iv: aesIv, ciphertext: message, setAutoPadding: false);
    }
    e2eeLog("decryptE2EEMessageV1DecryptedMessage", utf8.decode(decrypted));
    return jsonDecode(utf8.decode(decrypted));
  }

  Future<dynamic> decryptE2EEMessageV2(String to, String from, List chunks, Uint8List privK, Uint8List pubK, { int specVersion = 2, int contentType = 0}) async {
    Uint8List salt = chunks[0];
    Uint8List message = chunks[1];
    Uint8List ciphertext = message.sublist(0, message.length - 16);
    Uint8List tag = message.sublist(-16);
    Uint8List sign = chunks[2];
    int senderKeyId = byte2int(chunks[3]);
    int receiverKeyId = byte2int(chunks[4]);
    Uint8List aesKey = await generateSharedSecret(privK, pubK);
    Uint8List gcmKey = getSHA256Sum([aesKey, salt, "Key"]);
    Uint8List aad = generateAAD(
      to, from, senderKeyId, receiverKeyId, e: specVersion, f: contentType
    );

    dynamic decrypted;
    try {
      Uint8List decrypted = decryptAesGcm(key: gcmKey, nonce: sign, aad: aad, ciphertext: message, tag: tag);
    } catch (error) {
      if (error is InternalError) {
        e2eeLog("decryptE2EEMessageV2DecryptionFailed", error.message);
      }
      rethrow;
    }
    e2eeLog("decryptE2EEMessageV2DecryptedMessage", decrypted);
    return jsonDecode(utf8.decode(decrypted));
  }

  void e2eeLog(String type, dynamic message) {
    client.log("e2ee", { "type": type, "message": message });
  }

  Future<List> createSqrSecret([bool base64Only = false]) async {
    dynamic algorithm = X25519();
    dynamic keyPair = await algorithm.newKeyPair();
    dynamic publicKey = await keyPair.extractPublicKey();

    dynamic secretKeyBytes = await keyPair.extractPrivateKeyBytes();
    dynamic publicKeyBytes = publicKey.bytes;

    String publicKeyBase64 = base64.encode(publicKeyBytes);
    String secret = Uri.encodeComponent(publicKeyBase64);
    int version = 1;

    if (base64Only) {
      return [secretKeyBytes, publicKeyBase64];
    }

    return [
      secretKeyBytes,
      "?secret=$secret&e2eeVersion=$version"
    ];
  }

  Future<Uint8List> _encryptAESCTR(Uint8List aesKey, Uint8List nonce, Uint8List data) async {
    final algorithm = AesCtr.with256bits(macAlgorithm: MacAlgorithm.empty);
    final secretKey = SecretKey(aesKey);

    final encrypted = await algorithm.encrypt(
      data,
      secretKey: secretKey,
      nonce: nonce,
    );

    return Uint8List.fromList(encrypted.cipherText);
  }

  Future<Uint8List> __encryptAESCTR(Uint8List aesKey, Uint8List nonce, Uint8List data) async {
    return await _encryptAESCTR(aesKey, nonce, data);
  }

  Future<Uint8List> ___encryptAESCTR(Uint8List aesKey, Uint8List nonce, Uint8List data) async {
    return await _encryptAESCTR(aesKey, nonce, data);
  }

  Future<Uint8List> _decryptAESCTR(
  Uint8List aesKey,
  Uint8List nonce,
  Uint8List data,
  ) async {
    final algorithm = AesCtr.with256bits(macAlgorithm: MacAlgorithm.empty);
    final secretKey = SecretKey(aesKey);

    final decrypted = await algorithm.decrypt(
      SecretBox(data, nonce: nonce, mac: Mac.empty),
      secretKey: secretKey,
    );

    return Uint8List.fromList(decrypted);
  }

  Future<Uint8List> __decryptAESCTR(
    Uint8List aesKey,
    Uint8List nonce,
    Uint8List data,
  ) async {
    return await _decryptAESCTR(aesKey, nonce, data);
  }

  Future<Uint8List> signData(Uint8List data, Uint8List key) async {
    final hmac = Hmac.sha256();
    final mac = await hmac.calculateMac(data, secretKey: SecretKey(key));
    return Uint8List.fromList(mac.bytes);
  }

  Future<Map<String, Uint8List>> deriveKeyMaterial(Uint8List keyMaterial) async {
    final hkdf = Hkdf(outputLength: 76, hmac: Hmac.sha256());
    final info = Uint8List.fromList('FileEncryption'.codeUnits);
    final derivedKey = await hkdf.deriveKey(
      secretKey: SecretKey(keyMaterial),
      info: info,
    );
    final derivedBytes = await derivedKey.extractBytes();

    return {
      'encKey': Uint8List.sublistView(derivedBytes as TypedData, 0, 32),
      'macKey': Uint8List.sublistView(derivedBytes as TypedData, 32, 64),
      'nonce': Uint8List.fromList([
        ...derivedBytes.sublist(64, 76),
        0, 0, 0, 0
      ]),
    };
  }

  Future<Map<String, dynamic>> encryptByKeyMaterial(
      Uint8List rawData, [
      Uint8List? keyMaterial,
    ]) async {
    keyMaterial ??= Uint8List(32);

    final keys = await deriveKeyMaterial(keyMaterial);
    final encData = await ___encryptAESCTR(keys['encKey']!, keys['nonce']!, rawData);
    final sign = await signData(encData, keys['macKey']!);

    return {
      'keyMaterial': base64Encode(keyMaterial),
      'encryptedData': Uint8List.fromList([...encData, ...sign]),
    };
  }

  Future<Uint8List> decryptByKeyMaterial(Uint8List rawData, dynamic keyMaterial) async {
    Uint8List keyMat;
    if (keyMaterial is String) {
      keyMat = base64Decode(keyMaterial);
    } else if (keyMaterial is Uint8List) {
      keyMat = keyMaterial;
    } else {
      throw ArgumentError('Invalid keyMaterial type');
    }

    final keys = await deriveKeyMaterial(keyMat);
    final decrypted = await __decryptAESCTR(keys['encKey']!, keys['nonce']!, rawData);
    return decrypted.sublist(0, decrypted.length - 32);
  }

}

int byte2int(Uint8List t) {
  int e = 0;
  int s = t.length;
  for (int i = 0; i < s; i++) {
    e = 256 * e + t[i];
  }
  return e;
}

Uint8List _bin2bytes(String k) {
  List<int> e = [];
  for (int i = 0; i < k.length / 2; i++) {
    int i0 = int.parse(k.substring(i * 2, i * 2 + 2), radix: 16);
    e.add(i0);
  }
  return Uint8List.fromList(e);
}