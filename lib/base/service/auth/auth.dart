import 'package:linedart/base/core/utils/error.dart';
import 'package:linedart/base/core/core.dart';
import 'package:linedart/thrift/line_types.dart' as LINETypes;
import 'package:linedart/thrift/readwrite/struct.dart' as LINEStructs;
import 'package:linedart/base/service/types.dart';

class AuthService extends BaseService {
  @override
  final BaseClient client;
  @override
  late int protocolType = 4;
  @override
  late String requestPath = "/AS4";
  @override
  late String errorName = "AuthServiceError";

  AuthService(this.client, [this.protocolType = 4, this.requestPath = "/AS4", this.errorName = "AuthServiceError"]);

  dynamic tryRefreshToken() async {
    String? refreshToken = await client.storage.get("refreshToken");
    if (refreshToken is String) {
      dynamic RATR = await refresh({ "request": { "refreshToken": refreshToken }});
      client.authToken = RATR["accessToken"];
      client.emit("update:authToken", { "authToken": RATR["accessToken"] });
      await client.storage.set("expire", (RATR["tokenIssueTimeEpochSec"] as int) + (RATR["durationUntilRefreshInSec"] as int));
    } else {
      throw InternalError("refreshError", "refreshToken not found");
    }
  }

  Future<LINETypes.RefreshAccessTokenResponse> refresh(Map param) async {
    return LINETypes.RefreshAccessTokenResponse.fromJson(await client.request.request(
      LINEStructs.refresh_args(LINETypes.refresh_args.fromJson(param)),
      "refresh",
      protocolType,
      true,
      "/EXT/auth/tokenrefresh/v1"
    ));
  }

  Future<dynamic> reportRefreshedAccessToken(Map param) async {
    return await client.request.request(
      LINEStructs.reportRefreshedAccessToken_args(LINETypes.reportRefreshedAccessToken_args.fromJson(param)),
      "reportRefreshedAccessToken",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> connectEapAccount(Map param) async {
    return await client.request.request(
      LINEStructs.connectEapAccount_args(LINETypes.connectEapAccount_args.fromJson(param)),
      "connectEapAccount",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> disconnectEapAccount(Map param) async {
    return await client.request.request(
      LINEStructs.disconnectEapAccount_args(LINETypes.disconnectEapAccount_args.fromJson(param)),
      "disconnectEapAccount",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> openSession(Map param) async {
    return await client.request.request(
      LINEStructs.openSession_args(LINETypes.openSession_args.fromJson(param)),
      "openSession",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> verifyEapLogin(Map param) async {
    return await client.request.request(
      LINEStructs.verifyEapAccountForRegistration_args(LINETypes.verifyEapAccountForRegistration_args.fromJson(param)),
      "verifyEapLogin",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> updatePassword(Map param) async {
    return await client.request.request(
      LINEStructs.updatePassword_args(LINETypes.updatePassword_args.fromJson(param)),
      "updatePassword",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> establishE2EESession(Map param) async {
    return await client.request.request(
      LINEStructs.establishE2EESession_args(LINETypes.establishE2EESession_args.fromJson(param)),
      "establishE2EESession",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> issueTokenForAccountMigrationSettings(Map param) async {
    return await client.request.request(
      LINEStructs.issueTokenForAccountMigrationSettings_args(LINETypes.issueTokenForAccountMigrationSettings_args.fromJson(param)),
      "issueTokenForAccountMigrationSettings",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> openAuthSession(Map param) async {
    return await client.request.request(
      LINEStructs.openAuthSession_args(LINETypes.openAuthSession_args.fromJson(param)),
      "openAuthSession",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getAuthRSAKey(Map param) async {
    return await client.request.request(
      LINEStructs.getAuthRSAKey_args(LINETypes.getAuthRSAKey_args.fromJson(param)),
      "getAuthRSAKey",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> setIdentifier(Map param) async {
    return await client.request.request(
      LINEStructs.setIdentifier_args(LINETypes.setIdentifier_args.fromJson(param)),
      "setIdentifier",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> updateIdentifier(Map param) async {
    return await client.request.request(
      LINEStructs.updateIdentifier_args(LINETypes.updateIdentifier_args.fromJson(param)),
      "updateIdentifier",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> resendIdentifierConfirmation(Map param) async {
    return await client.request.request(
      LINEStructs.resendIdentifierConfirmation_args(LINETypes.resendIdentifierConfirmation_args.fromJson(param)),
      "resendIdentifierConfirmation",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> confirmIdentifier(Map param) async {
    return await client.request.request(
      LINEStructs.confirmIdentifier_args(LINETypes.confirmIdentifier_args.fromJson(param)),
      "confirmIdentifier",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> removeIdentifier(Map param) async {
    return await client.request.request(
      LINEStructs.removeIdentifier_args(LINETypes.removeIdentifier_args.fromJson(param)),
      "removeIdentifier",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> issueV3TokenForPrimary(Map param) async {
    return await client.request.request(
      LINEStructs.issueV3TokenForPrimary_args(LINETypes.issueV3TokenForPrimary_args.fromJson(param)),
      "issueV3TokenForPrimary",
      protocolType,
      true,
      requestPath
    );
  }
}