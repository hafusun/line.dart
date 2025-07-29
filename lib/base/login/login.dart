import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' hide BaseClient;
import '../core/utils/devices.dart';
import '../core/utils/error.dart';

import '../core/core.dart';
import './regex.dart';
import '../../thrift/line_types.dart' as LINETypes;
import './rsa-verify.dart';

class Login {
  BaseClient client;
  String? cert;
  String? qrCert;

  Login(this.client, [this.cert, this.qrCert]);

  Future<void> registerCert(String cert, String email) async {
    return await client.storage.set("cert:$email", cert);
  }

  Future<String?> getCert(String email) async {
    return await client.storage.get("cert:$email");
  }

  Future<void> registerQrCert(String qrCert) async {
    return await client.storage.set("qrCert", qrCert);
  }

  Future<String?> getQrCert() async {
    return await client.storage.get("qrCert");
  }

  Future<void> ready() async {
    if (client.authToken == null || client.authToken == "") {
      throw InternalError("NotAuthorized", "try login first");
    }
    client.profile = LINETypes.Profile.fromJson(await client.talk.getProfile({}));
    client.emit("ready", { "profile": client.profile });
  }

  Future<dynamic> login({String? authToken, String? email, String? password, String? pincode, bool? v3, bool? e2ee, bool? qr}) async {
    if (authToken == null && email == null && password == null) {
      await withQrCode();
    } else if (qr != null && qr) {
      await withQrCode(v3: v3 ?? false);
    } else if (authToken != null) {
      client.emit("update:authToken", { "authToken": authToken });
      client.authToken = authToken;
    } else if (email != null) {
      await withPassword(email: email, password: password, pincode: pincode, v3: v3, e2ee: e2ee);
    } else {
      await withQrCode();
    }
    await ready();
  }

  Future<void> withQrCode({bool? v3}) async {
    String authToken;
    if (v3 == null) {
      if (isV3Support(client.deviceDetails.device)) {
        authToken = await requestSQR2();
      } else {
        authToken = await requestSQR();
      }
    } else {
      if (v3) {
        authToken = await requestSQR2();
      } else {
        authToken = await requestSQR();
      }
    }
    client.emit("update:authToken", { "authToken": authToken });
    client.authToken = authToken;
  }

  Future<String> requestSQR() async {
    LINETypes.CreateSessionResponse session = await createSession();
    String sqr = session.sessionId;
    Map cQR = await createQrCode(sqr);
    String url = cQR[1];
    List SqrSecret = await client.e2ee.createSqrSecret();
    Uint8List secret = SqrSecret[0];
    String secretUrl = SqrSecret[1];
    url = url + secretUrl;
    client.emit("qrcall", { "url": url });
    if (await checkQrCodeVerified(sqr)) {
      try {
        await verifyCertificate(sqr, await getQrCert());
      } catch(_e) {
        Map createPin = await createPinCode(sqr);
        String pincode = createPin[1];
        client.emit("pincall", { "pincode": pincode });
        await checkPinCodeVerified(sqr);
      }
      dynamic response = await qrCodeLogin(sqr);
      dynamic pem = response[1];
      String authToken = response[2];
      dynamic e2eeInfo = response[4];
      if (pem != null) {
        client.emit("update:qrcert", { "cert": pem });
        await registerQrCert(pem);
      }
      if (e2eeInfo != null) {
        await client.e2ee.decodeE2EEKeyV1(e2eeInfo, secret);
      }
      return authToken;
    }
    throw InternalError("TimeoutError", "checkQrCodeVerified timed out");
  }

  Future<String> requestSQR2() async {
    LINETypes.CreateSessionResponse session = await createSession();
    String sqr = session.sessionId;
    Map cQR = await createQrCode(sqr);
    String url = cQR[1];
    List createSecret = await client.e2ee.createSqrSecret();
    Uint8List secret = createSecret[0];
    String secretUrl = createSecret[1];
    url = url + secretUrl;
    client.emit("qrcall", { "url" : url });
    if (await checkQrCodeVerified(sqr)) {
      try {
        await verifyCertificate(sqr, await getQrCert());
      } catch(_e) {
        Map createPin = await createPinCode(sqr);
        String pincode = createPin[1];
        client.emit("pincall", { "pincode": pincode });
        await checkPinCodeVerified(sqr);
      }
      Map response = await qrCodeLoginV2(sqr);
      String? pem = response[1];
      Map? tokenInfo = response[3];
      dynamic e2eeInfo = response[10];
      if (pem != null) {
        client.emit("update:qrcert", { "cert": pem });
        await registerQrCert(pem);
      }
      if (e2eeInfo != null) {
        await client.e2ee.decodeE2EEKeyV1(e2eeInfo, secret);
      }
      await client.storage.set("refreshToken", tokenInfo![2]);
      await client.storage.set("expire", tokenInfo[3] + tokenInfo[6]);
      return tokenInfo[1];
    }
    throw InternalError("TimeoutError", "checkQrCodeVerified timed out");
  }

