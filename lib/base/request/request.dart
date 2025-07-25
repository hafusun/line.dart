import "dart:convert";
import 'dart:typed_data';

import "package:fbthrift/fbthrift.dart";
import "package:http/http.dart" hide BaseClient;
import "../../base/core/utils/devices.dart";
import "../../base/core/utils/error.dart";
import "../../thrift/readwrite/declares.dart";

import "../core/core.dart";

List<String> square = ["/SQ1", "/SQLV1"];

class RequestClient {
  BaseClient client;
  late String? endpoint;
  late String userAgent;
  late String systemType;
  Map EXCEPTION_TYPES = {
    "/S3": "TalkException",
    "/S4": "TalkException",
    "/SYNC4": "TalkException",
    "/SYNC3": "TalkException",
    "/CH3": "ChannelException",
    "/CH4": "ChannelException",
    "/SQ1": "SquareException",
    "/LIFF1": "LiffException",
    "/api/v3p/rs": "TalkException",
    "api/v3/TalkService.do": "TalkException"
  };

  RequestClient(this.client){
    DeviceDetails deviceDetails = client.deviceDetails;
    endpoint = endpoint ?? "legy.line-apps.com";
    systemType = "${deviceDetails.device}\t${deviceDetails.appVersion}\t${deviceDetails.systemName}\t${deviceDetails.systemVersion}";
    userAgent = "Line/${deviceDetails.appVersion}";
    client = client;
  }

  Future<dynamic> request(List value, String methodName, [int ProtocolKey = 3, dynamic parse = true, String path = "/S3", Map<String, String> headers = const {}, dynamic timeout]) async {
    timeout =  timeout ? timeout : client.config.timeout;
    dynamic res = await requestCore(
      path,
      value,
      methodName,
      ProtocolKey,
      headers,
      null,
      parse,
      null,
      timeout,
    );
    return res["data"]["success"];
  }

  Future<ParsedThrift> requestCore(String path, List value, String methodName, int protocolType, Map<String, String> appendHeaders, [String? overrideMethod = "POST", dynamic parse = true, bool? isReRequest = false, int timeout = 1000]) async {
    TProtocol protocol = Protocols[protocolType];
    Map<String, String> headers = getHeader(overrideMethod ?? "POST");
    headers.addAll(appendHeaders);
    client.log("writeThrift", { "value": value, "methodName": methodName, "protocolType": protocolType });
    Uint8List Trequest = client.thrift.writeThrift([value, methodName, protocol]);
    client.log("request", { "methodName": methodName, "path": "https://$endpoint$path", "method": overrideMethod, "headers": headers, "timeout": timeout, "body": Trequest });

    Response response = await client.fetch(
      "https://$endpoint$path",
      method: overrideMethod ?? "POST",
      headers: headers,
      body: Trequest,
      timeout: timeout,
    );
    String? nextToken = response.headers.containsKey("x-line-next-access") ? response.headers["x-line-next-access"] : null;
    if (nextToken != null) {
      client.emit("update:authtoken", nextToken);
    }
    Uint8List body = response.bodyBytes;
    client.log("response", { "parsedBody": body, "methodName": methodName });
    ParsedThrift res;
    bool hasError = false;
    try {
      res = client.thrift.readThrift([body, protocol]);
    } catch (e) {
      throw InternalError("Request internal failed: Invalid response buffer", List.from(body).map((e) => e.toRadixString(16).toString()).join(", "));
    }
    if (!res.data[0] && res.data.length != 0) {
      hasError = true;
    }
    if (parse is bool && parse == true) {
      client.thrift.rename_data(res, square: square.contains(path));
    } else if (parse is String) {
      res.data["success"] = client.thrift.rename_thrift(parse, res.data[0]);
      res.data.remove(0);
      if (res.data[1] != null) {
        String? structName = EXCEPTION_TYPES[path] ?? "TalkException";
        if (structName != null) {
          res.data["e"] = client.thrift.rename_thrift(structName, res.data[1]);
        } else {
          res.data["e"] = res.data[1];
        }
        res.data.remove(1);
      }
    } else {
      res.data["success"] = res.data[0];
      res.data.remove(0);
      if (res.data[1]) {
        String? structName = EXCEPTION_TYPES[path] ?? "TalkException";
        if (structName != null) {
          res.data["e"] = client.thrift.rename_thrift(structName, res.data[1]);
        } else {
          res.data["e"] = res.data[1];
        }
        res.data.remove(1);
      }
    }
    client.log("readThrift", { "res": res });
    bool isRefresh = res.data["e"] != null && res.data["e"]["code"] == "MUST_REFRESH_V3_TOKEN" && await client.storage.get("refreshToken") != null;
    if (res.data["e"] != null && !isRefresh) {
      throw InternalError("RequestError", "Request internal failed, $methodName($path) -> ${jsonEncode(res.data["e"])}");
    }
    if (hasError && !isRefresh) {
      throw InternalError("RequestError", "Request internal failed, $methodName($path) -> ${jsonEncode(res.data)}");
    }
    if (isRefresh && !(isReRequest ?? false)) {
      await client.auth.tryRefreshToken();
      return requestCore(
        path,
        value,
        methodName,
        protocolType,
        appendHeaders,
        overrideMethod,
        parse,
        true,
      );
    }
    return res;
  }

  Map<String, String> getHeader(String overrideMethod) {
    Map<String, String> header = {
      "Host": endpoint!,
      "accept": "application/x-thrift",
      "user-agent":userAgent,
      "x-line-application": systemType,
      "content-type": "application/x-thrift",
      "x-lal": "ja_JP",
      "x-lpv": "1",
      "x-lhm": overrideMethod,
      "accept-encoding": "gzip",
    };
    if (client.authToken != null) {
      header["x-line-access"] = client.authToken!;
    }
    return header;
  }
}