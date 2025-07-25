import '../../core/utils/error.dart';
import '../../service/types.dart';
import '../../core/core.dart';
import '../../../thrift/line_types.dart' as LINETypes;
import '../../../thrift/readwrite/struct.dart' as LINEStructs;

class TalkService extends BaseService {
  @override
  BaseClient client;
  @override
  int protocolType = 4;
  @override
  String requestPath = "/S4";
  @override
  String errorName = "TalkServiceError";

  TalkService(this.client, [this.protocolType = 4, this.requestPath = "/S4", this.errorName = "TalkServiceError"]);

  Future<dynamic> sync(Map param) async {
    return await client.request.request(
      LINEStructs.sync_args(LINETypes.sync_args.fromJson({
        "request": {
          "lastRevision": param["revision"],
          "lastGlobalRevision": param["globalRev"],
          "lastIndividualRevision": param["individualRev"],
          "count": param["limit"] ?? 100,
        }
      })),
      "sync",
      protocolType,
      true,
      requestPath
    );
  }

  Future<LINETypes.Message> sendMessage(Map param) async {
    if ((param["e2ee"] && param["chunks"] != null && param["location"] != null) || (param["e2ee"] && param["chunks"] != null && param["text"])) {
      dynamic chunks = await client.e2ee.encryptE2EEMessage(param["to"], (param["text"] ?? param["location"] ?? "Invalid"), contentType: param["contentType"]);
      Map contentMetadata = {
        "e2eeVersion": "2",
        "contentType": param["contentType"] is LINETypes.ContentType ? param["contentType"].value.toString() : param["contentType"].toString(),
        "e2eeMark": "2"
      };
    contentMetadata.addAll(param["contentMetadata"] ?? {});
    Map options = {
      "to": param["to"],
      "contentType": param["contentType"] is LINETypes.ContentType ? param["contentType"].value.toString() : param["contentType"].toString(),
      "contentMetadata": contentMetadata,
      "relatedMessageId": param["relatedMessageId"],
      "e2ee": param["e2ee"],
      "chunks": chunks,
    };
    return await sendMessage(options);
    }

    Map json = {
      "seq": await client.getReqseq(),
      "message": {
        "reactions": null,
        "to": param["to"],
        "createdTime": 0,
        "deliveredTime": 0,
        "hasContent": false,
        "contentType": param["contentType"] is LINETypes.ContentType ? param["contentType"].value.toString() : param["contentType"].toString(),
        "contentMetadata": param["contentMetadata"] ?? {},
        "text": param["text"] ?? "",
        "location": param["location"],
        "chunks": param["chunks"],
        "relatedMessageId": param["relatedMessageId"],
      }
    };
    json.addAll(param["relatedMessageId"] != null ? { "messageRelationType": "REPLY", "relatedMessageServiceCode": "TALK" } : {});
    List message = LINEStructs.sendMessage_args(LINETypes.sendMessage_args.fromJson(json));
    try {
      return await client.request.request(
        message,
        "sendMessage",
        protocolType,
        true,
        requestPath
      );
    } catch(error) {
      if (error is InternalError && (error.data["code"].toString()).contains("E2EE") && param["e2ee"] == null) {
        param["e2ee"] = true;
        return await sendMessage(param);
      } else {
        rethrow;
      }
    }
  }

  Future<dynamic> getProfile(Map param) async {
    return await client.request.request(
      LINEStructs.getProfile_args(LINETypes.getProfile_args.fromJson(param)),
      "getProfile",
      protocolType,
      "Profile",
      requestPath
    );
  }

