import 'dart:convert';
import '../../service/types.dart';
import '../../core/core.dart';
import '../../core/utils/error.dart';
import '../../../thrift/line_types.dart' as LINETypes;
import '../../../thrift/readwrite/struct.dart' as LINEStructs;
import "package:http/http.dart" hide BaseClient;

class LiffService extends BaseService {
  String LINE_LIFF_ENDPOINT = "https://api.line.me/message/v3/share";
  String CONSENT_API_URL = "https://api.line.me/dialog/api/permissions";
  String AUTH_CONSENT_URL = "https://access.line.me/oauth2/v2.1/authorize/consent";
  Map liffTokenCache = {};
  @override
  String requestPath = "/LIFF1";
  @override
  String errorName = "LiffServiceError";
  String liffId = "2006747340-AoraPvdD";
  RegExp csrfRegExp = RegExp(r'<input type="hidden" name="__csrf" id="__csrf" value="(.*?)">');

  @override
  BaseClient client;

  LiffService(
    this.client, {
    this.LINE_LIFF_ENDPOINT = "https://api.line.me/message/v3/share",
    this.CONSENT_API_URL = "https://api.line.me/dialog/api/permissions",
    this.AUTH_CONSENT_URL = "https://access.line.me/oauth2/v2.1/authorize/consent",
    Map? liffTokenCache,
    this.requestPath = "/LIFF1",
    this.errorName = "LiffServiceError",
    this.liffId = "2006747340-AoraPvdD",
    RegExp? csrfRegExp,
  })  : liffTokenCache = liffTokenCache ?? {},
        csrfRegExp = csrfRegExp ?? RegExp(r'<input type="hidden" name="__csrf" id="__csrf" value="(.*?)">');

  Future<LINETypes.LiffViewResponse> issueLiffView(String liffId, [String? chatMid, String? lang]) async {
    List context = [12, 1, []];
    int chaLINETypes;
    List chat;
    if (chatMid != null) {
      chat = [11, 1, chatMid];
      if (["u", "c", "r"].contains(chatMid[0])) {
        chaLINETypes = 2;
      } else {
        chaLINETypes = 3;
      }
      context = [12, chaLINETypes, [chat]];
    }
    return LINETypes.LiffViewResponse.fromJson(await client.request.request(
      [[12, 1, [
        [11, 1, liffId],
        [12, 2, [context]],
        [11, 3, (lang ?? "ja_JP")],
      ]]],
      "issueLiffiew",
      protocolType,
      true,
      requestPath
    ));
  }

