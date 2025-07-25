import '../../service/types.dart';
import '../../core/core.dart';
import '../../../thrift/line_types.dart' as LINETypes;
import '../../../thrift/readwrite/struct.dart' as LINEStructs;

class SquareLiveTalkService extends BaseService {
  @override
  BaseClient client;
  @override
  int protocolType = 4;
  @override
  String requestPath = "/SQLV1";
  @override
  String errorName = "SquareLiveTalkServiceError";

  SquareLiveTalkService(this.client, [this.protocolType = 4, this.requestPath = "/SQLV1", this.errorName = "SquareLiveTalkServiceError"]);

  Future<dynamic> acceptSpeaker(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_acceptSpeakers_args(LINETypes.SquareService_acceptSpeakers_args.fromJson(param)),
      "acceptSpeakers",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> acceptToChangeRole(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_acceptToChangeRole_args(LINETypes.SquareService_acceptToChangeRole_args.fromJson(param)),
      "acceptToChangeRole",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> acceptToListen(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_acceptToListen_args(LINETypes.SquareService_acceptToListen_args.fromJson(param)),
      "acceptToListen",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> acceptToSpeak(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_acceptToSpeak_args(LINETypes.SquareService_acceptToSpeak_args.fromJson(param)),
      "acceptToSpeak",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> cancelToSpeak(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_cancelToSpeak_args(LINETypes.SquareService_cancelToSpeak_args.fromJson(param)),
      "cancelToSpeak",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> fetchLiveTalkEvents(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_fetchLiveTalkEvents_args(LINETypes.SquareService_fetchLiveTalkEvents_args.fromJson(param)),
      "fetchLiveTalkEvents",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> findLiveTalkByInvitationTicket(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_findLiveTalkByInvitationTicket_args(LINETypes.SquareService_findLiveTalkByInvitationTicket_args.fromJson(param)),
      "findLiveTalkByInvitationTicket",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> forceEndLiveTalk(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_forceEndLiveTalk_args(LINETypes.SquareService_forceEndLiveTalk_args.fromJson(param)),
      "forceEndLiveTalk",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getLiveTalkInfoForNonMember(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getLiveTalkInfoForNonMember_args(LINETypes.SquareService_getLiveTalkInfoForNonMember_args.fromJson(param)),
      "getLiveTalkInfoForNonMember",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getLiveTalkInvitationUrl(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getLiveTalkInvitationUrl_args(LINETypes.SquareService_getLiveTalkInvitationUrl_args.fromJson(param)),
      "getLiveTalkInvitationUrl",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getLiveTalkSpeakersForNonMember(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getLiveTalkSpeakersForNonMember_args(LINETypes.SquareService_getLiveTalkSpeakersForNonMember_args.fromJson(param)),
      "getLiveTalkSpeakersForNonMember",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getSquareInfoByChatMid(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getSquareInfoByChatMid_args(LINETypes.SquareService_getSquareInfoByChatMid_args.fromJson(param)),
      "getSquareInfoByChatMid",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> inviteToChangeRole(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_inviteToChangeRole_args(LINETypes.SquareService_inviteToChangeRole_args.fromJson(param)),
      "inviteToChangeRole",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> inviteToListen(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_inviteToListen_args(LINETypes.SquareService_inviteToListen_args.fromJson(param)),
      "inviteToListen",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> inviteToLiveTalk(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_inviteToLiveTalk_args(LINETypes.SquareService_inviteToLiveTalk_args.fromJson(param)),
      "inviteToLiveTalk",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> inviteToSpeak(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_inviteToSpeak_args(LINETypes.SquareService_inviteToSpeak_args.fromJson(param)),
      "inviteToSpeak",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> joinLiveTalk(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_joinLiveTalk_args(LINETypes.SquareService_joinLiveTalk_args.fromJson(param)),
      "joinLiveTalk",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> kickOutLiveTalkParticipants(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_kickOutLiveTalkParticipants_args(LINETypes.SquareService_kickOutLiveTalkParticipants_args.fromJson(param)),
      "kickOutLiveTalkParticipants",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> rejectSpeakers(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_rejectSpeakers_args(LINETypes.SquareService_rejectSpeakers_args.fromJson(param)),
      "rejectSpeakers",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> rejectToSpeak(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_rejectToSpeak_args(LINETypes.SquareService_rejectToSpeak_args.fromJson(param)),
      "rejectToSpeak",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> reportLiveTalk(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_reportLiveTalk_args(LINETypes.SquareService_reportLiveTalk_args.fromJson(param)),
      "reportLiveTalk",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> reportLiveTalkSpeaker(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_reportLiveTalkSpeaker_args(LINETypes.SquareService_reportLiveTalkSpeaker_args.fromJson(param)),
      "reportLiveTalkSpeaker",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> requestToListen(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_requestToListen_args(LINETypes.SquareService_requestToListen_args.fromJson(param)),
      "requestToListen",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> requestToSpeak(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_requestToSpeak_args(LINETypes.SquareService_requestToSpeak_args.fromJson(param)),
      "requestToSpeak",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> updateLiveTalkAttr(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_updateLiveTalkAttrs_args(LINETypes.SquareService_updateLiveTalkAttrs_args.fromJson(param)),
      "updateLivaTalkAttrs",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> acquireLiveTalk(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_acquireLiveTalk_args(LINETypes.SquareService_acquireLiveTalk_args.fromJson(param)),
      "acquireLivaTalk",
      protocolType,
      true,
      requestPath
    );
  }
}