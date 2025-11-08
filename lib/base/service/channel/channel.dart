import 'package:linedart/base/service/types.dart';
import 'package:linedart/base/core/core.dart';
import 'package:linedart/thrift/line_types.dart' as LINETypes;
import 'package:linedart/thrift/readwrite/struct.dart' as LINEStructs;

class ChannelService extends BaseService {
  @override
  BaseClient client;
  @override
  int protocolType = 4;
  @override
  String requestPath = "/CH4";
  @override
  String errorName = "ChannelServiceError";

  ChannelService(this.client, [this.protocolType = 4, this.requestPath = "/CH4", this.errorName = "ChannelServiceError"]);

  Future<dynamic> approveChannelAndIssueChannelToken(Map param) async {
    return await client.request.request(
      LINEStructs.approveChannelAndIssueChannelToken_args(LINETypes.approveChannelAndIssueChannelToken_args.fromJson(param)),
      "approveChannelAndIssueChannelToken",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getChannelInfo(Map param) async {
    return await client.request.request(
      LINEStructs.getChannelInfo_args(LINETypes.getChannelInfo_args.fromJson(param)),
      "getChannelInfo",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getCommonDomains(Map param) async {
    return await client.request.request(
      LINEStructs.getCommonDomains_args(LINETypes.getCommonDomains_args.fromJson(param)),
      "getCommonDomains",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> issueRequestTokenWithAuthScheme(Map param) async {
    return await client.request.request(
      LINEStructs.issueChannelToken_args(LINETypes.issueChannelToken_args.fromJson(param)),
      "issueRequestTokenWithAuthScheme",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getReturnUrlWithRequestTokenForAutoLogin(Map param) async {
    return await client.request.request(
      LINEStructs.getReturnUrlWithRequestTokenForAutoLogin_args(LINETypes.getReturnUrlWithRequestTokenForAutoLogin_args.fromJson(param)),
      "getReturnUrlWithRequestTokenForAutoLogin",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getWebLoginDisallowedUrl(Map param) async {
    return await client.request.request(
      LINEStructs.getWebLoginDisallowedUrl_args(LINETypes.getWebLoginDisallowedUrl_args.fromJson(param)),
      "getWebLoginDisallowedUrl",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> updateChannelNotificationSetting(Map param) async {
    return await client.request.request(
      LINEStructs.updateChannelNotificationSetting_args(LINETypes.updateChannelNotificationSetting_args.fromJson(param)),
      "updateChannelNotificationSetting",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> updateChannelSettings(Map param) async {
    return await client.request.request(
      LINEStructs.updateChannelSettings_args(LINETypes.updateChannelSettings_args.fromJson(param)),
      "updateChannelSettings",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getUpdatedChannelIds(Map param) async {
    return await client.request.request(
      LINEStructs.getUpdatedChannelIds_args(LINETypes.getUpdatedChannelIds_args.fromJson(param)),
      "getUpdatedChannelIds",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getChannelNotificationSettings(Map param) async {
    return await client.request.request(
      LINEStructs.getChannelNotificationSettings_args(LINETypes.getChannelNotificationSettings_args.fromJson(param)),
      "getChannelNotificationSettings",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getApprovedChannels(Map param) async {
    return await client.request.request(
      LINEStructs.getApprovedChannels_args(LINETypes.getApprovedChannels_args.fromJson(param)),
      "getApprovedChannels",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> issueChannelToken(Map param) async {
    return await client.request.request(
      LINEStructs.issueChannelToken_args(LINETypes.issueChannelToken_args.fromJson(param)),
      "issueChannelToken",
      protocolType,
      true,
      requestPath
    );
  }
}