  Future<dynamic> getLiffViewWithoutUserContext(Map param) async {
    return await client.request.request(
      LINEStructs.getLiffViewWithoutUserContext_args(LINETypes.getLiffViewWithoutUserContext_args.fromJson(param)),
      "getLiffViewWithoutUserContext",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> issueSubLiffView(Map param) async {
    return await client.request.request(
      LINEStructs.issueSubLiffView_args(LINETypes.issueSubLiffView_args.fromJson(param)),
      "issueSubLiffView",
      protocolType,
      true,
      requestPath
    );
  }

  Future<String> getLiffToken(String liffId, [String? chatMid, String? lang, bool? tryConsent]) async {
    try {
      LINETypes.LiffViewResponse liff = await issueLiffView(liffId, chatMid, lang);
      return liff.accessToken;
    } catch(e) {
      if ((e as InternalError).data.isNotEmpty) {
        InternalError error = e;
        client.log("liff-error", error.data);
        if ((error.data["liffException"] as LINETypes.LiffException).code == "CONSENT_REQUIRED" && (tryConsent ?? false)) {
          LINETypes.LiffException data = error.data["liffException"] as LINETypes.LiffException;
          LINETypes.Qj_C13599p payload = data.payload;
          String? channelId = payload.consentRequired.channelId;
          String? consentUrl = payload.consentRequired.consentUrl;
          dynamic toType = chatMid != null ? client.getToType(chatMid) : null;
          bool hasConsent = false;
          if (channelId != null && consentUrl != null) {
            if ((toType != null && toType == 4) || client.deviceDetails.device.startsWith("DESKTOP")) {
              hasConsent = await tryConsentAuthorize(consentUrl, channelId);
            } else {
              hasConsent = await tryConsentLiff(channelId);
            }
            if (hasConsent) {
              return getLiffToken(liffId, chatMid, lang, false);
            }
          }
        }
      }
      throw InternalError(errorName, "Failed to get LiffToken: $liffId${chatMid != null ? "@$chatMid" : ""}");
    }
  }

  Future<dynamic> sendLiff(String to, List message, [bool? tryConsent, bool? forceIssue]) async {
    String token;
    if (liffTokenCache[to] == null || (forceIssue ?? false)) {
      token = await getLiffToken(to, liffId);
    } else {
      token = liffTokenCache[to];
    }
    Map<String, String> liffHeaders = {
      "Accept": "application/json, text/plain, */*",
      "User-Agent": "Mozilla/5.0 (Linux; Android 4.4.2; G730-U00 Build/JLS36C) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/30.0.0.0 Mobile Safari/537.36 Line/9.8.0",
      "Accept-Encoding": "gzip, defeate",
      "Accept-Language": "zh-TW,zh;q=0.9",
      "Authorization": "Bearer $token",
      "content-type": "application/json",
    };
    String payload = jsonEncode({ "message": message });
    Response response = await client.fetch(
      "https://api.line.me/message/v3/share",
      method: "POST",
      body: payload,
      headers: liffHeaders
    );
    Map responseBody = jsonDecode(response.body);
    if (response.statusCode > 200 || response.statusCode >= 300) {
      throw InternalError(errorName, "Failed to send Liff message: ${response.reasonPhrase ?? response.statusCode}");
    }
    return responseBody;
  }

  Future<bool> tryConsentLiff(String channelId, [String? refere]) async {
    String payload = jsonEncode({ "on": ["P", "CM"], "off": [] });
    Map<String, String> headers = {
      "X-LINE-ChannelId": channelId,
      "X-LINE-Access": client.authToken as String,
      "User-Agent": "Mozilla/5.0 (Linux; Android 8.0.1; SAMSUNG Realise/DeachSword; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/56.0.2924.87 Mobile Safari/537.36",
      "Content-Type": "application/json",
      "X-Line-Application": client.request.systemType,
      "X-Requested-With": "XMLHttpRequest",
      "Accept-Language": "ja-JP,en-US;q=0.8"
    };
    headers.addAll(refere != null ? { "refere": refere } : {});
    Response response = await client.fetch(
      CONSENT_API_URL,
      method: "POST",
      body: payload,
      headers: headers
    );
    return (response.statusCode > 200 || response.statusCode >= 300);
  }

  Future<bool> tryConsentAuthorize(String consentUrl, String channelId, [List<String> allPermission = const ["P", "CM", "OC"], List<String> approvedPermission = const ["P", "CM", "OC"]]) async {
    Map<String, String> headers = {
      "X-Line-Access": client.authToken as String,
      "User-Agent": client.request.userAgent,
      "X-Line-Application": client.request.systemType
    };
    Response response = await client.fetch(
      consentUrl,
      method: "GET",
      headers: headers
    );
    if (response.statusCode > 200 || response.statusCode >= 300) {
      List<String> cookies = [];
      response.headers.forEach((k, v) {
        if (k == "set-cookie") {
          cookies.add(v);
        }
      });
      String text = response.body;
      String? csrfToken = csrfRegExp.firstMatch(text)?.group(1);
      if (csrfToken != null) {
        headers["cookie"] = cookies.join("; ");
        headers["refere"] = consentUrl;
        Response authResponse = await client.fetch(
          AUTH_CONSENT_URL,
          method: "POST",
          body: '${allPermission.map((e) => "allPermission=$e").join("&")}&${approvedPermission.map((e) => "approvedPermission=$e").join("&")}&__WLS=&channelId=200674734&__csrf=$csrfToken&allow=true',
          headers: headers
        );
        return (authResponse.statusCode > 200 || authResponse.statusCode >= 300);
      }
    }
    return false;
  }
}