import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:linedart/base/polling/polling.dart';

import 'package:linedart/base/obs/obs.dart';
import 'package:linedart/base/request/request.dart';

import 'package:linedart/base/service/auth/auth.dart';
import 'package:linedart/base/service/channel/channel.dart';
import 'package:linedart/base/service/call/call.dart';
import 'package:linedart/base/service/liff/liff.dart';
import 'package:linedart/base/service/livetalk/livetalk.dart';
import 'package:linedart/base/service/relation/relation.dart';
import 'package:linedart/base/service/square/square.dart';
import 'package:linedart/base/service/talk/talk.dart';
import 'package:linedart/base/timeline/timeline.dart';

import 'package:linedart/base/login/login.dart';

import 'package:linedart/thrift/fid.dart';

import "./utils/devices.dart";
import "./typed-event-emitter/emitter.dart";
import 'package:linedart/thrift/thrift.dart';
import 'package:linedart/base/storage/base.dart';
import 'package:linedart/base/storage/storage.dart';
import 'package:linedart/thrift/line_types.dart' as LINETypes;
import 'package:linedart/base/e2ee/e2ee.dart';

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
  Map device;
  dynamic savePath;
  late Thrift thrift;
  late RequestClient request;
  late BaseStorage storage;
  late E2EE e2ee;
  late LineObs obs;
  late Timeline timeline;

  late AuthService auth;
  late CallService call;
  late ChannelService channel;
  late LiffService liff;
  late SquareLiveTalkService livetalk;
  late RelationService relation;
  late SquareService square;
  late TalkService talk;

  late Login login;

  Function? customFetch;

  late LINETypes.Profile? profile;
  late Config config;
  late DeviceDetails deviceDetails;

  String? endpoint;

  BaseClient(this.authToken, this.device, this.savePath, [String? endpoint]) {
    deviceDetails = getDeviceDetails(device["device"], device["appVersion"])!;
    thrift = Thrift();
    thrift.def = fid2nameMap;
    this.endpoint = endpoint ?? "legy.line-apps.com";
    request = RequestClient(this);
    storage = FileStorage(savePath);
    e2ee = E2EE(this);
    obs = LineObs(this);
    timeline = Timeline(this);
    auth = AuthService(this);
    call = CallService(this);
    channel = ChannelService(this);
    liff  = LiffService(this);
    livetalk = SquareLiveTalkService(this);
    relation = RelationService(this);
    square = SquareService(this);
    talk = TalkService(this);
    login = Login(this);
    customFetch = customFetch;
    config = Config(timeout: 30000, longTimeout: 180000);
  }

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

  Map<String, dynamic>? reqseqs;

  Future<int> getReqseq([String name = "talk"]) async {
    reqseqs = jsonDecode(
        ((await storage.get("reqseq")) ?? "{}").toString(),
      );
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
    dynamic body,
    int? timeout,
  }) async {
    final request = http.Request(method, Uri.parse(url));
    if (headers != null) {
      request.headers.addAll(headers);
    }
    if (body != null) {
      if (body is String) {
        request.body = body;
      } else if (body is Uint8List) {
        request.bodyBytes = body;
      }
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