import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' hide BaseClient;
import 'package:linedart/base/core/utils/devices.dart';
import 'package:linedart/base/core/utils/error.dart';

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
    return await this.client.storage.set("cert:" + email, cert);
  }

  Future<String?> getCert(String email) async {
    return await this.client.storage.get("cert:" + email);
  }

  Future<void> registerQrCert(String qrCert) async {
    return await this.client.storage.set("qrCert", qrCert);
  }

  Future<String?> getQrCert() async {
    return await this.client.storage.get("qrCert");
  }

  Future<void> ready() async {
    if (this.client.authToken == null || this.client.authToken == "") {
      throw new InternalError("NotAuthorized", "try login first");
    }
    this.client.profile = await this.client.talk.getProfile({});
    this.client.emit("ready", this.client.profile);
  }

  Future<dynamic> login({String? authToken, String? email, String? password, String? pincode, bool? v3, bool? e2ee, bool? qr}) async {
    if (authToken == null && email == null && password == null) {
      await this.withQrCode();
    } else if (qr != null && qr) {
      await this.withQrCode(v3: v3 ?? false);
    } else if (authToken != null) {
      this.client.emit("update:authToken", authToken);
      this.client.authToken = authToken;
    } else if (email != null) {
      await this.withPassword(email: email, password: password, pincode: pincode, v3: v3, e2ee: e2ee);
    } else {
      await this.withQrCode();
    }
    await this.ready();
  }

  Future<void> withQrCode({bool? v3}) async {
    String authToken;
    if (v3 == null) {
      if (isV3Support(this.client.device)) {
        authToken = await this.requestSQR2();
      } else {
        authToken = await this.requestSQR();
      }
    } else {
      if (v3) {
        authToken = await this.requestSQR2();
      } else {
        authToken = await this.requestSQR();
      }
    }
    this.client.emit("update:authToken", authToken);
    this.client.authToken = authToken;
  }

  Future<String> requestSQR() async {
    LINETypes.CreateSessionResponse session = await this.createSession();
    String sqr = session.sessionId;
    Map cQR = await this.createQrCode(sqr);
    String url = cQR[1];
    List SqrSecret = await this.client.e2ee.createSqrSecret();
    Uint8List secret = SqrSecret[0];
    String secretUrl = SqrSecret[1];
    url = url + secretUrl;
    this.client.emit("qrcall", url);
    if (await this.checkQrCodeVerified(sqr)) {
      try {
        await this.verifyCertificate(sqr, await this.getQrCert());
      } catch(_e) {
        Map createPin = await this.createPinCode(sqr);
        String pincode = createPin[1];
        this.client.emit("pincall", pincode);
        await this.checkPinCodeVerified(sqr);
      }
      dynamic response = await this.qrCodeLogin(sqr);
      dynamic pem = response[1];
      String authToken = response[2];
      dynamic e2eeInfo = response[4];
      if (pem != null) {
        this.client.emit("update:qrcert", pem);
        await this.registerQrCert(pem);
      }
      if (e2eeInfo != null) {
        await this.client.e2ee.decodeE2EEKeyV1(e2eeInfo, secret);
      }
      return authToken;
    }
    throw new InternalError("TimeoutError", "checkQrCodeVerified timed out");
  }

  Future<String> requestSQR2() async {
    LINETypes.CreateSessionResponse session = await this.createSession();
    String sqr = session.sessionId;
    Map cQR = await this.createQrCode(sqr);
    String url = cQR[1];
    List createSecret = await this.client.e2ee.createSqrSecret();
    Uint8List secret = createSecret[0];
    String secretUrl = createSecret[1];
    url = url + secretUrl;
    this.client.emit("qrcall", url);
    if (await this.checkQrCodeVerified(sqr)) {
      try {
        await this.verifyCertificate(sqr, await this.getQrCert());
      } catch(_e) {
        Map createPin = await this.createPinCode(sqr);
        String pincode = createPin[1];
        this.client.emit("pincall", pincode);
        await this.checkPinCodeVerified(sqr);
      }
      Map response = await this.qrCodeLoginV2(sqr);
      String? pem = response[1];
      Map? tokenInfo = response[3];
      dynamic e2eeInfo = response[10];
      if (pem != null) {
        this.client.emit("update:qrcert", pem);
        await this.registerQrCert(pem);
      }
      if (e2eeInfo != null) {
        await this.client.e2ee.decodeE2EEKeyV1(e2eeInfo, secret);
      }
      await this.client.storage.set("refreshToken", tokenInfo![2]);
      await this.client.storage.set("expire", tokenInfo[3] + tokenInfo[6]);
      print(tokenInfo);
      return tokenInfo[1];
    }
    throw new InternalError("TimeoutError", "checkQrCodeVerified timed out");
  }

  Future<void> withPassword({String? email, String? password, String? pincode, bool? v3, bool? e2ee}) async {
    String authToken;
    if (email != null && !EMAIL_REGEX.hasMatch(email)) {
      throw new InternalError("RegExpUnmatch", "Invalid email");
    }
    if (password != null && !PASSWORD_REGEX.hasMatch(password)) {
      throw new InternalError("RegExpUnmatch", "Invalid password");
    }
    if (v3 == null) {
      if (isV3Support(this.client.device)) {
        authToken = await this.requestEmailLoginV2(
          email: email!,
          password: password!,
          pincode: pincode
        );
      } else {
        authToken = await this.requestEmailLogin(
          email: email!,
          password: password!,
          pincode: pincode!,
          e2ee: e2ee
        );
      }
    } else {
      if (v3) {
        authToken = await this.requestEmailLoginV2(
          email: email!,
          password: password!,
          pincode: pincode,
        );
      } else {
        authToken = await this.requestEmailLogin(
          email: email!,
          password: password!,
          pincode: pincode!,
          e2ee: e2ee
        );
      }
    }
    this.client.emit("update:authtoken", authToken);
    this.client.authToken = authToken;
  }

  Future<String> requestEmailLogin({required String email, required String password, String pincode = "123456", bool? e2ee = true}) async {
    if (pincode.length != 6) {
      throw new InternalError("Invalid constant pincode", "The constant pincode should be 6 digits");
    }

    this.client.log("login", { "method": "email_v1", "email": email, "password": password.length, "enableE2EE": e2ee, "constantPincode": pincode });

    LINETypes.RSAKey rsaKey = await this.getRSAKeyInfo();
    String keynm = rsaKey.keynm;
    String sessionKey = rsaKey.sessionKey;

    String message = String.fromCharCode(sessionKey.length) +
      sessionKey +
      String.fromCharCode(email.length) +
      email +
      String.fromCharCode(password.length) +
      password;
    Uint8List? e2eeData = null;
    Uint8List? secret;
    String? secretPK;
    Map response;
    if (e2ee!) {
      List createSqr = await this.client.e2ee.createSqrSecret(true);
      secret = createSqr[0];
      secretPK = createSqr[1];
      e2eeData = await this.client.e2ee.encryptAESECB(
        await this.client.e2ee.getSHA256Sum(pincode),
        base64.decode(secretPK!)
      );
    }
    String encryptedMessage = getRSACrypto(message, rsaKey)["credentials"] as String;

    String? cert = await this.getCert(email);

    response = await this.loginV2(
      keynm,
      encryptedMessage,
      this.client.device,
      null,
      e2eeData,
      cert,
      "loginZ"
    );

    if (!response["authToken"]) {
      this.client.emit("pincall", response["pinCode"] ?? pincode);
      if (e2ee && secret != null && secret.isNotEmpty) {
        Map<String, String> headers = {
          "user-agent": this.client.request.userAgent,
          "x-line-application": this.client.request.systemType,
          "x-line-access": response["verifier"],
          "x-lal": "ja_JP",
          "x-lpv": "1",
          "x-lhm": "GET",
          "accept-encoding": "gzip"
        };
        Response res = await this.client.fetch(
          "https://${this.client.request.endpoint}/LF1",
          headers: headers
        );
        Map result = jsonDecode(res.body);
        dynamic e2eeInfo = result["result"];
        this.client.log("response", e2eeInfo);
        await this.client.e2ee.decodeE2EEKeyV1(
          e2eeInfo["metadata"],
          secret
        );
        Uint8List deviceSecret = await this.client.e2ee.encryptDeviceSecret(
          base64.decode(e2eeInfo["metadata"]["publicKey"]),
          secret,
          base64.decode(e2eeInfo["metadata"]["encryptedKeyChain"])
        );
        dynamic e2eeLogin = await this.confirmE2EELogin(response["verifier"], deviceSecret);
        dynamic resp = await this.loginV2(
          keynm,
          encryptedMessage,
          this.client.device,
          e2eeLogin,
          e2eeData,
          cert,
          "loginZ"
        );
      } else {
        Map<String, String> headers = {
          "accept": "application/x-thrift",
          "user-agent": this.client.request.userAgent,
          "x-line-application": this.client.request.systemType,
          "x-line-access": response["verifier"],
          "x-lal": "ja_JP",
          "x-lpv": "1",
          "x-lhm": "GET",
          "accept-encoding": "gzip"
        };
        Response r = await this.client.fetch(
          "https://${this.client.request.endpoint}/Q",
          headers: headers
        );
        Map verifier = jsonDecode(r.body);
        this.client.log("response", verifier);
        response = await this.loginV2(
          keynm,
          encryptedMessage,
          this.client.device,
          verifier["result"]["verifier"],
          e2eeData,
          cert,
          "loginZ"
        );
      }
    }
    if (response["certificate"]) {
      this.client.emit("update:cert", response["certificate"]);
      await this.registerCert(response["certificate"], email);
    }
    return response["authToken"]!;
  }

  Future<String> requestEmailLoginV2({ required String email, required String password, String? pincode = "123456" }) async {
    if (pincode!.length != 6) {
      throw new InternalError("Invalid constant pincode", "The constant pincode should be 6 digits");
    }
    this.client.log("login", { "method": "email", "email": email, "password": password.length, "constantPiincode": pincode });
    LINETypes.RSAKey rsaKey = await this.getRSAKeyInfo();
    String keynm = rsaKey.keynm;
    String sessionKey = rsaKey.sessionKey;
    String message = String.fromCharCode(sessionKey.length) +
      sessionKey +
      String.fromCharCode(email.length) +
      email +
      String.fromCharCode(password.length) +
      password;

    List createSqr = await this.client.e2ee.createSqrSecret();
    Uint8List secret = createSqr[0];
    String secretPK = createSqr[1];
    Uint8List e2eeData = await this.client.e2ee.encryptAESECB(
      await this.client.e2ee.getSHA256Sum(pincode),
      base64.decode(secretPK)
    );

    String encryptedMessage = getRSACrypto(message, rsaKey)["credentials"] as String;
    String? cert = await this.getCert(email);

    dynamic response = await this.loginV2(
      keynm,
      encryptedMessage,
      this.client.device,
      null,
      e2eeData,
      cert,
      "loginV2"
    );

    if (response[9] == null) {
      this.client.emit("pincall", pincode);
      Map<String, String> headers = {
        "accept": "application/x-thrift",
        "user-agent": this.client.request.userAgent,
        "x-line-application": this.client.request.systemType,
        "x-line-access": response[3],
        "x-lal": "ja_JP",
        "x-lpv": "1",
        "x-lhm": "GET",
        "accept-encoding": "gzip"
      };
      Response r = await this.client.fetch(
        "https://${this.client.request.endpoint}/LF1",
        headers: headers
      );
      Map e2eeInfo = jsonDecode(r.body);
      this.client.log("response", e2eeInfo);
      await this.client.e2ee.decodeE2EEKeyV1(e2eeInfo["metadata"], secret);
      Uint8List deviceSecret = await this.client.e2ee.encryptDeviceSecret(
        base64.decode(e2eeInfo["metadata"]["publicKey"]),
        secret,
        base64.decode(e2eeInfo["metadata"]["encryptedKeyChain"])
      );
      dynamic e2eeLogin = await this.confirmE2EELogin(
        response[3],
        deviceSecret
      );
      response = await this.loginV2(
        keynm,
        encryptedMessage,
        this.client.device,
        e2eeLogin,
        e2eeData,
        cert,
        "loginV2"
      );
    }
    if (response[2] != null) {
      this.client.emit("update:cert", response[2]);
      await this.registerCert(response[2], email);
    }
    await this.client.storage.set("refreshToken", response[9][2]);
    await this.client.storage.set("expire", response[9][3] + response[9][6]);
    return response[9][1];
  }

  Future<LINETypes.RSAKey> getRSAKeyInfo([int provider = 0]) async {
    return await LINETypes.RSAKey.fromJson(
      await this.client.request.request(
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
    return await this.client.request.request(
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
            [11, 8, cert],
            [11, 9, verifier],
            [11, 10, secret],
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
      await this.client.request.request(
        [],
        "createSession",
        4,
        false,
        "/acct/lgn/sq/v1"
      )
    );
  }

  Future<Map> createQrCode(String qrcode) async {
    return await this.client.request.request(
      [[12, 1, [[11, 1, qrcode]]]],
      "createQrCode",
      4,
      false,
      "/acct/lgn/sq/v1"
    );
  }

  Future<bool> checkQrCodeVerified(String qrcode) async {
    try {
      await this.client.request.request(
        [[12, 1, [[11, 1, qrcode]]]],
        "checkQrCodeVerified",
        4,
        false,
        "/acct/lgn/sq/v1",
        { "x-lst": "180000", "x-line-access": qrcode }
      );
      return true;
    } catch(error) {
      throw error;
    }
  }

  Future<dynamic> verifyCertificate(String qrcode, [String? cert]) async {
    return await this.client.request.request(
      [[12, 1, [[11, 1, qrcode], [11, 2, cert]]]],
      "verifyCertificate",
      4,
      false,
      "/acct/lgn/sq/v1"
    );
  }

  Future<dynamic> createPinCode(String qrcode) async {
    return await this.client.request.request(
      [[12, 1, [[11, 1, qrcode]]]],
      "createPinCode",
      4,
      false,
      "/acct/lgn/sq/v1"
    );
  }

  Future<bool> checkPinCodeVerified(String qrcode) async {
    try {
      await this.client.request.request(
        [[12, 1, [[11, 1, qrcode]]]],
        "checkPinCodeVerified",
        4,
        false,
        "/acct/lp/lgn/sq/v1",
        { "x-lst": "180000", "x-line-access": qrcode },
        this.client.config.longTimeout,
      );
      return true;
    } catch(error) {
      throw error;
    }
  }

  Future<dynamic> qrCodeLogin(String authSessionId, [bool autoLoginIsRequired = true]) async {
    return await this.client.request.request(
      [[12, 1, [
        [11, 1, authSessionId],
        [11, 2, this.client.device],
        [2, 3, autoLoginIsRequired]
      ]]],
      "qrCodeLogin",
      4,
      false,
      "/acct/lgn/sq/v1"
    );
  }

  Future<dynamic> qrCodeLoginV2(String authSessionId, [String modelName = "hafusun", String systemName = "linedart", bool autoLoginIsRequired = true]) async {
    return await this.client.request.request(
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
    return await this.client.request.request(
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