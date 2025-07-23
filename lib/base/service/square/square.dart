import '../../service/types.dart';
import '../../core/core.dart';
import '../../../thrift/line_types.dart' as LINETypes;
import '../../../thrift/readwrite/struct.dart' as LINEStructs;

class SquareService extends BaseService {
  BaseClient client;
  int protocolType = 4;
  String requestPath = "/SQ1";
  String errorName = "SquareServiceError";

  SquareService(this.client, [this.protocolType = 4, this.requestPath = "/SQ1", this.errorName = "SquareServiceError"]);

  Future<dynamic> inviteIntoSquareChat(Map param) async {
    return await this.client.request.request(
      LINEStructs.SquareService_inviteIntoSquareChat_args(LINETypes.SquareService_inviteIntoSquareChat_args.fromJson(param)),
      "inviteIntoSquareChat",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> inviteToSquare(Map param) async {
    return await this.client.request.request(
      LINEStructs.SquareService_inviteToSquare_args(LINETypes.SquareService_inviteToSquare_args.fromJson(param)),
      "inviteToSquare",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getJoinedSquares([int? limit, String? continuationToken]) async {
    return await this.client.request.request(
      LINEStructs.SquareService_getJoinedSquares_args(LINETypes.SquareService_getJoinedSquares_args.fromJson({ "limit": limit ?? 100, "continuationToken": continuationToken ?? "" })),
      "getJoinedSquares",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> markAsRead(Map param) async {
    return await this.client.request.request(
      LINEStructs.SquareService_markAsRead_args(LINETypes.SquareService_markAsRead_args.fromJson(param)),
      "markAsRead",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> reactToMessage(Map param) async {
    return await this.client.request.request(
      LINEStructs.SquareService_reactToMessage_args(LINETypes.SquareService_reactToMessage_args.fromJson(param)),
      "reactToMessage",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> findSquareByInvitationTicket(Map param) async {
    return await this.client.request.request(
      LINEStructs.SquareService_findSquareByInvitationTicket_args(LINETypes.SquareService_findSquareByInvitationTicket_args.fromJson(param)),
      "findSquareByInvitationTicket",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> fetchMyEvents([String? syncToken, String? continuationToken, int? limit]) async {
    return await this.client.request.request(
      LINEStructs.SquareService_fetchMyEvents_args(LINETypes.SquareService_fetchMyEvents_args.fromJson({ "request": { "limit": limit ?? 100, "syncToken": syncToken ?? "", "continuationToken": continuationToken ?? "" } })),
      "fetchMyEvents",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> fetchSquareChatEvents(String squareChatMid, [String? threadMid, String? syncToken, int? limit, LINETypes.FetchDirection? direction]) async {
    return await this.client.request.request(
      LINEStructs.SquareService_fetchSquareChatEvents_args(LINETypes.SquareService_fetchSquareChatEvents_args.fromJson({ "request": { "limit": limit ?? 100, "syncToken": syncToken ?? "", "direction": direction ?? 0, "threadMid": threadMid ?? "", "squareChatMid": squareChatMid } })),
      "fetchSquareChatEvents",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> sendMessage(String squareChatMid, [String? text, int? contentType, Map? contentMetadata, String? relatedMessageId, LINETypes.Location? location]) async {
    Map data = {
      "request": {
        "reqSeq": await this.client.getReqSeq("sq"),
        "squareChatMid": squareChatMid,
        "squareMessage": {
          "squareMessageRevision": 4,
          "message": {
            "to": squareChatMid,
            "text": text ?? "",
            "contentType": LINETypes.ContentType.fromValue(contentType ?? 0),
            "contentMetadata": contentMetadata ?? {},
            "location": location,
          }.addAll(
            relatedMessageId != null
            ? {
                "relatedMessageId": relatedMessageId,
                "relatedMessageServiceCode":"SQUARE",
                "messageRelationType": "REPLY"
              }
            : {},
          ),
        }
      }
    };
    return await this.client.request.request(
      LINEStructs.SquareService_sendMessage_args(LINETypes.SquareService_sendMessage_args.fromJson(data)),
      "sendMessage",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getSquare(String squareMid) async {
    return await this.client.request.request(
      LINEStructs.SquareService_getSquare_args(LINETypes.SquareService_getSquare_args.fromJson({ "request": { "mid": squareMid } })),
      "getSquare",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getJoinableSquareChats(Map param) async {
    return await this.client.request.request(
      LINEStructs.SquareService_getJoinableSquareChats_args(LINETypes.SquareService_getJoinableSquareChats_args.fromJson(param)),
      "getJoinableSquareChats",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  String defaultSquareCoverImageObsHash = "0h6tJfahRYaVt3H0eLAsAWDFheczgHd3wTCTx2eApNKSoefHNVGRdwfgxbdgUMLi8MSngnPFMeNmpbLi8MSngnPFMeNmpbLi8MSngnPQ";

  Future<dynamic> createSquare(String squareName, String displayName, [String? profileImageObsHash, String? description, bool? searchable, int? SquareJoinMethodType]) async {
    return await this.client.request.request(
      LINEStructs.SquareService_createSquare_args(LINETypes.SquareService_createSquare_args.fromJson({
        "request": {
          "reqSeq": await this.client.getReqseq("sq"),
          "square": {
            "name": squareName,
            "profileImageObshash": profileImageObsHash ?? defaultSquareCoverImageObsHash,
            "desc": description ?? "",
            "searchable": searchable ?? false,
            "type": "OPEN",
            "categoryId": 1,
            "revision": 0,
            "ableToUseInvitationTicket": true,
            "joinMethod": { "type": SquareJoinMethodType ?? 0 },
            "adualtOnly": "NONE",
            "svcTags": [],
          },
          "creator": {
            "displayName": displayName,
            "ableToReceiveMessage": true,
            "revision": 0
          }
        }
      })),
      "createSquare",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getSquareChatAnnouncements(Map param) async {
    return await this.client.request.request(
      LINEStructs.SquareService_getSquareChatAnnouncements_args(LINETypes.SquareService_getSquareChatAnnouncements_args.fromJson(param)),
      "getSquareChatAnnouncements",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> leaveSquareChat(Map param) async {
    return await this.client.request.request(
      LINEStructs.SquareService_leaveSquareChat_args(LINETypes.SquareService_leaveSquareChat_args.fromJson(param)),
      "leaveSquareChat",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getSquareChatMember(Map param) async {
    return await this.client.request.request(
      LINEStructs.SquareService_getSquareChatMember_args(LINETypes.SquareService_getSquareChatMember_args.fromJson(param)),
      "getSquareChatMember",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> searchSquares(Map param) async {
    return await this.client.request.request(
      LINEStructs.SquareService_searchSquares_args(LINETypes.SquareService_searchSquares_args.fromJson(param)),
      "searcSquares",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> updateSquareFeatureSet(Map param) async {
    return await this.client.request.request(
      LINEStructs.SquareService_updateSquareFeatureSet_args(LINETypes.SquareService_updateSquareFeatureSet_args.fromJson(param)),
      "updateSquareFeatureSet",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> joinSquare(String squareMid, String displayName, [bool? ableToReceiveMessage, String? passCode, String? joinMessage]) async {
    return await this.client.request.request(
      LINEStructs.SquareService_joinSquare_args(LINETypes.SquareService_joinSquare_args.fromJson({
        "request": {
          "squareMid": squareMid,
          "joinValue": {
            "approvalValue": { "message": joinMessage ?? "" },
            "codeValue": { "code": passCode }
          },
          "member": {
            "squareMid": squareMid,
            "displayName": displayName,
            "ableToReceiveMessage": ableToReceiveMessage ?? true,
            "revision": 0
          }
        }
      })),
      "joinSquare",
      this.protocolType,
      true,
      this.requestPath
    );
  }
}