  Future<void> withPassword({String? email, String? password, String? pincode, bool? v3, bool? e2ee}) async {
    String authToken;
    if (email != null && !EMAIL_REGEX.hasMatch(email)) {
      throw InternalError("RegExpUnmatch", "Invalid email");
    }
    if (password != null && !PASSWORD_REGEX.hasMatch(password)) {
      throw InternalError("RegExpUnmatch", "Invalid password");
    }
    if (v3 == null) {
      if (isV3Support(client.deviceDetails.device)) {
        authToken = await requestEmailLoginV2(
          email: email!,
          password: password!,
          pincode: pincode
        );
      } else {
        authToken = await requestEmailLogin(
          email: email!,
          password: password!,
          pincode: pincode,
          e2ee: e2ee
        );
      }
    } else {
      if (v3) {
        authToken = await requestEmailLoginV2(
          email: email!,
          password: password!,
          pincode: pincode,
        );
      } else {
        authToken = await requestEmailLogin(
          email: email!,
          password: password!,
          pincode: pincode,
          e2ee: e2ee
        );
      }
    }
    client.emit("update:authtoken", { "authToken": authToken });
    client.authToken = authToken;
  }

  Future<String> requestEmailLogin({required String email, required String password, String? pincode, bool? e2ee}) async {
    e2ee = e2ee ?? true;
    pincode = pincode ?? "123456";
    if (pincode.length != 6) {
      throw InternalError("Invalid constant pincode", "The constant pincode should be 6 digits");
    }

    client.log("login", { "method": "email_v1", "email": email, "password": password.length, "enableE2EE": e2ee, "constantPincode": pincode });

    LINETypes.RSAKey rsaKey = await getRSAKeyInfo();
    String? keynm = rsaKey.keynm;
    String? sessionKey = rsaKey.sessionKey;

    String message = String.fromCharCode(sessionKey.length) +
      sessionKey +
      String.fromCharCode(email.length) +
      email +
      String.fromCharCode(password.length) +
      password;
    Uint8List? e2eeData;
    Uint8List? secret;
    String? secretPK;
    Map response;
    if (e2ee) {
      List createSqr = await client.e2ee.createSqrSecret(true);
      secret = createSqr[0];
      secretPK = createSqr[1];
      e2eeData = client.e2ee.encryptAESECB(
        client.e2ee.getSHA256Sum([pincode]),
        base64.decode(secretPK!)
      );
    }
    String encryptedMessage = getRSACrypto(message, rsaKey)["credentials"] as String;

    String? cert = await getCert(email);

    response = await loginV2(
      keynm,
      encryptedMessage,
      client.deviceDetails.device,
      null,
      e2eeData,
      cert,
      "loginZ"
    );

    if (response["authToken"] == null) {
      client.emit("pincall", { "pincode": response["pinCode"] ?? pincode });
      if (e2ee && secret != null && secret.isNotEmpty) {
        Map<String, String> headers = {
          "user-agent": client.request.userAgent,
          "x-line-application": client.request.systemType,
          "x-line-access": response["verifier"],
          "x-lal": "ja_JP",
          "x-lpv": "1",
          "x-lhm": "GET",
          "accept-encoding": "gzip"
        };
        Response res = await client.fetch(
          "https://${client.request.endpoint}/LF1",
          headers: headers,
          timeout: 180000
        ).timeout(Duration(minutes: 3));
        Map result = jsonDecode(res.body);
        dynamic e2eeInfo = result["result"];
        client.log("response", e2eeInfo);
        await client.e2ee.decodeE2EEKeyV1(
          e2eeInfo["metadata"],
          secret
        );
        Uint8List deviceSecret = await client.e2ee.encryptDeviceSecret(
          base64.decode(e2eeInfo["metadata"]["publicKey"]),
          secret,
          base64.decode(e2eeInfo["metadata"]["encryptedKeyChain"])
        );
        dynamic e2eeLogin = await confirmE2EELogin(response["verifier"], deviceSecret);
        response = await loginV2(
          keynm,
          encryptedMessage,
          client.deviceDetails.device,
          e2eeLogin,
          e2eeData,
          cert,
          "loginZ"
        );
      } else {
        Map<String, String> headers = {
          "accept": "application/x-thrift",
          "user-agent": client.request.userAgent,
          "x-line-application": client.request.systemType,
          "x-line-access": response["verifier"],
          "x-lal": "ja_JP",
          "x-lpv": "1",
          "x-lhm": "GET",
          "accept-encoding": "gzip"
        };
        Response r = await client.fetch(
          "https://${client.request.endpoint}/Q",
          headers: headers,
          timeout: 180000
        );
        Map verifier = jsonDecode(r.body);
        client.log("response", verifier);
        response = await loginV2(
          keynm,
          encryptedMessage,
          client.deviceDetails.device,
          verifier["result"]["verifier"],
          e2eeData,
          cert,
          "loginZ"
        );
      }
    }
    if (response["certificate"] != null) {
      client.emit("update:cert", { "cert": response["certificate"] });
      await registerCert(response["certificate"], email);
    }
    return response["authToken"]!;
  }

