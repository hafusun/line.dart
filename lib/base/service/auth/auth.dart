import '../../core/utils/error.dart';
import '../../core/core.dart';
import '../../../thrift/line_types.dart' as LINETypes;
import '../../../thrift/readwrite/struct.dart' as LINEStructs;
import '../types.dart';

class AuthService extends BaseService {
  final BaseClient client;
  late int protocolType = 4;
  late String requestPath = "/AS4";
  late String errorName = "AuthServiceError";

  AuthService(this.client, [this.protocolType = 4, this.requestPath = "/AS4", this.errorName = "AuthServiceError"]);

  dynamic tryRefreshToken() async {
    String? refreshToken = await this.client.storage.get("refreshToken");
    if (refreshToken is String) {
      dynamic RATR = await this.refresh({ "request": { "refreshToken": refreshToken }});
      this.client.authToken = RATR["accessToken"];
      this.client.emit("update:authToken", RATR["accessToken"]);
      await this.client.storage.set("expire", (RATR["tokenIssueTimeEpochSec"] as int) + (RATR["durationUntilRefreshInSec"] as int));
    } else {
      throw new InternalError("refreshError", "refreshToken not found");
    }
  }

  Future<LINETypes.RefreshAccessTokenResponse> refresh(Map param) async {
    return await this.client.request.request(
      LINEStructs.refresh_args(LINETypes.refresh_args.fromJson(param)),
      "refresh",
      this.protocolType,
      true,
      "/EXT/auth/tokenrefresh/v1"
    );
  }

  Future<dynamic> reportRefreshedAccessToken(Map param) async {
    return await this.client.request.request(
      LINEStructs.reportRefreshedAccessToken_args(LINETypes.reportRefreshedAccessToken_args.fromJson(param)),
      "reportRefreshedAccessToken",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> connectEapAccount(Map param) async {
    return await this.client.request.request(
      LINEStructs.connectEapAccount_args(LINETypes.connectEapAccount_args.fromJson(param)),
      "connectEapAccount",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> disconnectEapAccount(Map param) async {
    return await this.client.request.request(
      LINEStructs.disconnectEapAccount_args(LINETypes.disconnectEapAccount_args.fromJson(param)),
      "disconnectEapAccount",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> openSession(Map param) async {
    return await this.client.request.request(
      LINEStructs.openSession_args(LINETypes.openSession_args.fromJson(param)),
      "openSession",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> verifyEapLogin(Map param) async {
    return await this.client.request.request(
      LINEStructs.verifyEapAccountForRegistration_args(LINETypes.verifyEapAccountForRegistration_args.fromJson(param)),
      "verifyEapLogin",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> updatePassword(Map param) async {
    return await this.client.request.request(
      LINEStructs.updatePassword_args(LINETypes.updatePassword_args.fromJson(param)),
      "updatePassword",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> establishE2EESession(Map param) async {
    return await this.client.request.request(
      LINEStructs.establishE2EESession_args(LINETypes.establishE2EESession_args.fromJson(param)),
      "establishE2EESession",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> issueTokenForAccountMigrationSettings(Map param) async {
    return await this.client.request.request(
      LINEStructs.issueTokenForAccountMigrationSettings_args(LINETypes.issueTokenForAccountMigrationSettings_args.fromJson(param)),
      "issueTokenForAccountMigrationSettings",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> openAuthSession(Map param) async {
    return await this.client.request.request(
      LINEStructs.openAuthSession_args(LINETypes.openAuthSession_args.fromJson(param)),
      "openAuthSession",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getAuthRSAKey(Map param) async {
    return await this.client.request.request(
      LINEStructs.getAuthRSAKey_args(LINETypes.getAuthRSAKey_args.fromJson(param)),
      "getAuthRSAKey",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> setIdentifier(Map param) async {
    return await this.client.request.request(
      LINEStructs.setIdentifier_args(LINETypes.setIdentifier_args.fromJson(param)),
      "setIdentifier",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> updateIdentifier(Map param) async {
    return await this.client.request.request(
      LINEStructs.updateIdentifier_args(LINETypes.updateIdentifier_args.fromJson(param)),
      "updateIdentifier",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> resendIdentifierConfirmation(Map param) async {
    return await this.client.request.request(
      LINEStructs.resendIdentifierConfirmation_args(LINETypes.resendIdentifierConfirmation_args.fromJson(param)),
      "resendIdentifierConfirmation",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> confirmIdentifier(Map param) async {
    return await this.client.request.request(
      LINEStructs.confirmIdentifier_args(LINETypes.confirmIdentifier_args.fromJson(param)),
      "confirmIdentifier",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> removeIdentifier(Map param) async {
    return await this.client.request.request(
      LINEStructs.removeIdentifier_args(LINETypes.removeIdentifier_args.fromJson(param)),
      "removeIdentifier",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> issueV3TokenForPrimary(Map param) async {
    return await this.client.request.request(
      LINEStructs.issueV3TokenForPrimary_args(LINETypes.issueV3TokenForPrimary_args.fromJson(param)),
      "issueV3TokenForPrimary",
      this.protocolType,
      true,
      this.requestPath
    );
  }
}