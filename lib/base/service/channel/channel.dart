import '../../service/types.dart';
import '../../core/core.dart';
import '../../../thrift/line_types.dart' as LINETypes;
import '../../../thrift/readwrite/struct.dart' as LINEStructs;

class ChannelService extends BaseService {
  BaseClient client;
  int protocolType = 4;
  String requestPath = "/CH4";
  String errorName = "ChannelServiceError";

  ChannelService(this.client, [this.protocolType = 4, this.requestPath = "/CH4", this.errorName = "ChannelServiceError"]);

  Future<dynamic> approveChannelAndIssueChannelToken(Map param) async {
    return await this.client.request.request(
      LINEStructs.approveChannelAndIssueChannelToken_args(LINETypes.approveChannelAndIssueChannelToken_args.fromJson(param)),
      "approveChannelAndIssueChannelToken",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getChannelInfo(Map param) async {
    return await this.client.request.request(
      LINEStructs.getChannelInfo_args(LINETypes.getChannelInfo_args.fromJson(param)),
      "getChannelInfo",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getCommonDomains(Map param) async {
    return await this.client.request.request(
      LINEStructs.getCommonDomains_args(LINETypes.getCommonDomains_args.fromJson(param)),
      "getCommonDomains",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> issueRequestTokenWithAuthScheme(Map param) async {
    return await this.client.request.request(
      LINEStructs.issueChannelToken_args(LINETypes.issueChannelToken_args.fromJson(param)),
      "issueRequestTokenWithAuthScheme",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getReturnUrlWithRequestTokenForAutoLogin(Map param) async {
    return await this.client.request.request(
      LINEStructs.getReturnUrlWithRequestTokenForAutoLogin_args(LINETypes.getReturnUrlWithRequestTokenForAutoLogin_args.fromJson(param)),
      "getReturnUrlWithRequestTokenForAutoLogin",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getWebLoginDisallowedUrl(Map param) async {
    return await this.client.request.request(
      LINEStructs.getWebLoginDisallowedUrl_args(LINETypes.getWebLoginDisallowedUrl_args.fromJson(param)),
      "getWebLoginDisallowedUrl",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> updateChannelNotificationSetting(Map param) async {
    return await this.client.request.request(
      LINEStructs.updateChannelNotificationSetting_args(LINETypes.updateChannelNotificationSetting_args.fromJson(param)),
      "updateChannelNotificationSetting",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> updateChannelSettings(Map param) async {
    return await this.client.request.request(
      LINEStructs.updateChannelSettings_args(LINETypes.updateChannelSettings_args.fromJson(param)),
      "updateChannelSettings",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getUpdatedChannelIds(Map param) async {
    return await this.client.request.request(
      LINEStructs.getUpdatedChannelIds_args(LINETypes.getUpdatedChannelIds_args.fromJson(param)),
      "getUpdatedChannelIds",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getChannelNotificationSettings(Map param) async {
    return await this.client.request.request(
      LINEStructs.getChannelNotificationSettings_args(LINETypes.getChannelNotificationSettings_args.fromJson(param)),
      "getChannelNotificationSettings",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getApprovedChannels(Map param) async {
    return await this.client.request.request(
      LINEStructs.getApprovedChannels_args(LINETypes.getApprovedChannels_args.fromJson(param)),
      "getApprovedChannels",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> issueChannelToken(Map param) async {
    return await this.client.request.request(
      LINEStructs.issueChannelToken_args(LINETypes.issueChannelToken_args.fromJson(param)),
      "issueChannelToken",
      this.protocolType,
      true,
      this.requestPath
    );
  }
}