  Future<dynamic> getSettings(Map param) async {
    return await client.request.request(
      LINEStructs.getSettings_args(LINETypes.getSettings_args.fromJson(param)),
      "getSettings",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> sendChatChecked(Map param) async {
    return await client.request.request(
      LINEStructs.sendChatChecked_args(LINETypes.sendChatChecked_args.fromJson(param)),
      "sendChatChecked",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> unsendMessage(Map param) async {
    return await client.request.request(
      LINEStructs.unsendMessage_args(LINETypes.unsendMessage_args.fromJson(param)),
      "unsendMessage",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> deleteOtherFromChat(Map param) async {
    return await client.request.request(
      LINEStructs.deleteOtherFromChat_args(LINETypes.deleteOtherFromChat_args.fromJson(param)),
      "deleteOtherFromChat",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> inviteIntoChat(Map param) async {
    return await client.request.request(
      LINEStructs.inviteIntoChat_args(LINETypes.inviteIntoChat_args.fromJson({
        "request": {
          "targetUserMids": param["targetUserMids"],
          "chatMid": param["chatMid"]
        }
      })),
      "inviteIntoChat",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> cancelChatInvitation(Map param) async {
    return await client.request.request(
      LINEStructs.cancelChatInvitation_args(LINETypes.cancelChatInvitation_args.fromJson(param)),
      "cancelChatInvitation",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> deleteSelfFromChat(Map param) async {
    return await client.request.request(
      LINEStructs.deleteSelfFromChat_args(LINETypes.deleteSelfFromChat_args.fromJson(param)),
      "deleteSelfFromChat",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> acceptChatInvitation(Map param) async {
    return await client.request.request(
      LINEStructs.acceptChatInvitation_args(LINETypes.acceptChatInvitation_args.fromJson(param)),
      "acceptChatInvitation",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> reissueChatTicket(Map param) async {
    return await client.request.request(
      LINEStructs.reissueChatTicket_args(LINETypes.reissueChatTicket_args.fromJson(param)),
      "reissueChatTicket",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> findChatByTicket(Map param) async {
    return await client.request.request(
      LINEStructs.findChatByTicket_args(LINETypes.findChatByTicket_args.fromJson(param)),
      "findChatByTicket",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> acceptChatInvitationByTicket(Map param) async {
    return await client.request.request(
      LINEStructs.acceptChatInvitationByTicket_args(LINETypes.acceptChatInvitationByTicket_args.fromJson(param)),
      "acceptChatInvitationByTicket",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> updateChat(Map param) async {
    return await client.request.request(
      LINEStructs.updateChat_args(LINETypes.updateChat_args.fromJson(param)),
      "updateChat",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getAllContactIds(Map param) async {
    return await client.request.request(
      LINEStructs.getAllContactIds_args(LINETypes.getAllContactIds_args.fromJson(param)),
      "getAllContactIds",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getBlockedContactIds(Map param) async {
    return await client.request.request(
      LINEStructs.getBlockedContactIds_args(LINETypes.getBlockedContactIds_args.fromJson(param)),
      "getBlockedContactIds",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getBlockedRecommendationIds(Map param) async {
    return await client.request.request(
      LINEStructs.getBlockedRecommendationIds_args(LINETypes.getBlockedRecommendationIds_args.fromJson(param)),
      "getBlockedRecommendationIds",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> sendPostback(Map param) async {
    return await client.request.request(
      LINEStructs.sendPostback_args(LINETypes.sendPostback_args.fromJson(param)),
      "sendPostback",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getMessageBoxes(Map param) async {
    return await client.request.request(
      LINEStructs.getMessageBoxes_args(LINETypes.getMessageBoxes_args.fromJson(param)),
      "getMessageBoxes",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> getChatRoomAnnouncementBulk(Map param) async {
    return await client.request.request(
      LINEStructs.getChatRoomAnnouncementsBulk_args(LINETypes.getChatRoomAnnouncementsBulk_args.fromJson(param)),
      "getChatRoomAnnouncementBulk",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getChatRoomAnnouncements(Map param) async {
    return await client.request.request(
      LINEStructs.getChatRoomAnnouncements_args(LINETypes.getChatRoomAnnouncements_args.fromJson(param)),
      "getChatRoomAnnouncements",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> removeChatRoomAnnouncement(Map param) async {
    return await client.request.request(
      LINEStructs.removeChatRoomAnnouncement_args(LINETypes.removeChatRoomAnnouncement_args.fromJson(param)),
      "removeChatRoomAnnouncement",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> createChatRoomAnnouncement(Map param) async {
    return await client.request.request(
      LINEStructs.createChatRoomAnnouncement_args(LINETypes.createChatRoomAnnouncement_args.fromJson(param)),
      "createChatRoomAnnouncement",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> leaveRoom(Map param) async {
    return await client.request.request(
      LINEStructs.leaveRoom_args(LINETypes.leaveRoom_args.fromJson(param)),
      "leaveRoom",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getRoomsV2(Map param) async {
    return await client.request.request(
      LINEStructs.getRoomsV2_args(LINETypes.getRoomsV2_args.fromJson(param)),
      "getRoomsV2",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> createRoomV2(Map param) async {
    return await client.request.request(
      LINEStructs.createRoomV2_args(LINETypes.createRoomV2_args.fromJson(param)),
      "createRoomV2",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getCountries(Map param) async {
    return await client.request.request(
      LINEStructs.getCountries_args(LINETypes.getCountries_args.fromJson(param)),
      "getCountries",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> acquireEncryptedAccessToken(Map param) async {
    return await client.request.request(
      LINEStructs.acquireEncryptedAccessToken_args(LINETypes.acquireEncryptedAccessToken_args.fromJson(param)),
      "acquireEncryptedAccessToken",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> blockContact(Map param) async {
    return await client.request.request(
      LINEStructs.blockContact_args(LINETypes.blockContact_args.fromJson(param)),
      "bloakContact",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> unblockContact(Map param) async {
    return await client.request.request(
      LINEStructs.unblockContact_args(LINETypes.unblockContact_args.fromJson(param)),
      "unblockContact",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getConfigurations(Map param) async {
    return await client.request.request(
      LINEStructs.getConfigurations_args(LINETypes.getConfigurations_args.fromJson(param)),
      "getConfigurations",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> fetchOperations(Map param) async {
    return await client.request.request(
      LINEStructs.fetchOperations_args(LINETypes.fetchOperations_args.fromJson(param)),
      "fetchOperations",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getRepairElements(Map param) async {
    return await client.request.request(
      LINEStructs.getRepairElements_args(LINETypes.getRepairElements_args.fromJson(param)),
      "getRepairEements",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getSettingsAttributes2(Map param) async {
    return await client.request.request(
      LINEStructs.getSettingsAttributes2_args(LINETypes.getSettingsAttributes2_args.fromJson(param)),
      "getSettingsAttributes2",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> updateSettingsAttributes2(Map param) async {
    return await client.request.request(
      LINEStructs.updateSettingsAttributes2_args(LINETypes.updateSettingsAttributes2_args.fromJson(param)),
      "updateSettingsAttributes2",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> rejectChatInvitation(Map param) async {
    return await client.request.request(
      LINEStructs.rejectChatInvitation_args(LINETypes.rejectChatInvitation_args.fromJson(param)),
      "rejectChatInvitation",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getE2EEPublicKey(Map param) async {
    return await client.request.request(
      LINEStructs.getE2EEPublicKey_args(LINETypes.getE2EEPublicKey_args.fromJson(param)),
      "getE2EEPublicKey",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getE2EEPublicKeys() async {
    return await client.request.request(
      [],
      "getE2EEPublicKeys",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> registerE2EEPublicKey(Map param) async {
    return await client.request.request(
      LINEStructs.registerE2EEPublicKey_args(LINETypes.registerE2EEPublicKey_args.fromJson(param)),
      "registerE2EEPublicKey",
      protocolType,
      true,
      requestPath
    );
  }

  Future<LINETypes.Pb1_U3> registerE2EEGroupKey(Map param) async {
    return await client.request.request(
      LINEStructs.registerE2EEGroupKey_args(LINETypes.registerE2EEGroupKey_args.fromJson(param)),
      "registerE2EEGroupKey",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getE2EEGroupSharedKey(Map param) async {
    return await client.request.request(
      LINEStructs.getE2EEGroupSharedKey_args(LINETypes.getE2EEGroupSharedKey_args.fromJson(param)),
      "getE2EEGroupSharedKey",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getLastE2EEGroupSharedKey(Map param) async {
    return await client.request.request(
      LINEStructs.getLastE2EEGroupSharedKey_args(LINETypes.getLastE2EEGroupSharedKey_args.fromJson(param)),
      "getLastE2EEGroupSharedKey",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getLastE2EEPublicKeys(Map param) async {
    return await client.request.request(
      LINEStructs.getLastE2EEPublicKeys_args(LINETypes.getLastE2EEPublicKeys_args.fromJson(param)),
      "getLastE2EEPublicKeys",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> negotiateE2EEPublicKey(Map param) async {
    return await client.request.request(
      LINEStructs.negotiateE2EEPublicKey_args(LINETypes.negotiateE2EEPublicKey_args.fromJson(param)),
      "negotiateE2EEPublicKey",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> react(Map param) async {
    return await client.request.request(
      LINEStructs.react_args(LINETypes.react_args.fromJson({
        "reactRequest": {
          "reqSeq": 0,
          "messageId": param["id"],
          "recationType": {
            "predefinedReactionType": param["reaction"] is LINETypes.MessageReactionType ? param["reaction"].value : param["reaction"]
          }
        }
      })),
      "react",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> createChat(Map param) async {
    return await client.request.request(
      LINEStructs.createChat_args(LINETypes.createChat_args.fromJson(param)),
      "createChat",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> setHiddenStatus(Map param) async {
    return await client.request.request(
      LINEStructs.setChatHiddenStatus_args(LINETypes.setChatHiddenStatus_args.fromJson(param)),
      "setChatHiddenStatus",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getFollowers(Map param) async {
    return await client.request.request(
      LINEStructs.getFollowers_args(LINETypes.getFollowers_args.fromJson(param)),
      "getFollowers",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getFollowings(Map param) async {
    return await client.request.request(
      LINEStructs.getFollowings_args(LINETypes.getFollowings_args.fromJson(param)),
      "getFollowings",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> removeFollower(Map param) async {
    return await client.request.request(
      LINEStructs.removeFollower_args(LINETypes.removeFollower_args.fromJson(param)),
      "removeFollower",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> follow(Map param) async {
    return await client.request.request(
      LINEStructs.follow_args(LINETypes.follow_args.fromJson(param)),
      "follow",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> unfollow(Map param) async {
    return await client.request.request(
      LINEStructs.unfollow_args(LINETypes.unfollow_args.fromJson(param)),
      "unfollow",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> bulkFollow(Map param) async {
    return await client.request.request(
      LINEStructs.bulkFollow_args(LINETypes.bulkFollow_args.fromJson(param)),
      "bulkFollow",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> decryptFollowEmid(Map param) async {
    return await client.request.request(
      LINEStructs.decryptFollowEMid_args(LINETypes.decryptFollowEMid_args.fromJson(param)),
      "decryptFollowEmid",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getMessageReadRange(Map param) async {
    return await client.request.request(
      LINEStructs.getMessageReadRange_args(LINETypes.getMessageReadRange_args.fromJson(param)),
      "getMessageReadRange",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getChatRoomBGMs(Map param) async {
    return await client.request.request(
      LINEStructs.getChatRoomBGMs_args(LINETypes.getChatRoomBGMs_args.fromJson(param)),
      "getChatRoomBGMs",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> updateChatRoomBGM(Map param) async {
    return await client.request.request(
      LINEStructs.updateChatRoomBGM_args(LINETypes.updateChatRoomBGM_args.fromJson(param)),
      "updateChatRoomBGM",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> blockRecommendation(Map param) async {
    return await client.request.request(
      LINEStructs.blockRecommendation_args(LINETypes.blockRecommendation_args.fromJson(param)),
      "blockRecommendation",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> unblockRecommendation(Map param) async {
    return await client.request.request(
      LINEStructs.unblockRecommendation_args(LINETypes.unblockRecommendation_args.fromJson(param)),
      "unblockRecommendation",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getRecommendationIds(Map param) async {
    return await client.request.request(
      LINEStructs.getRecommendationIds_args(LINETypes.getRecommendationIds_args.fromJson(param)),
      "getRecommendationIds",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getExtendedProfile(Map param) async {
    return await client.request.request(
      LINEStructs.getExtendedProfile_args(LINETypes.getExtendedProfile_args.fromJson(param)),
      "getExtendedProfile",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> updateExtendedProfileAttribute(Map param) async {
    return await client.request.request(
      LINEStructs.updateExtendedProfileAttribute_args(LINETypes.updateExtendedProfileAttribute_args.fromJson(param)),
      "updateExtendedProfileAttribute",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> setNotificationsEnabled(Map param) async {
    return await client.request.request(
      LINEStructs.setNotificationsEnabled_args(LINETypes.setNotificationsEnabled_args.fromJson(param)),
      "setNotificationsEnabled",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> syncContacts(Map param) async {
    return await client.request.request(
      LINEStructs.syncContacts_args(LINETypes.syncContacts_args.fromJson(param)),
      "syncContacts",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> findContactByPhone(Map param) async {
    return await client.request.request(
      LINEStructs.findContactsByPhone_args(LINETypes.findContactsByPhone_args.fromJson(param)),
      "findContactsByPhone",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> findContactByUserid(Map param) async {
    return await client.request.request(
      LINEStructs.findContactByUserid_args(LINETypes.findContactByUserid_args.fromJson(param)),
      "findContactByUserid",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> updateContactSetting(Map param) async {
    return await client.request.request(
      LINEStructs.updateContactSetting_args(LINETypes.updateContactSetting_args.fromJson(param)),
      "updateContactSetting",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> findContactByUserTicket(Map param) async {
    return await client.request.request(
      LINEStructs.findContactByUserTicket_args(LINETypes.findContactByUserTicket_args.fromJson(param)),
      "findContactByUserTicket",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> veriftQrcode(Map param) async {
    return await client.request.request(
      LINEStructs.verifyQrcode_args(LINETypes.verifyQrcode_args.fromJson(param)),
      "verifyQrcode",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> reportAbuseEx(Map param) async {
    return await client.request.request(
      LINEStructs.reportAbuseEx_args(LINETypes.reportAbuseEx_args.fromJson(param)),
      "reportAbuseEx",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> updateProfileAttributes(Map param) async {
    return await client.request.request(
      LINEStructs.updateProfileAttributes_args(LINETypes.updateProfileAttributes_args.fromJson(param)),
      "updateProfileAttributes",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> updateNotificationToken(Map param) async {
    return await client.request.request(
      LINEStructs.updateNotificationToken_args(LINETypes.updateNotificationToken_args.fromJson(param)),
      "updateNotificationToken",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> tryFriendRequest(Map param) async {
    return await client.request.request(
      LINEStructs.tryFriendRequest_args(LINETypes.tryFriendRequest_args.fromJson(param)),
      "tryFriendRequest",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> generateUserTicket(Map param) async {
    return await client.request.request(
      LINEStructs.generateUserTicket_args(LINETypes.generateUserTicket_args.fromJson(param)),
      "generateUserTicket",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getRecentFriendRequests(Map param) async {
    return await client.request.request(
      LINEStructs.getRecentFriendRequests_args(LINETypes.getRecentFriendRequests_args.fromJson(param)),
      "getRecentFriendRequests",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> resendPinCode(Map param) async {
    return await client.request.request(
      LINEStructs.resendPinCode_args(LINETypes.resendPinCode_args.fromJson(param)),
      "resnedPinCode",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> notifyRegistrationComplete(Map param) async {
    return await client.request.request(
      LINEStructs.notifyRegistrationComplete_args(LINETypes.notifyRegistrationComplete_args.fromJson(param)),
      "notifyRegistrationComplete",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getInstantNews(Map param) async {
    return await client.request.request(
      LINEStructs.getInstantNews_args(LINETypes.getInstantNews_args.fromJson(param)),
      "getInstantNews",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> changeVerificationMethod(Map param) async {
    return await client.request.request(
      LINEStructs.changeVerificationMethod_args(LINETypes.changeVerificationMethod_args.fromJson(param)),
      "changeVerificationMethod",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getChatEffectMetaList(Map param) async {
    return await client.request.request(
      LINEStructs.getChatEffectMetaList_args(LINETypes.getChatEffectMetaList_args.fromJson(param)),
      "getChatEffectMetaList",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> notifyInstalled(Map param) async {
    return await client.request.request(
      LINEStructs.notifyInstalled_args(LINETypes.notifyInstalled_args.fromJson(param)),
      "notifyInstalled",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> reportDeviceState(Map param) async {
    return await client.request.request(
      LINEStructs.reportDeviceState_args(LINETypes.reportDeviceState_args.fromJson(param)),
      "reportDeviceStatus",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> sendChatRemoved(Map param) async {
    return await client.request.request(
      LINEStructs.sendChatRemoved_args(LINETypes.sendChatRemoved_args.fromJson(param)),
      "sendChatRemoved",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> startUpdateVerification(Map param) async {
    return await client.request.request(
      LINEStructs.startUpdateVerification_args(LINETypes.startUpdateVerification_args.fromJson(param)),
      "startUpdateVerifucation",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> inviteIntoRoom(Map param) async {
    return await client.request.request(
      LINEStructs.inviteIntoRoom_args(LINETypes.inviteIntoRoom_args.fromJson(param)),
      "inviteIntoRoom",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> removeFriendRequest(Map param) async {
    return await client.request.request(
      LINEStructs.removeFriendRequest_args(LINETypes.removeFriendRequest_args.fromJson(param)),
      "removeFriendRequest",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> reportProfile(Map param) async {
    return await client.request.request(
      LINEStructs.reportProfile_args(LINETypes.reportProfile_args.fromJson(param)),
      "reportProfile",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> wakeUpLongPolling(Map param) async {
    return await client.request.request(
      LINEStructs.wakeUpLongPolling_args(LINETypes.wakeUpLongPolling_args.fromJson(param)),
      "wakeUpLongPolling",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> updateAndGetNearby(Map param) async {
    return await client.request.request(
      LINEStructs.updateAndGetNearby_args(LINETypes.updateAndGetNearby_args.fromJson(param)),
      "updateAndGetNearby",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> reportSettings(Map param) async {
    return await client.request.request(
      LINEStructs.reportSettings_args(LINETypes.reportSettings_args.fromJson(param)),
      "reportSettings",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> verifyPhoneNumber(Map param) async {
    return await client.request.request(
      LINEStructs.verifyPhoneNumber_args(LINETypes.verifyPhoneNumber_args.fromJson(param)),
      "verifyPhoneNumber",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> isUseridAvailable(Map param) async {
    return await client.request.request(
      LINEStructs.isUseridAvailable_args(LINETypes.isUseridAvailable_args.fromJson(param)),
      "isUseridAvailable",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> registerUserid(Map param) async {
    return await client.request.request(
      LINEStructs.registerUserid_args(LINETypes.registerUserid_args.fromJson(param)),
      "registerUserid",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> finishUpdateVerification(Map param) async {
    return await client.request.request(
      LINEStructs.finishUpdateVerification_args(LINETypes.finishUpdateVerification_args.fromJson(param)),
      "finishUpdateVerification",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> clearRingtone(Map param) async {
    return await client.request.request(
      LINEStructs.clearRingtone_args(LINETypes.clearRingtone_args.fromJson(param)),
      "clearRingtone",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> notifyUpdated(Map param) async {
    return await client.request.request(
      LINEStructs.notifyUpdated_args(LINETypes.notifyUpdated_args.fromJson(param)),
      "notifyUpdated",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> reportPushRecvReports(Map param) async {
    return await client.request.request(
      LINEStructs.reportPushRecvReports_args(LINETypes.reportPushRecvReports_args.fromJson(param)),
      "reportPushRecvReports",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getFriendRequests(Map param) async {
    return await client.request.request(
      LINEStructs.getFriendRequests_args(LINETypes.getFriendRequests_args.fromJson(param)),
      "getFriendRequests",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> addToFollowBlacklist(Map param) async {
    return await client.request.request(
      LINEStructs.addToFollowBlacklist_args(LINETypes.addToFollowBlacklist_args.fromJson(param)),
      "addToFollowBlacklist",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> removeFromFollowBlacklist(Map param) async {
    return await client.request.request(
      LINEStructs.removeFromFollowBlacklist_args(LINETypes.removeFromFollowBlacklist_args.fromJson(param)),
      "removeFromFollowBlacklist",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getFollowBlacklist(Map param) async {
    return await client.request.request(
      LINEStructs.getFollowBlacklist_args(LINETypes.getFollowBlacklist_args.fromJson(param)),
      "getFollowBlacklist",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> determineMediaMessageFlow(Map param) async {
    return await client.request.request(
      LINEStructs.determineMediaMessageFlow_args(LINETypes.determineMediaMessageFlow_args.fromJson(param)),
      "determineMediaMessageFlow",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> createSession(Map param) async {
    return await client.request.request(
      LINEStructs.createSession_args(LINETypes.createSession_args.fromJson(param)),
      "createSession",
      protocolType,
      true,
      requestPath
    );
  }

  Future<void> cancelReaction(Map param) async {
    return await client.request.request(
      LINEStructs.cancelReaction_args(LINETypes.cancelReaction_args.fromJson(param)),
      "cancelReaction",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getNotificationSettings(Map param) async {
    return await client.request.request(
      LINEStructs.getNotificationSettings_args(LINETypes.getNotificationSettings_args.fromJson(param)),
      "getNotificationSettings",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getChats(Map param) async {
    return await client.request.request(
      LINEStructs.getChats_args(LINETypes.getChats_args.fromJson({
        "request": {
          "chatMids": param["chatMids"],
          "withInvitees": param["withInvitees"] ?? true,
          "withMembers": param["withMembers"] ?? true
        },
        "syncReason": "INTERNAL"
      })),
      "getChats",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getChat(Map param) async {
    dynamic res = await getChats({ "chatMids": [param["chatMid"]], "withInvitees": param["withInvitees"], "withMembers": param["withMembers"] });
    return LINETypes.getChats_result.fromJson(res).success.chats[0];
  }

  Future<dynamic> getAllChatMids(Map param) async {
    return await client.request.request(
      LINEStructs.getAllChatMids_args(LINETypes.getAllChatMids_args.fromJson(param)),
      "getAllChatMids",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getPreviousMessageV2WithRequest(Map param) async {
    return await client.request.request(
      LINEStructs.getPreviousMessagesV2WithRequest_args(LINETypes.getPreviousMessagesV2WithRequest_args.fromJson(param)),
      "getPreviousMessageV2WithRequest",
      protocolType,
      true,
      requestPath
    );
  }

  Future<int> getServerTime() async {
    return await client.request.request(
      [],
      "getServerTime",
      protocolType,
      true,
      requestPath
    );
  }

  Future<LINETypes.Contact> getContact(String mid) async {
    return await client.request.request(
      [[11, 2, mid]],
      "getContact",
      protocolType,
      true,
      requestPath
    );
  }

  Future<List<LINETypes.Contact>> getContacts(List<String> mids) async {
    List res =  await client.request.request(
      [[15, 2, [11, mids]]],
      "getContacts",
      protocolType,
      true,
      requestPath
    );
    List<LINETypes.Contact> response = res.map((e) => client.thrift.rename_thrift("Contact", e)) as List<LINETypes.Contact>;
    return response;
  }

  Future<LINETypes.GetContactsV2Response> getContactsV2(List<String> mids) async {
    return await client.request.request(
      [[12, 1, [[15, 1, [11, mids]]]]],
      "getContactsV2",
      protocolType,
      true,
      requestPath
    );
  }
}