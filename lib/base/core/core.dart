import 'package:http/http.dart' as http;

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
import "./utils/events.dart";
import "./utils/error.dart";

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
}