  Future<String> requestEmailLoginV2({ required String email, required String password, String? pincode}) async {
    pincode = pincode ?? "123456";
    if ((pincode).length != 6) {
      throw InternalError("Invalid constant pincode", "The constant pincode should be 6 digits");
    }
    client.log("login", { "method": "email", "email": email, "password": password.length, "constantPincode": pincode });
    LINETypes.RSAKey rsaKey = await getRSAKeyInfo();
    String? keynm = rsaKey.keynm;
    String? sessionKey = rsaKey.sessionKey;
    String message = String.fromCharCode(sessionKey.length) +
      sessionKey +
      String.fromCharCode(email.length) +
      email +
      String.fromCharCode(password.length) +
      password;

    List createSqr = await client.e2ee.createSqrSecret(true);
    Uint8List secret = createSqr[0];
    String secretPK = createSqr[1];
    Uint8List e2eeData = client.e2ee.encryptAESECB(
      client.e2ee.getSHA256Sum([pincode]),
      base64.decode(secretPK)
    );

    String encryptedMessage = getRSACrypto(message, rsaKey)["credentials"] as String;
    String? cert = await getCert(email);

    dynamic response = await loginV2(
      keynm,
      encryptedMessage,
      client.deviceDetails.device,
      null,
      e2eeData,
      cert,
      "loginV2"
    );

    if (response[9] == null) {
      client.emit("pincall", { "pincode": pincode });
      Map<String, String> headers = {
        "accept": "application/x-thrift",
        "user-agent": client.request.userAgent,
        "x-line-application": client.request.systemType,
        "x-line-access": response[3],
        "x-lal": "ja_JP",
        "x-lpv": "1",
        "x-lhm": "GET",
        "accept-encoding": "gzip"
      };
      Response r = await client.fetch(
        "https://${client.request.endpoint}/LF1",
        headers: headers
      );
      Map e2eeInfo = jsonDecode(r.body);
      client.log("response", e2eeInfo);
      await client.e2ee.decodeE2EEKeyV1(e2eeInfo["metadata"], secret);
      Uint8List deviceSecret = await client.e2ee.encryptDeviceSecret(
        base64.decode(e2eeInfo["metadata"]["publicKey"]),
        secret,
        base64.decode(e2eeInfo["metadata"]["encryptedKeyChain"])
      );
      dynamic e2eeLogin = await confirmE2EELogin(
        response[3],
        deviceSecret
      );
      response = await loginV2(
        keynm,
        encryptedMessage,
        client.deviceDetails.device,
        e2eeLogin,
        e2eeData,
        cert,
        "loginV2"
      );
    }
    if (response[2] != null) {
      client.emit("update:cert", { "cert": response[2] });
      await registerCert(response[2], email);
    }
    await client.storage.set("refreshToken", response[9][2]);
    await client.storage.set("expire", response[9][3] + response[9][6]);
    return response[9][1];
  }

