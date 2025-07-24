import 'package:linedart/base/core/utils/error.dart';

import '../../service/types.dart';
import '../../core/core.dart';
import '../../../thrift/line_types.dart' as LINETypes;
import '../../../thrift/readwrite/struct.dart' as LINEStructs;

class TalkService extends BaseService {
  BaseClient client;
  int protocolType = 4;
  String requestPath = "/S4";
  String errorName = "TalkServiceError";

  TalkService(this.client, [this.protocolType = 4, this.requestPath = "/S4", this.errorName = "TalkServiceError"]);

  Future<dynamic> sync(Map param) async {
    return await this.client.request.request(
      LINEStructs.sync_args(LINETypes.sync_args.fromJson({
        "request": {
          "lastRevision": param["revision"],
          "lastGlobalRevision": param["globalRev"],
          "lastIndividualRevision": param["individualRev"],
          "count": param["limit"] ?? 100,
        }
      })),
      "sync",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<LINETypes.Message> sendMessage(Map param) async {
    if ((param["e2ee"] && param["chunks"] != null && param["location"] != null) || (param["e2ee"] && param["chunks"] != null && param["text"])) {
      dynamic chunks = await this.client.e2ee.encryptE2EEMessage(param["to"], (param["text"] ?? param["location"] ?? "Invalid"), contentType: param["contentType"]);
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
    return await this.sendMessage(options);
    }

    Map json = {
      "seq": await this.client.getReqseq(),
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
      return await this.client.request.request(
        message,
        "sendMessage",
        this.protocolType,
        true,
        this.requestPath
      );
    } catch(error) {
      if (error is InternalError && (error.data["code"].toString()).contains("E2EE") && param["e2ee"] == null) {
        param["e2ee"] = true;
        return await this.sendMessage(param);
      } else {
        throw error;
      }
    }
  }

  Future<dynamic> getProfile(Map param) async {
    return await this.client.request.request(
      LINEStructs.getProfile_args(LINETypes.getProfile_args.fromJson(param)),
      "getProfile",
      this.protocolType,
      "Profile",
      this.requestPath
    );
  }

  Future<dynamic> getSettings(Map param) async {
    return await this.client.request.request(
      LINEStructs.getSettings_args(LINETypes.getSettings_args.fromJson(param)),
      "getSettings",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> sendChatChecked(Map param) async {
    return await this.client.request.request(
      LINEStructs.sendChatChecked_args(LINETypes.sendChatChecked_args.fromJson(param)),
      "sendChatChecked",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> unsendMessage(Map param) async {
    return await this.client.request.request(
      LINEStructs.unsendMessage_args(LINETypes.unsendMessage_args.fromJson(param)),
      "unsendMessage",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> deleteOtherFromChat(Map param) async {
    return await this.client.request.request(
      LINEStructs.deleteOtherFromChat_args(LINETypes.deleteOtherFromChat_args.fromJson(param)),
      "deleteOtherFromChat",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> inviteIntoChat(Map param) async {
    return await this.client.request.request(
      LINEStructs.inviteIntoChat_args(LINETypes.inviteIntoChat_args.fromJson({
        "request": {
          "targetUserMids": param["targetUserMids"],
          "chatMid": param["chatMid"]
        }
      })),
      "inviteIntoChat",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> cancelChatInvitation(Map param) async {
    return await this.client.request.request(
      LINEStructs.cancelChatInvitation_args(LINETypes.cancelChatInvitation_args.fromJson(param)),
      "cancelChatInvitation",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> deleteSelfFromChat(Map param) async {
    return await this.client.request.request(
      LINEStructs.deleteSelfFromChat_args(LINETypes.deleteSelfFromChat_args.fromJson(param)),
      "deleteSelfFromChat",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> acceptChatInvitation(Map param) async {
    return await this.client.request.request(
      LINEStructs.acceptChatInvitation_args(LINETypes.acceptChatInvitation_args.fromJson(param)),
      "acceptChatInvitation",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> reissueChatTicket(Map param) async {
    return await this.client.request.request(
      LINEStructs.reissueChatTicket_args(LINETypes.reissueChatTicket_args.fromJson(param)),
      "reissueChatTicket",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> findChatByTicket(Map param) async {
    return await this.client.request.request(
      LINEStructs.findChatByTicket_args(LINETypes.findChatByTicket_args.fromJson(param)),
      "findChatByTicket",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> acceptChatInvitationByTicket(Map param) async {
    return await this.client.request.request(
      LINEStructs.acceptChatInvitationByTicket_args(LINETypes.acceptChatInvitationByTicket_args.fromJson(param)),
      "acceptChatInvitationByTicket",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> updateChat(Map param) async {
    return await this.client.request.request(
      LINEStructs.updateChat_args(LINETypes.updateChat_args.fromJson(param)),
      "updateChat",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getAllContactIds(Map param) async {
    return await this.client.request.request(
      LINEStructs.getAllContactIds_args(LINETypes.getAllContactIds_args.fromJson(param)),
      "getAllContactIds",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getBlockedContactIds(Map param) async {
    return await this.client.request.request(
      LINEStructs.getBlockedContactIds_args(LINETypes.getBlockedContactIds_args.fromJson(param)),
      "getBlockedContactIds",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getBlockedRecommendationIds(Map param) async {
    return await this.client.request.request(
      LINEStructs.getBlockedRecommendationIds_args(LINETypes.getBlockedRecommendationIds_args.fromJson(param)),
      "getBlockedRecommendationIds",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> sendPostback(Map param) async {
    return await this.client.request.request(
      LINEStructs.sendPostback_args(LINETypes.sendPostback_args.fromJson(param)),
      "sendPostback",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getMessageBoxes(Map param) async {
    return await this.client.request.request(
      LINEStructs.getMessageBoxes_args(LINETypes.getMessageBoxes_args.fromJson(param)),
      "getMessageBoxes",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> getChatRoomAnnouncementBulk(Map param) async {
    return await this.client.request.request(
      LINEStructs.getChatRoomAnnouncementsBulk_args(LINETypes.getChatRoomAnnouncementsBulk_args.fromJson(param)),
      "getChatRoomAnnouncementBulk",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getChatRoomAnnouncements(Map param) async {
    return await this.client.request.request(
      LINEStructs.getChatRoomAnnouncements_args(LINETypes.getChatRoomAnnouncements_args.fromJson(param)),
      "getChatRoomAnnouncements",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> removeChatRoomAnnouncement(Map param) async {
    return await this.client.request.request(
      LINEStructs.removeChatRoomAnnouncement_args(LINETypes.removeChatRoomAnnouncement_args.fromJson(param)),
      "removeChatRoomAnnouncement",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> createChatRoomAnnouncement(Map param) async {
    return await this.client.request.request(
      LINEStructs.createChatRoomAnnouncement_args(LINETypes.createChatRoomAnnouncement_args.fromJson(param)),
      "createChatRoomAnnouncement",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> leaveRoom(Map param) async {
    return await this.client.request.request(
      LINEStructs.leaveRoom_args(LINETypes.leaveRoom_args.fromJson(param)),
      "leaveRoom",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getRoomsV2(Map param) async {
    return await this.client.request.request(
      LINEStructs.getRoomsV2_args(LINETypes.getRoomsV2_args.fromJson(param)),
      "getRoomsV2",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> createRoomV2(Map param) async {
    return await this.client.request.request(
      LINEStructs.createRoomV2_args(LINETypes.createRoomV2_args.fromJson(param)),
      "createRoomV2",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getCountries(Map param) async {
    return await this.client.request.request(
      LINEStructs.getCountries_args(LINETypes.getCountries_args.fromJson(param)),
      "getCountries",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> acquireEncryptedAccessToken(Map param) async {
    return await this.client.request.request(
      LINEStructs.acquireEncryptedAccessToken_args(LINETypes.acquireEncryptedAccessToken_args.fromJson(param)),
      "acquireEncryptedAccessToken",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> blockContact(Map param) async {
    return await this.client.request.request(
      LINEStructs.blockContact_args(LINETypes.blockContact_args.fromJson(param)),
      "bloakContact",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> unblockContact(Map param) async {
    return await this.client.request.request(
      LINEStructs.unblockContact_args(LINETypes.unblockContact_args.fromJson(param)),
      "unblockContact",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getConfigurations(Map param) async {
    return await this.client.request.request(
      LINEStructs.getConfigurations_args(LINETypes.getConfigurations_args.fromJson(param)),
      "getConfigurations",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> fetchOperations(Map param) async {
    return await this.client.request.request(
      LINEStructs.fetchOperations_args(LINETypes.fetchOperations_args.fromJson(param)),
      "fetchOperations",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getRepairElements(Map param) async {
    return await this.client.request.request(
      LINEStructs.getRepairElements_args(LINETypes.getRepairElements_args.fromJson(param)),
      "getRepairEements",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getSettingsAttributes2(Map param) async {
    return await this.client.request.request(
      LINEStructs.getSettingsAttributes2_args(LINETypes.getSettingsAttributes2_args.fromJson(param)),
      "getSettingsAttributes2",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> updateSettingsAttributes2(Map param) async {
    return await this.client.request.request(
      LINEStructs.updateSettingsAttributes2_args(LINETypes.updateSettingsAttributes2_args.fromJson(param)),
      "updateSettingsAttributes2",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> rejectChatInvitation(Map param) async {
    return await this.client.request.request(
      LINEStructs.rejectChatInvitation_args(LINETypes.rejectChatInvitation_args.fromJson(param)),
      "rejectChatInvitation",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getE2EEPublicKey(Map param) async {
    return await this.client.request.request(
      LINEStructs.getE2EEPublicKey_args(LINETypes.getE2EEPublicKey_args.fromJson(param)),
      "getE2EEPublicKey",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getE2EEPublicKeys() async {
    return await this.client.request.request(
      [],
      "getE2EEPublicKeys",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> registerE2EEPublicKey(Map param) async {
    return await this.client.request.request(
      LINEStructs.registerE2EEPublicKey_args(LINETypes.registerE2EEPublicKey_args.fromJson(param)),
      "registerE2EEPublicKey",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> registerE2EEGroupKey(Map param) async {
    return await this.client.request.request(
      LINEStructs.registerE2EEGroupKey_args(LINETypes.registerE2EEGroupKey_args.fromJson(param)),
      "registerE2EEGroupKey",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getE2EEGroupSharedKey(Map param) async {
    return await this.client.request.request(
      LINEStructs.getE2EEGroupSharedKey_args(LINETypes.getE2EEGroupSharedKey_args.fromJson(param)),
      "getE2EEGroupSharedKey",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getLastE2EEGroupSharedKey(Map param) async {
    return await this.client.request.request(
      LINEStructs.getLastE2EEGroupSharedKey_args(LINETypes.getLastE2EEGroupSharedKey_args.fromJson(param)),
      "getLastE2EEGroupSharedKey",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> geLastE2EEPublicKeys(Map param) async {
    return await this.client.request.request(
      LINEStructs.getLastE2EEPublicKeys_args(LINETypes.getLastE2EEPublicKeys_args.fromJson(param)),
      "getLastE2EEPublicKeys",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> negotiateE2EEPublicKey(Map param) async {
    return await this.client.request.request(
      LINEStructs.negotiateE2EEPublicKey_args(LINETypes.negotiateE2EEPublicKey_args.fromJson(param)),
      "negotiateE2EEPublicKey",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> react(Map param) async {
    return await this.client.request.request(
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
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> createChat(Map param) async {
    return await this.client.request.request(
      LINEStructs.createChat_args(LINETypes.createChat_args.fromJson(param)),
      "createChat",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> setHiddenStatus(Map param) async {
    return await this.client.request.request(
      LINEStructs.setChatHiddenStatus_args(LINETypes.setChatHiddenStatus_args.fromJson(param)),
      "setChatHiddenStatus",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getFollowers(Map param) async {
    return await this.client.request.request(
      LINEStructs.getFollowers_args(LINETypes.getFollowers_args.fromJson(param)),
      "getFollowers",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getFollowings(Map param) async {
    return await this.client.request.request(
      LINEStructs.getFollowings_args(LINETypes.getFollowings_args.fromJson(param)),
      "getFollowings",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> removeFollower(Map param) async {
    return await this.client.request.request(
      LINEStructs.removeFollower_args(LINETypes.removeFollower_args.fromJson(param)),
      "removeFollower",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> follow(Map param) async {
    return await this.client.request.request(
      LINEStructs.follow_args(LINETypes.follow_args.fromJson(param)),
      "follow",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> unfollow(Map param) async {
    return await this.client.request.request(
      LINEStructs.unfollow_args(LINETypes.unfollow_args.fromJson(param)),
      "unfollow",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> bulkFollow(Map param) async {
    return await this.client.request.request(
      LINEStructs.bulkFollow_args(LINETypes.bulkFollow_args.fromJson(param)),
      "bulkFollow",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> decryptFollowEmid(Map param) async {
    return await this.client.request.request(
      LINEStructs.decryptFollowEMid_args(LINETypes.decryptFollowEMid_args.fromJson(param)),
      "decryptFollowEmid",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getMessageReadRange(Map param) async {
    return await this.client.request.request(
      LINEStructs.getMessageReadRange_args(LINETypes.getMessageReadRange_args.fromJson(param)),
      "getMessageReadRange",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getChatRoomBGMs(Map param) async {
    return await this.client.request.request(
      LINEStructs.getChatRoomBGMs_args(LINETypes.getChatRoomBGMs_args.fromJson(param)),
      "getChatRoomBGMs",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> updateChatRoomBGM(Map param) async {
    return await this.client.request.request(
      LINEStructs.updateChatRoomBGM_args(LINETypes.updateChatRoomBGM_args.fromJson(param)),
      "updateChatRoomBGM",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> blockRecommendation(Map param) async {
    return await this.client.request.request(
      LINEStructs.blockRecommendation_args(LINETypes.blockRecommendation_args.fromJson(param)),
      "blockRecommendation",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> unblockRecommendation(Map param) async {
    return await this.client.request.request(
      LINEStructs.unblockRecommendation_args(LINETypes.unblockRecommendation_args.fromJson(param)),
      "unblockRecommendation",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getRecommendationIds(Map param) async {
    return await this.client.request.request(
      LINEStructs.getRecommendationIds_args(LINETypes.getRecommendationIds_args.fromJson(param)),
      "getRecommendationIds",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getExtendedProfile(Map param) async {
    return await this.client.request.request(
      LINEStructs.getExtendedProfile_args(LINETypes.getExtendedProfile_args.fromJson(param)),
      "getExtendedProfile",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> updateExtendedProfileAttribute(Map param) async {
    return await this.client.request.request(
      LINEStructs.updateExtendedProfileAttribute_args(LINETypes.updateExtendedProfileAttribute_args.fromJson(param)),
      "updateExtendedProfileAttribute",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> setNotificationsEnabled(Map param) async {
    return await this.client.request.request(
      LINEStructs.setNotificationsEnabled_args(LINETypes.setNotificationsEnabled_args.fromJson(param)),
      "setNotificationsEnabled",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> syncContacts(Map param) async {
    return await this.client.request.request(
      LINEStructs.syncContacts_args(LINETypes.syncContacts_args.fromJson(param)),
      "syncContacts",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> findContactByPhone(Map param) async {
    return await this.client.request.request(
      LINEStructs.findContactsByPhone_args(LINETypes.findContactsByPhone_args.fromJson(param)),
      "findContactsByPhone",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> findContactByUserid(Map param) async {
    return await this.client.request.request(
      LINEStructs.findContactByUserid_args(LINETypes.findContactByUserid_args.fromJson(param)),
      "findContactByUserid",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> updateContactSetting(Map param) async {
    return await this.client.request.request(
      LINEStructs.updateContactSetting_args(LINETypes.updateContactSetting_args.fromJson(param)),
      "updateContactSetting",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> findContactByUserTicket(Map param) async {
    return await this.client.request.request(
      LINEStructs.findContactByUserTicket_args(LINETypes.findContactByUserTicket_args.fromJson(param)),
      "findContactByUserTicket",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> veriftQrcode(Map param) async {
    return await this.client.request.request(
      LINEStructs.verifyQrcode_args(LINETypes.verifyQrcode_args.fromJson(param)),
      "verifyQrcode",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> reportAbuseEx(Map param) async {
    return await this.client.request.request(
      LINEStructs.reportAbuseEx_args(LINETypes.reportAbuseEx_args.fromJson(param)),
      "reportAbuseEx",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> updateProfileAttributes(Map param) async {
    return await this.client.request.request(
      LINEStructs.updateProfileAttributes_args(LINETypes.updateProfileAttributes_args.fromJson(param)),
      "updateProfileAttributes",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> updateNotificationToken(Map param) async {
    return await this.client.request.request(
      LINEStructs.updateNotificationToken_args(LINETypes.updateNotificationToken_args.fromJson(param)),
      "updateNotificationToken",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> tryFriendRequest(Map param) async {
    return await this.client.request.request(
      LINEStructs.tryFriendRequest_args(LINETypes.tryFriendRequest_args.fromJson(param)),
      "tryFriendRequest",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> generateUserTicket(Map param) async {
    return await this.client.request.request(
      LINEStructs.generateUserTicket_args(LINETypes.generateUserTicket_args.fromJson(param)),
      "generateUserTicket",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getRecentFriendRequests(Map param) async {
    return await this.client.request.request(
      LINEStructs.getRecentFriendRequests_args(LINETypes.getRecentFriendRequests_args.fromJson(param)),
      "getRecentFriendRequests",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> resendPinCode(Map param) async {
    return await this.client.request.request(
      LINEStructs.resendPinCode_args(LINETypes.resendPinCode_args.fromJson(param)),
      "resnedPinCode",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> notifyRegistrationComplete(Map param) async {
    return await this.client.request.request(
      LINEStructs.notifyRegistrationComplete_args(LINETypes.notifyRegistrationComplete_args.fromJson(param)),
      "notifyRegistrationComplete",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getInstantNews(Map param) async {
    return await this.client.request.request(
      LINEStructs.getInstantNews_args(LINETypes.getInstantNews_args.fromJson(param)),
      "getInstantNews",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> changeVerificationMethod(Map param) async {
    return await this.client.request.request(
      LINEStructs.changeVerificationMethod_args(LINETypes.changeVerificationMethod_args.fromJson(param)),
      "changeVerificationMethod",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getChatEffectMetaList(Map param) async {
    return await this.client.request.request(
      LINEStructs.getChatEffectMetaList_args(LINETypes.getChatEffectMetaList_args.fromJson(param)),
      "getChatEffectMetaList",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> notifyInstalled(Map param) async {
    return await this.client.request.request(
      LINEStructs.notifyInstalled_args(LINETypes.notifyInstalled_args.fromJson(param)),
      "notifyInstalled",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> reportDeviceState(Map param) async {
    return await this.client.request.request(
      LINEStructs.reportDeviceState_args(LINETypes.reportDeviceState_args.fromJson(param)),
      "reportDeviceStatus",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> sendChatRemoved(Map param) async {
    return await this.client.request.request(
      LINEStructs.sendChatRemoved_args(LINETypes.sendChatRemoved_args.fromJson(param)),
      "sendChatRemoved",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> startUpdateVerification(Map param) async {
    return await this.client.request.request(
      LINEStructs.startUpdateVerification_args(LINETypes.startUpdateVerification_args.fromJson(param)),
      "startUpdateVerifucation",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> inviteIntoRoom(Map param) async {
    return await this.client.request.request(
      LINEStructs.inviteIntoRoom_args(LINETypes.inviteIntoRoom_args.fromJson(param)),
      "inviteIntoRoom",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> removeFriendRequest(Map param) async {
    return await this.client.request.request(
      LINEStructs.removeFriendRequest_args(LINETypes.removeFriendRequest_args.fromJson(param)),
      "removeFriendRequest",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> reportProfile(Map param) async {
    return await this.client.request.request(
      LINEStructs.reportProfile_args(LINETypes.reportProfile_args.fromJson(param)),
      "reportProfile",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> wakeUpLongPolling(Map param) async {
    return await this.client.request.request(
      LINEStructs.wakeUpLongPolling_args(LINETypes.wakeUpLongPolling_args.fromJson(param)),
      "wakeUpLongPolling",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> updateAndGetNearby(Map param) async {
    return await this.client.request.request(
      LINEStructs.updateAndGetNearby_args(LINETypes.updateAndGetNearby_args.fromJson(param)),
      "updateAndGetNearby",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> reportSettings(Map param) async {
    return await this.client.request.request(
      LINEStructs.reportSettings_args(LINETypes.reportSettings_args.fromJson(param)),
      "reportSettings",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> verifyPhoneNumber(Map param) async {
    return await this.client.request.request(
      LINEStructs.verifyPhoneNumber_args(LINETypes.verifyPhoneNumber_args.fromJson(param)),
      "verifyPhoneNumber",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> isUseridAvailable(Map param) async {
    return await this.client.request.request(
      LINEStructs.isUseridAvailable_args(LINETypes.isUseridAvailable_args.fromJson(param)),
      "isUseridAvailable",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> registerUserid(Map param) async {
    return await this.client.request.request(
      LINEStructs.registerUserid_args(LINETypes.registerUserid_args.fromJson(param)),
      "registerUserid",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> finishUpdateVerification(Map param) async {
    return await this.client.request.request(
      LINEStructs.finishUpdateVerification_args(LINETypes.finishUpdateVerification_args.fromJson(param)),
      "finishUpdateVerification",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> clearRingtone(Map param) async {
    return await this.client.request.request(
      LINEStructs.clearRingtone_args(LINETypes.clearRingtone_args.fromJson(param)),
      "clearRingtone",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> notifyUpdated(Map param) async {
    return await this.client.request.request(
      LINEStructs.notifyUpdated_args(LINETypes.notifyUpdated_args.fromJson(param)),
      "notifyUpdated",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> reportPushRecvReports(Map param) async {
    return await this.client.request.request(
      LINEStructs.reportPushRecvReports_args(LINETypes.reportPushRecvReports_args.fromJson(param)),
      "reportPushRecvReports",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getFriendRequests(Map param) async {
    return await this.client.request.request(
      LINEStructs.getFriendRequests_args(LINETypes.getFriendRequests_args.fromJson(param)),
      "getFriendRequests",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> addToFollowBlacklist(Map param) async {
    return await this.client.request.request(
      LINEStructs.addToFollowBlacklist_args(LINETypes.addToFollowBlacklist_args.fromJson(param)),
      "addToFollowBlacklist",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> removeFromFollowBlacklist(Map param) async {
    return await this.client.request.request(
      LINEStructs.removeFromFollowBlacklist_args(LINETypes.removeFromFollowBlacklist_args.fromJson(param)),
      "removeFromFollowBlacklist",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getFollowBlacklist(Map param) async {
    return await this.client.request.request(
      LINEStructs.getFollowBlacklist_args(LINETypes.getFollowBlacklist_args.fromJson(param)),
      "getFollowBlacklist",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> determineMediaMessageFlow(Map param) async {
    return await this.client.request.request(
      LINEStructs.determineMediaMessageFlow_args(LINETypes.determineMediaMessageFlow_args.fromJson(param)),
      "determineMediaMessageFlow",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> createSession(Map param) async {
    return await this.client.request.request(
      LINEStructs.createSession_args(LINETypes.createSession_args.fromJson(param)),
      "createSession",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<void> cancelReaction(Map param) async {
    return await this.client.request.request(
      LINEStructs.cancelReaction_args(LINETypes.cancelReaction_args.fromJson(param)),
      "cancelReaction",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getNotificationSettings(Map param) async {
    return await this.client.request.request(
      LINEStructs.getNotificationSettings_args(LINETypes.getNotificationSettings_args.fromJson(param)),
      "getNotificationSettings",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getChats(Map param) async {
    return await this.client.request.request(
      LINEStructs.getChats_args(LINETypes.getChats_args.fromJson({
        "request": {
          "chatMids": param["chatMids"],
          "withInvitees": param["withInvitees"] ?? true,
          "withMembers": param["withMembers"] ?? true
        },
        "syncReason": "INTERNAL"
      })),
      "getChats",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getChat(Map param) async {
    dynamic res = await this.getChats({ "chatMids": [param["chatMid"]], "withInvitees": param["withInvitees"], "withMembers": param["withMembers"] });
    return LINETypes.getChats_result.fromJson(res).success.chats[0];
  }

  Future<dynamic> getAllChatMids(Map param) async {
    return await this.client.request.request(
      LINEStructs.getAllChatMids_args(LINETypes.getAllChatMids_args.fromJson(param)),
      "getAllChatMids",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<dynamic> getPreviousMessageV2WithRequest(Map param) async {
    return await this.client.request.request(
      LINEStructs.getPreviousMessagesV2WithRequest_args(LINETypes.getPreviousMessagesV2WithRequest_args.fromJson(param)),
      "getPreviousMessageV2WithRequest",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<int> getServerTime() async {
    return await this.client.request.request(
      [],
      "getServerTime",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<LINETypes.Contact> getContact(String mid) async {
    return await this.client.request.request(
      [[11, 2, mid]],
      "getContact",
      this.protocolType,
      true,
      this.requestPath
    );
  }

  Future<List<LINETypes.Contact>> getContacts(List<String> mids) async {
    List res =  await this.client.request.request(
      [[15, 2, [11, mids]]],
      "getContacts",
      this.protocolType,
      true,
      this.requestPath
    );
    List<LINETypes.Contact> response = res.map((e) => this.client.thrift.rename_thrift("Contact", e)) as List<LINETypes.Contact>;
    return response;
  }

  Future<LINETypes.GetContactsV2Response> getContactsV2(List<String> mids) async {
    return await this.client.request.request(
      [[12, 1, [[15, 1, [11, mids]]]]],
      "getContactsV2",
      this.protocolType,
      true,
      this.requestPath
    );
  }
}