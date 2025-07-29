import '../../service/types.dart';
import '../../core/core.dart';
import '../../../thrift/line_types.dart' as LINETypes;
import '../../../thrift/readwrite/struct.dart' as LINEStructs;

class SquareService extends BaseService {
  @override
  BaseClient client;
  @override
  int protocolType = 4;
  @override
  String requestPath = "/SQ1";
  @override
  String errorName = "SquareServiceError";

  SquareService(this.client, [this.protocolType = 4, this.requestPath = "/SQ1", this.errorName = "SquareServiceError"]);

  Future<dynamic> inviteIntoSquareChat(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_inviteIntoSquareChat_args(LINETypes.SquareService_inviteIntoSquareChat_args.fromJson(param)),
      "inviteIntoSquareChat",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> inviteToSquare(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_inviteToSquare_args(LINETypes.SquareService_inviteToSquare_args.fromJson(param)),
      "inviteToSquare",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getJoinedSquares([int? limit, String? continuationToken]) async {
    return await client.request.request(
      LINEStructs.SquareService_getJoinedSquares_args(LINETypes.SquareService_getJoinedSquares_args.fromJson({ "limit": limit ?? 100, "continuationToken": continuationToken ?? "" })),
      "getJoinedSquares",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> markAsRead(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_markAsRead_args(LINETypes.SquareService_markAsRead_args.fromJson(param)),
      "markAsRead",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> reactToMessage(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_reactToMessage_args(LINETypes.SquareService_reactToMessage_args.fromJson(param)),
      "reactToMessage",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> findSquareByInvitationTicket(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_findSquareByInvitationTicket_args(LINETypes.SquareService_findSquareByInvitationTicket_args.fromJson(param)),
      "findSquareByInvitationTicket",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> fetchMyEvents([String? syncToken, String? continuationToken, int? limit]) async {
    return await client.request.request(
      LINEStructs.SquareService_fetchMyEvents_args(LINETypes.SquareService_fetchMyEvents_args.fromJson({ "request": { "limit": limit ?? 100, "syncToken": syncToken ?? "", "continuationToken": continuationToken ?? "" } })),
      "fetchMyEvents",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> fetchSquareChatEvents(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_fetchSquareChatEvents_args(LINETypes.SquareService_fetchSquareChatEvents_args.fromJson({ "request": { "limit": param["limit"] ?? 100, "syncToken": param["syncToken"], "direction": param["direction"], "threadMid": param["threadMid"], "squareChatMid": param["squareChatMid"] } })),
      "fetchSquareChatEvents",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> sendMessage(Map param) async {
    Map data = {
      "request": {
        "reqSeq": await client.getReqseq("sq"),
        "squareChatMid": param["squareChatMid"],
        "squareMessage": {
          "squareMessageRevision": 4,
          "message": {
            "to": param["squareChatMid"],
            "text": param["text"] ?? "",
            "contentType": LINETypes.ContentType.fromValue(param["contentType"] ?? 0),
            "contentMetadata": param["contentMetadata"] ?? {},
            "location": param["location"],
          },
        }
      }
    };
    data["request"]["squareMessage"]["message"].addAll(
            param["relatedMessageId"] != null
            ? {
                "relatedMessageId": param["relatedMessageId"],
                "relatedMessageServiceCode":"SQUARE",
                "messageRelationType": "REPLY"
              }
            : {},
          );
    return await client.request.request(
      LINEStructs.SquareService_sendMessage_args(LINETypes.SquareService_sendMessage_args.fromJson(data)),
      "sendMessage",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getSquare(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getSquare_args(LINETypes.SquareService_getSquare_args.fromJson({ "request": { "mid": param["squareMid"] } })),
      "getSquare",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getJoinableSquareChats(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getJoinableSquareChats_args(LINETypes.SquareService_getJoinableSquareChats_args.fromJson(param)),
      "getJoinableSquareChats",
      protocolType,
      true,
      requestPath
    );
  }

  String defaultSquareCoverImageObsHash = "0h6tJfahRYaVt3H0eLAsAWDFheczgHd3wTCTx2eApNKSoefHNVGRdwfgxbdgUMLi8MSngnPFMeNmpbLi8MSngnPFMeNmpbLi8MSngnPQ";

  Future<dynamic> createSquare(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_createSquare_args(LINETypes.SquareService_createSquare_args.fromJson({
        "request": {
          "reqSeq": await client.getReqseq("sq"),
          "square": {
            "name": param["squareName"],
            "profileImageObshash": param["profileImageObsHash"] ?? defaultSquareCoverImageObsHash,
            "desc": param["description"] ?? "",
            "searchable": param["searchable"] ?? false,
            "type": "OPEN",
            "categoryId": 1,
            "revision": 0,
            "ableToUseInvitationTicket": true,
            "joinMethod": { "type": param["SquareJoinMethodType"] ?? 0 },
            "adualtOnly": "NONE",
            "svcTags": [],
          },
          "creator": {
            "displayName": param["displayName"],
            "ableToReceiveMessage": true,
            "revision": 0
          }
        }
      })),
      "createSquare",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getSquareChatAnnouncements(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getSquareChatAnnouncements_args(LINETypes.SquareService_getSquareChatAnnouncements_args.fromJson(param)),
      "getSquareChatAnnouncements",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> leaveSquareChat(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_leaveSquareChat_args(LINETypes.SquareService_leaveSquareChat_args.fromJson(param)),
      "leaveSquareChat",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getSquareChatMember(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getSquareChatMember_args(LINETypes.SquareService_getSquareChatMember_args.fromJson(param)),
      "getSquareChatMember",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> searchSquares(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_searchSquares_args(LINETypes.SquareService_searchSquares_args.fromJson(param)),
      "searcSquares",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> updateSquareFeatureSet(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_updateSquareFeatureSet_args(LINETypes.SquareService_updateSquareFeatureSet_args.fromJson(param)),
      "updateSquareFeatureSet",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> joinSquare(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_joinSquare_args(LINETypes.SquareService_joinSquare_args.fromJson({
        "request": {
          "squareMid": param["squareMid"],
          "joinValue": {
            "approvalValue": { "message": param["joinMessage"] ?? "" },
            "codeValue": { "code": param["passCode"] }
          },
          "member": {
            "squareMid": param["squareMid"],
            "displayName": param["displayName"],
            "ableToReceiveMessage": param["ableToReceiveMessage"] ?? true,
            "revision": 0
          }
        }
      })),
      "joinSquare",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getPopularKeywords(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getPopularKeywords_args(LINETypes.SquareService_getPopularKeywords_args.fromJson(param)),
      "getPopularKeywords",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> reportSquareMessage(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_reportSquareMessage_args(LINETypes.SquareService_reportSquareMessage_args.fromJson(param)),
      "reportSquareMessage",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> updateSquareMemberRelation(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_updateSquareMemberRelation_args(LINETypes.SquareService_updateSquareMemberRelation_args.fromJson(param)),
      "updateSquareMemberRelation",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> leaveSquare(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_leaveSquare_args(LINETypes.SquareService_leaveSquare_args.fromJson(param)),
      "leaveSquare",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getSquareMemberRelations(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getSquareMemberRelations_args(LINETypes.SquareService_getSquareMemberRelations_args.fromJson(param)),
      "getSquareMemberRelations",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> removeSubscriptions(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_removeSubscriptions_args(LINETypes.SquareService_removeSubscriptions_args.fromJson(param)),
      "removeSubscriptions",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getSquareMembers(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getSquareMembers_args(LINETypes.SquareService_getSquareMembers_args.fromJson(param)),
      "getSquareMembers",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> updateSquareChat(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_updateSquareChat_args(LINETypes.SquareService_updateSquareChat_args.fromJson(param)),
      "updateSquareChat",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> destroyMessage(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_destroyMessage_args(LINETypes.SquareService_destroyMessage_args.fromJson({
        "request": {
          "messageId": param["messageId"],
          "squareChatMid": param["squareChatMid"],
          "threadMid": param["threadMid"]
        }
      })),
      "destroyMessage",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> reportSquareChat(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_reportSquareChat_args(LINETypes.SquareService_reportSquareChat_args.fromJson(param)),
      "reportSquareChat",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> unsendMessage(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_unsendMessage_args(LINETypes.SquareService_unsendMessage_args.fromJson({
        "request": {
          "messageId": param["messageId"],
          "squarechatMid": param["squareChatMid"],
          "threadMid": param["threadMid"]
        }
      })),
      "unsendMessage",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> deleteSquareChatAnnouncement(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_deleteSquareChat_args(LINETypes.SquareService_deleteSquareChat_args.fromJson(param)),
      "deleteSquareChatAnnouncement",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> createSquareChat(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_createSquareChat_args(LINETypes.SquareService_createSquareChat_args.fromJson(param)),
      "createSquareChat",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> deleteSquareChat(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_deleteSquareChat_args(LINETypes.SquareService_deleteSquareChat_args.fromJson(param)),
      "deleteSquareChat",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getSquareChatMembers(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getSquareChatMembers_args(LINETypes.SquareService_getSquareChatMembers_args.fromJson({
        "request": {
          "continuationToken": param["continuationToken"],
          "squareChatMid": param["squareChatMid"],
          "limit": param["limit"] ?? 100
        }
      })),
      "getSquareChatMembers",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getSquareFeatureSet(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getSquareFeatureSet_args(LINETypes.SquareService_getSquareFeatureSet_args.fromJson(param)),
      "getSquareFeatureSet",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> updateSquareAuthority(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_updateSquareAuthority_args(LINETypes.SquareService_updateSquareAuthority_args.fromJson(param)),
      "updateSquareAuthority",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> rejectSquareMember(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_rejectSquareMembers_args(LINETypes.SquareService_rejectSquareMembers_args.fromJson(param)),
      "rejectSquareMember",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> deleteSquare(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_deleteSquare_args(LINETypes.SquareService_deleteSquare_args.fromJson(param)),
      "deleteSquare",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> reportSquare(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_reportSquare_args(LINETypes.SquareService_reportSquare_args.fromJson(param)),
      "reportSquare",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getInvitationTicketUrl(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getInvitationTicketUrl_args(LINETypes.SquareService_getInvitationTicketUrl_args.fromJson(param)),
      "getInvitationUrl",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> updateSquareChatMember(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_updateSquareChatMember_args(LINETypes.SquareService_updateSquareChatMember_args.fromJson(param)),
      "updateSquareChatMember",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> updateSquareMember(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_updateSquareMember_args(LINETypes.SquareService_updateSquareMember_args.fromJson(param)),
      "updateSquareMember",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> updateSquare(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_updateSquare_args(LINETypes.SquareService_updateSquare_args.fromJson(param)),
      "updateSquare",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getSquareAuthorities(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getSquareAuthorities_args(LINETypes.SquareService_getSquareAuthorities_args.fromJson(param)),
      "getSquareAuthorities",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> updateSquareMembers(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_updateSquareMembers_args(LINETypes.SquareService_updateSquareMembers_args.fromJson(param)),
      "updateSquareMembers",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getSquareChatStatus(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getSquareChatStatus_args(LINETypes.SquareService_getSquareChatStatus_args.fromJson(param)),
      "getSquareChatStatus",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> approveSquareMembers(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_approveSquareMembers_args(LINETypes.SquareService_approveSquareMembers_args.fromJson(param)),
      "approveSquareChatMembers",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getSquareStatus(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getSquareStatus_args(LINETypes.SquareService_getSquareStatus_args.fromJson(param)),
      "getSquareStatus",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> searchSquareMembers(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_searchSquareMembers_args(LINETypes.SquareService_searchSquareMembers_args.fromJson(param)),
      "searchSquareMembers",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> checkJoinCode(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_checkJoinCode_args(LINETypes.SquareService_checkJoinCode_args.fromJson(param)),
      "checkJoinCode",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> createSquareChatAnnouncement(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_createSquareChatAnnouncement_args(LINETypes.SquareService_createSquareChatAnnouncement_args.fromJson({
        "createSquareChatAnnouncementRequest": {
          "reqSeq": 0,
          "squareChatMid": param["squareChatMid"],
          "squareChatAnnouncement": {
            "announcementSeq": 0,
            "contents": {
              "textMessageAnnouncementContents": {
                "senderSquareMemberMid": param["senderMid"],
                "messageId": param["messageId"],
                "text": param["text"],
              }
            },
            "createdAt": param["createdAt"],
            "type": 0
          }
        }
      })),
      "createSquareChatAnnouncement",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getSquareAuthority(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getSquareAuthority_args(LINETypes.SquareService_getSquareAuthority_args.fromJson(param)),
      "getSquareAuthority",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getSquareChat(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getSquareChat_args(LINETypes.SquareService_getSquareChat_args.fromJson({
        "request": { "squareChatMid": param["squareChatMid"] }
      })),
      "getSquareChat",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> refreshSubscriptions(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_refreshSubscriptions_args(LINETypes.SquareService_refreshSubscriptions_args.fromJson(param)),
      "refreshSubscriptions",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> joinSquareChat(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_joinSquareChat_args(LINETypes.SquareService_joinSquareChat_args.fromJson(param)),
      "joinSquareChat",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> findSquareByEmid(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_findSquareByEmid_args(LINETypes.SquareService_findSquareByEmid_args.fromJson(param)),
      "findSquareByEmid",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getSquareMemberRelation(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getSquareMemberRelation_args(LINETypes.SquareService_getSquareMemberRelation_args.fromJson(param)),
      "getSquareMemberRelation",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getSquareMember(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getSquareMember_args(LINETypes.SquareService_getSquareMember_args.fromJson({
        "request": param
      })),
      "getSquareMember",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> destroyMessages(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_destroyMessages_args(LINETypes.SquareService_destroyMessages_args.fromJson(param)),
      "destroyMessages",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getCategories(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getCategories_args(LINETypes.SquareService_getCategories_args.fromJson(param)),
      "getCategories",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> reportSquareMember(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_reportSquareMember_args(LINETypes.SquareService_reportSquareMember_args.fromJson(param)),
      "reportSquareMember",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getNoteStatus(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getNoteStatus_args(LINETypes.SquareService_getNoteStatus_args.fromJson(param)),
      "getNoteStatus",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> searchSquareChatMembers(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_searchSquareMembers_args(LINETypes.SquareService_searchSquareMembers_args.fromJson({
        "request": {
          "searchOption": param["searchOption"],
          "continuationToken": param["continuationToken"],
          "squareChatMid": param["squareChatMid"],
          "limit": param["limit"] ?? 100,
        }
      })),
      "searchSquareChatMembers",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getSquareChatFeatureSet(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getSquareChatFeatureSet_args(LINETypes.SquareService_getSquareChatFeatureSet_args.fromJson(param)),
      "getSquareChatFeatureSet",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getSquareEmid(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getSquareEmid_args(LINETypes.SquareService_getSquareEmid_args.fromJson(param)),
      "getSquareEmid",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> manualRepair(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_manualRepair_args(LINETypes.SquareService_manualRepair_args.fromJson(param)),
      "manualRepair",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> syncSquareMembers(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_syncSquareMembers_args(LINETypes.SquareService_syncSquareMembers_args.fromJson(param)),
      "syncSquareMembers",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> hideSquareMemberContents(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_hideSquareMemberContents_args(LINETypes.SquareService_hideSquareMemberContents_args.fromJson(param)),
      "hideSquareMemberContents",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> markChatsAsRead(Map param) async {
    return await client.request.request(
      LINEStructs.MarkChatsAsReadRequest(LINETypes.MarkChatsAsReadRequest.fromJson(param)),
      "markChatsAsRead",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> reportMessageSummary(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_reportMessageSummary_args(LINETypes.SquareService_reportMessageSummary_args.fromJson(param)),
      "reportMessageSummary",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getGoogleAdOptions(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getGoogleAdOptions_args(LINETypes.SquareService_getGoogleAdOptions_args.fromJson(param)),
      "getGoogleAdOptions",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> unhideSquareMemberContents(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_unhideSquareMemberContents_args(LINETypes.SquareService_unhideSquareMemberContents_args.fromJson(param)),
      "unhideSquareMemberContents",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getSquareChatEmid(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getSquareChatEmid_args(LINETypes.SquareService_getSquareChatEmid_args.fromJson(param)),
      "getSquareChatEmid",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getSquareThread(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getSquareThread_args(LINETypes.SquareService_getSquareThread_args.fromJson(param)),
      "getSquareThread",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getSquareThreadMid(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getSquareThreadMid_args(LINETypes.SquareService_getSquareThreadMid_args.fromJson(param)),
      "getSquareThreadMid",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getUserSettings(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_getUserSettings_args(LINETypes.SquareService_getUserSettings_args.fromJson(param)),
      "getUserSettings",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> markThreadsAsRead(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_markThreadsAsRead_args(LINETypes.SquareService_markThreadsAsRead_args.fromJson(param)),
      "markThreadsAsRead",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> sendSquareThreadMessage(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_sendSquareThreadMessage_args(LINETypes.SquareService_sendSquareThreadMessage_args.fromJson(param)),
      "sendSquareThreadMessage",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> findSquareByInvitationTicketV2(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_findSquareByInvitationTicketV2_args(LINETypes.SquareService_findSquareByInvitationTicketV2_args.fromJson(param)),
      "findSquareByInvitationTicketV2",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> leaveSquareThread(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_leaveSquareThread_args(LINETypes.SquareService_leaveSquareThread_args.fromJson(param)),
      "leaveSquareThread",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> joinSquareThread(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_joinSquareThread_args(LINETypes.SquareService_joinSquareThread_args.fromJson(param)),
      "joinSquareThread",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> updateUserSettings(Map param) async {
    return await client.request.request(
      LINEStructs.SquareService_updateUserSettings_args(LINETypes.SquareService_updateUserSettings_args.fromJson(param)),
      "updateUserSettings",
      protocolType,
      true,
      requestPath
    );
  }
}