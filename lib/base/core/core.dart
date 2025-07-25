import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../base/polling/polling.dart';

import '../obs/obs.dart';
import '../request/request.dart';

import '../service/auth/auth.dart';
import '../service/channel/channel.dart';
import '../service/call/call.dart';
import '../service/liff/liff.dart';
import '../service/livetalk/livetalk.dart';
import '../service/relation/relation.dart';
import '../service/square/square.dart';
import '../service/talk/talk.dart';

import "./utils/devices.dart";
import "./typed-event-emitter/emitter.dart";
import '../../thrift/thrift.dart';
import '../storage/base.dart';
import '../../thrift/line_types.dart' as LINETypes;
import '../e2ee/e2ee.dart';

class Config {
  int timeout;
  int longTimeout;

  Config({
    this.timeout = 30000,
    this.longTimeout = 180000,
  });
}

class BaseClient extends TypedEventEmitter {
  String? authToken;
  Device device;
  Thrift thrift;
  RequestClient request;
  BaseStorage storage;
  E2EE e2ee;
  LineObs obs;

  AuthService auth;
  CallService call;
  ChannelService channel;
  LiffService liff;
  SquareLiveTalkService livetalk;
  RelationService relation;
  SquareService square;
  TalkService talk;

  Function? customFetch;

  LINETypes.Profile? profile;
  Config config;
  DeviceDetails deviceDetails;

  String endpoint;

  BaseClient({
    this.authToken,
    required this.device,
    required this.thrift,
    required this.request,
    required this.storage,
    required this.e2ee,
    required this.obs,
    required this.auth,
    required this.call,
    required this.channel,
    required this.liff,
    required this.livetalk,
    required this.relation,
    required this.square,
    required this.talk,
    this.customFetch,
    this.profile,
    required this.config,
    required this.deviceDetails,
    required this.endpoint,
  });

  log(String type, dynamic data) {
    emit("log", { "type": type, "data": data });
  }

  int? getToType(String mid) {
    Map typeMapping = {
      "u": 0,
      "r": 1,
      "c": 2,
      "s": 3,
      "m": 4,
      "p": 5,
      "v": 6,
      "t": 7
    };
    return typeMapping[mid[0]];
  }

  Map<String, int>? reqseqs;

  Future<int> getReqseq([String name = "talk"]) async {
    reqseqs ??= jsonDecode(
        ((await storage.get("reqseq")) ?? "{}").toString(),
      ) as Map<String, int>;
    if (reqseqs![name] == null) {
      reqseqs![name] = 0;
    }
    int seq = reqseqs![name]!;
    reqseqs![name] = seq + 1;
    await storage.set("reqseq", jsonEncode(reqseqs));
    return seq;
  }

  Future<http.Response> fetch(
    String url, {
    String method = 'GET',
    Map<String, String>? headers,
    Object? body,
    int? timeout,
  }) async {
    final request = http.Request(method, Uri.parse(url));
    if (headers != null) {
      request.headers.addAll(headers);
    }
    if (body != null && body is String) {
      request.body = body;
    }

    final streamResponse = await (customFetch != null
        ? customFetch!(request).timeout(Duration(milliseconds: timeout ?? 1000))
        : http.Client().send(request).timeout(Duration(milliseconds: timeout ?? 1000)));

    return http.Response.fromStream(streamResponse);
  }

  Polling createPolling() {
    return Polling(this);
  }

  dynamic jsonReplacer(dynamic k, dynamic v) {
    if (v is String) {
      dynamic midType = RegExp(r"(.)[0123456789abcdef]{32}").firstMatch(v);
      if (midType != null && midType.group(1) != null) {
        return "[${midType.group(1).toUpperCase()} mid]";
      }
      if (k == "x-line-access") {
        return "[AuthToken]";
      }
    }
    if (v is Map) {
      Map newObj = {};
      int midCount = 0;
      v.forEach((key, v) {
        dynamic match = RegExp(r"(.)[0123456789abcdef]{32}").firstMatch(key);
        if (match != null && match.group(1) != null) {
          midCount += 1;
          newObj["${match.group(1)!.toString().toUpperCase()} mid $midCount"] = v;
        } else {
          newObj[key] = v;
        }
      });
      return newObj;
    }
    return v;
  }
}