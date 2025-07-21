import 'dart:typed_data';
import 'package:pointycastle/export.dart';
import 'dart:math';

Uint8List decryptAESCBC({
  required Uint8List key,
  required Uint8List iv,
  required Uint8List ciphertext,
  bool setAutoPadding = true,
}) {
  final cipher = CBCBlockCipher(AESEngine())
    ..init(false, ParametersWithIV(KeyParameter(key), iv));

  final paddedPlainText = Uint8List(ciphertext.length);
  for (int offset = 0; offset < ciphertext.length; offset += cipher.blockSize) {
    cipher.processBlock(ciphertext, offset, paddedPlainText, offset);
  }

  if (setAutoPadding) {
    return _removePKCS7Padding(paddedPlainText);
  } else {
    return paddedPlainText;
  }
}

Uint8List _removePKCS7Padding(Uint8List data) {
  final pad = data.last;
  return data.sublist(0, data.length - pad);
}

Uint8List generateRandomBytes(int length) {
  final random = Random.secure();
  return Uint8List.fromList(
    List<int>.generate(length, (_) => random.nextInt(256)),
  );
}

Uint8List encryptAesGcm(Uint8List key, Uint8List nonce, Uint8List aad, Uint8List data) {
  final cipher = GCMBlockCipher(AESEngine());

  final aeadParameters = AEADParameters(KeyParameter(key), 128, nonce, aad);

  cipher.init(true, aeadParameters);

  final encrypted = cipher.process(data);

  return encrypted;
}

Uint8List decryptAesGcm({
  required Uint8List key,
  required Uint8List nonce,
  required Uint8List aad,
  required Uint8List ciphertext,
  required Uint8List tag,
}) {
  final cipher = GCMBlockCipher(AESEngine());

  final combined = Uint8List(ciphertext.length + tag.length)
    ..setAll(0, ciphertext)
    ..setAll(ciphertext.length, tag);

  final aeadParams = AEADParameters(KeyParameter(key), 128, nonce, aad);

  cipher.init(false, aeadParams);

  try {
    return cipher.process(combined);
  } catch (e) {
    throw Exception("Decryption failed: ${e.toString()}");
  }
}