  Future<LINETypes.RSAKey> getRSAKeyInfo([int provider = 0]) async {
    return LINETypes.RSAKey.fromJson(
      await client.request.request(
        [[12, 1, [[8, 2, provider]]]],
        "getRSAKeyInfo",
        3,
        "RSAKey",
        "/api/v3/TalkService.do"
      )
    );
  }

  Future<dynamic> loginV2(String keynm, String encryptedMessage, String device, String? verifier, Uint8List? secret, String? cert, String methodName) async {
    int loginType = 2;
    if (secret == null) loginType = 0;
    if (verifier != null) loginType = 1;
    return await client.request.request(
      [
        [
          12, 2, [
            [8, 1, loginType],
            [8, 2, 1],
            [11, 3, keynm],
            [11, 4, encryptedMessage],
            [2, 5, 0],
            [11, 6, ""],
            [11, 7, device],
            [11, 8, cert ?? ""],
            [11, 9, verifier ?? ""],
            [11, 10, secret ?? ""],
            [8, 11, 1],
            [11, 12, "System Product Name"]
          ]
        ]
      ],
      methodName,
      3,
      methodName == "loginZ" ? "LoginResult" : false,
      "/api/v3p/rs"
    );
  }

  Future<LINETypes.CreateSessionResponse> createSession() async {
    return LINETypes.CreateSessionResponse.fromJson(
      await client.request.request(
        [],
        "createSession",
        4,
        false,
        "/acct/lgn/sq/v1"
      )
    );
  }

  Future<Map> createQrCode(String qrcode) async {
    return await client.request.request(
      [[12, 1, [[11, 1, qrcode]]]],
      "createQrCode",
      4,
      false,
      "/acct/lgn/sq/v1"
    );
  }

  Future<bool> checkQrCodeVerified(String qrcode) async {
    try {
      await client.request.request(
        [[12, 1, [[11, 1, qrcode]]]],
        "checkQrCodeVerified",
        4,
        false,
        "/acct/lp/lgn/sq/v1",
        { "x-lst": "180000", "x-line-access": qrcode },
        client.config.longTimeout
      );
      return true;
    } catch(error) {
      rethrow;
    }
  }

  Future<dynamic> verifyCertificate(String qrcode, [String? cert]) async {
    return await client.request.request(
      [[12, 1, [[11, 1, qrcode], [11, 2, cert]]]],
      "verifyCertificate",
      4,
      false,
      "/acct/lgn/sq/v1"
    );
  }

  Future<dynamic> createPinCode(String qrcode) async {
    return await client.request.request(
      [[12, 1, [[11, 1, qrcode]]]],
      "createPinCode",
      4,
      false,
      "/acct/lgn/sq/v1"
    );
  }

  Future<bool> checkPinCodeVerified(String qrcode) async {
    try {
      await client.request.request(
        [[12, 1, [[11, 1, qrcode]]]],
        "checkPinCodeVerified",
        4,
        false,
        "/acct/lp/lgn/sq/v1",
        { "x-lst": "180000", "x-line-access": qrcode },
        client.config.longTimeout,
      );
      return true;
    } catch(error) {
      rethrow;
    }
  }

  Future<dynamic> qrCodeLogin(String authSessionId, [bool autoLoginIsRequired = true]) async {
    return await client.request.request(
      [[12, 1, [
        [11, 1, authSessionId],
        [11, 2, client.deviceDetails.device],
        [2, 3, autoLoginIsRequired]
      ]]],
      "qrCodeLogin",
      4,
      false,
      "/acct/lgn/sq/v1"
    );
  }

  Future<dynamic> qrCodeLoginV2(String authSessionId, [String modelName = "hafusun", String systemName = "linedart", bool autoLoginIsRequired = true]) async {
    return await client.request.request(
      [[12, 1, [
        [11, 1, authSessionId],
        [11, 2, systemName],
        [11, 3, modelName],
        [2, 4, autoLoginIsRequired]
      ]]],
      "qrCodeLoginV2",
      4,
      false,
      "/acct/lgn/sq/v1"
    );
  }

  Future<dynamic> confirmE2EELogin(String verifier, Uint8List deviceSecret) async {
    return await client.request.request(
      [
        [11, 1, verifier],
        [11, 2, deviceSecret]
      ],
      "confirmE2EELogin",
      3,
      false,
      "/api/v3p/rs"
    );
  }
}