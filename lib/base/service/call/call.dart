import 'package:linedart/base/service/types.dart';
import 'package:linedart/base/core/core.dart';
import 'package:linedart/thrift/line_types.dart' as LINETypes;
import 'package:linedart/thrift/readwrite/struct.dart' as LINEStructs;

class CallService extends BaseService {
  @override
  BaseClient client;
  @override
  int protocolType = 4;
  @override
  String requestPath = "/V4";
  @override
  String errorName = "CallServiceError";

  CallService(this.client, [this.protocolType = 4, this.requestPath = "/V4", this.errorName = "CallServiceError"]);

  Future<dynamic> acquireCallRoute(Map param) async {
    return await client.request.request(
      LINEStructs.acquireCallRoute_args(LINETypes.acquireCallRoute_args.fromJson(param)),
      "acquireCallRoute",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> acquireOACallRoute(Map param) async {
    return await client.request.request(
      LINEStructs.acquireOACallRoute_args(LINETypes.acquireOACallRoute_args.fromJson(param)),
      "acquireOACallRoute",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> lookupPaidCall(Map param) async {
    return await client.request.request(
      LINEStructs.lookupPaidCall_args(LINETypes.lookupPaidCall_args.fromJson(param)),
      "lookupPaidCall",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> acquirePaidCallRoute(Map param) async {
    return await client.request.request(
      LINEStructs.acquirePaidCallRoute_args(LINETypes.acquirePaidCallRoute_args.fromJson(param)),
      "acquirePaidCallRoute",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> acquireGroupCallRoute(Map param) async {
    return await client.request.request(
      LINEStructs.acquireGroupCallRoute_args(LINETypes.acquireGroupCallRoute_args.fromJson(param)),
      "acquireGroupCallRoute",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getGroupCall(Map param) async {
    return await client.request.request(
      LINEStructs.getGroupCall_args(LINETypes.getGroupCall_args.fromJson(param)),
      "getGroupCall",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> inviteIntoGroupCall(Map param) async {
    return await client.request.request(
      LINEStructs.inviteIntoGroupCall_args(LINETypes.inviteIntoGroupCall_args.fromJson(param)),
      "inviteIntoGroupCall",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getGroupCallUrls(Map param) async {
    return await client.request.request(
      LINEStructs.getGroupCallUrls_args(LINETypes.getGroupCallUrls_args.fromJson(param)),
      "getGroupCallUrls",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> createGroupCallUrl(Map param) async {
    return await client.request.request(
      LINEStructs.createGroupCallUrl_args(LINETypes.createGroupCallUrl_args.fromJson(param)),
      "createGroupCallUrl",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> deleteGroupCallUrl(Map param) async {
    return await client.request.request(
      LINEStructs.deleteGroupCallUrl_args(LINETypes.deleteGroupCallUrl_args.fromJson(param)),
      "deleteGroupCallUrl",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> updateGroupCallUrl(Map param) async {
    return await client.request.request(
      LINEStructs.updateGroupCallUrl_args(LINETypes.updateGroupCallUrl_args.fromJson(param)),
      "updateGroupCallUrl",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getGroupCallUrlInfo(Map param) async {
    return await client.request.request(
      LINEStructs.getGroupCallUrlInfo_args(LINETypes.getGroupCallUrlInfo_args.fromJson(param)),
      "getGroupCallUrlInfo",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> joinChatByCallUrl(Map param) async {
    return await client.request.request(
      LINEStructs.joinChatByCallUrl_args(LINETypes.joinChatByCallUrl_args.fromJson(param)),
      "joinChatByCallUrl",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> kickoutFromGroupCall(Map param) async {
    return await client.request.request(
      LINEStructs.kickoutFromGroupCall_args(LINETypes.kickoutFromGroupCall_args.fromJson(param)),
      "kickoutFromGroupCall",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> startPhotobooth(Map param) async {
    return await client.request.request(
      LINEStructs.startPhotobooth_args(LINETypes.startPhotobooth_args.fromJson(param)),
      "startPhotobooth",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> usePhotoboothTicket(Map param) async {
    return await client.request.request(
      LINEStructs.usePhotoboothTicket_args(LINETypes.usePhotoboothTicket_args.fromJson(param)),
      "usePhotoboothTicket",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getPhotoBoothBalance(Map param) async {
    return await client.request.request(
      LINEStructs.getPhotoboothBalance_args(LINETypes.getPhotoboothBalance_args.fromJson(param)),
      "getPhotoboothBalance",
      protocolType,
      true,
      requestPath
    );
  }
}