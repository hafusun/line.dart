import '../line_types.dart' as LINEtypes;

Map<K, R> map<K, T, R>(
  R Function(T v) call,
  Map<K, T> value,
) {
  final Map<K, R> tMap = {};
  value.forEach((key, val) {
    tMap[key] = call(val);
  });
  return tMap;
}




List AcceptChatInvitationByTicketRequest(LINEtypes.AcceptChatInvitationByTicketRequest? param) {
  if (param == null) {
    return [];
  }
  return [
    [8, 1, param.reqSeq],
    [11, 1, param.chatMid],
    [11, 3, param.ticketId]
  ];
}

List AcceptChatInvitationRequest(LINEtypes.AcceptChatInvitationRequest? param) {
  if (param == null) {
    return [];
  }
  return [
    [8, 1, param.reqSeq],
    [11, 2, param.chatMid],
  ];
}

List AcceptSpeakersRequest(LINEtypes.AcceptSpeakersRequest? param) {
  if (param == null) {
    return [];
  }
  return [
    [11, 1, param.squareChatMid],
    [11, 2, param.sessionId],
    [14, 3, [11, param.targetMids]],
  ];
}

List AcceptToChangeRoleRequest(LINEtypes.AcceptToChangeRoleRequest? param) {
  if (param == null) {
    return [];
  }
  return [
    [11, 1, param.squareChatMid],
    [11, 2, param.sessionId],
    [11, 3, param.inviteRequestId],
  ];
}

List AcceptToListenRequest(LINEtypes.AcceptToListenRequest? param) {
  if (param == null) {
    return [];
  }
  return [
    [11, 1, param.squareChatMid],
    [11, 2, param.sessionId],
    [11, 3, param.inviteRequestId]
  ];
}

List AcceptToSpeakRequest(LINEtypes.AcceptToSpeakRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.sessionId],
		[11, 3, param.inviteRequestId],
	];
}
dynamic LiveTalkType(dynamic param) {
	if (param is int) {
		return LINEtypes.LiveTalkType.fromValue(param);
	}
	return param;
}
dynamic LiveTalkSpeakerSetting(dynamic param) {
	if (param is int) {
		return LINEtypes.LiveTalkSpeakerSetting.fromValue(param);
	}
	return param;
}
List AcquireLiveTalkRequest(LINEtypes.AcquireLiveTalkRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.title],
		[8, 3, LiveTalkType(param.type)],
		[8, 4, LiveTalkSpeakerSetting(param.speakerSetting)],
	];
}
List CancelToSpeakRequest(LINEtypes.CancelToSpeakRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.sessionId],
	];
}
List FetchLiveTalkEventsRequest(LINEtypes.FetchLiveTalkEventsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.sessionId],
		[11, 3, param.syncToken],
		[8, 4, param.limit],
	];
}
List FindLiveTalkByInvitationTicketRequest(LINEtypes.FindLiveTalkByInvitationTicketRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.invitationTicket],
	];
}
List ForceEndLiveTalkRequest(LINEtypes.ForceEndLiveTalkRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.sessionId],
	];
}
List GetLiveTalkInfoForNonMemberRequest(LINEtypes.GetLiveTalkInfoForNonMemberRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.sessionId],
		[15, 3, [11, param.speakers]],
	];
}
List GetLiveTalkInvitationUrlRequest(LINEtypes.GetLiveTalkInvitationUrlRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.sessionId],
	];
}
List GetLiveTalkSpeakersForNonMemberRequest(LINEtypes.GetLiveTalkSpeakersForNonMemberRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.sessionId],
		[15, 3, [11, param.speakers]],
	];
}
List GetSquareInfoByChatMidRequest(LINEtypes.GetSquareInfoByChatMidRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
	];
}
dynamic LiveTalkRole(dynamic param) {
	if (param is int) {
		return LINEtypes.LiveTalkRole.fromValue(param);
	}
	return param;
}
List InviteToChangeRoleRequest(LINEtypes.InviteToChangeRoleRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.sessionId],
		[11, 3, param.targetMid],
		[8, 4, LiveTalkRole(param.targetRole)],
	];
}
List InviteToListenRequest(LINEtypes.InviteToListenRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.sessionId],
		[11, 3, param.targetMid],
	];
}
List InviteToLiveTalkRequest(LINEtypes.InviteToLiveTalkRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.sessionId],
		[15, 3, [11, param.invitees]],
	];
}
List InviteToSpeakRequest(LINEtypes.InviteToSpeakRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.sessionId],
		[11, 3, param.targetMid],
	];
}
dynamic BooleanState(dynamic param) {
	if (param is int) {
		return LINEtypes.BooleanState.fromValue(param);
	}
	return param;
}
List JoinLiveTalkRequest(LINEtypes.JoinLiveTalkRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.sessionId],
		[2, 3, param.wantToSpeak],
		[8, 4, BooleanState(param.claimAdult)],
	];
}
List LiveTalkParticipant(LINEtypes.LiveTalkParticipant? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.mid],
	];
}
List AllNonMemberLiveTalkParticipants(LINEtypes.AllNonMemberLiveTalkParticipants? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LiveTalkKickOutTarget(LINEtypes.LiveTalkKickOutTarget? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, LiveTalkParticipant(param.liveTalkParticipant)],
		[
			12,
			2,
			AllNonMemberLiveTalkParticipants(param.allNonMemberLiveTalkParticipants),
		],
	];
}
List KickOutLiveTalkParticipantsRequest(LINEtypes.KickOutLiveTalkParticipantsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.sessionId],
		[12, 3, LiveTalkKickOutTarget(param.target)],
	];
}
List RejectSpeakersRequest(LINEtypes.RejectSpeakersRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.sessionId],
		[14, 3, [11, param.targetMids]],
	];
}
List RejectToSpeakRequest(LINEtypes.RejectToSpeakRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.sessionId],
		[11, 3, param.inviteRequestId],
	];
}
List RemoveLiveTalkSubscriptionRequest(LINEtypes.RemoveLiveTalkSubscriptionRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.sessionId],
	];
}
dynamic LiveTalkReportType(dynamic param) {
	if (param is int) {
		return LINEtypes.LiveTalkReportType.fromValue(param);
	}
	return param;
}
List ReportLiveTalkRequest(LINEtypes.ReportLiveTalkRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.sessionId],
		[8, 3, LiveTalkReportType(param.reportType)],
	];
}
List ReportLiveTalkSpeakerRequest(LINEtypes.ReportLiveTalkSpeakerRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.sessionId],
		[11, 3, param.speakerMemberMid],
		[8, 4, LiveTalkReportType(param.reportType)],
	];
}
List RequestToListenRequest(LINEtypes.RequestToListenRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.sessionId],
	];
}
List RequestToSpeakRequest(LINEtypes.RequestToSpeakRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.sessionId],
	];
}
dynamic LiveTalkAttribute(dynamic param) {
	if (param is int) {
		return LINEtypes.LiveTalkAttribute.fromValue(param);
	}
	return param;
}
List LiveTalk(LINEtypes.LiveTalk? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.sessionId],
		[11, 3, param.title],
		[8, 4, LiveTalkType(param.type)],
		[8, 5, LiveTalkSpeakerSetting(param.speakerSetting)],
		[2, 6, param.allowRequestToSpeak],
		[11, 7, param.hostMemberMid],
		[11, 8, param.announcement],
		[8, 9, param.participantCount],
		[10, 10, param.revision],
		[10, 11, param.startedAt],
	];
}
List UpdateLiveTalkAttrsRequest(LINEtypes.UpdateLiveTalkAttrsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[14, 1, [
			8,
			param.updatedAttrs != null ? param.updatedAttrs.map((e) => LiveTalkAttribute(e)).toList() : [],
		]],
		[12, 2, LiveTalk(param.liveTalk)],
	];
}
dynamic Pb1_D4(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_D4.fromValue(param);
	}
	return param;
}
dynamic Pb1_EnumC13222w4(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_EnumC13222w4.fromValue(param);
	}
	return param;
}
dynamic Pb1_EnumC13237x5(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_EnumC13237x5.fromValue(param);
	}
	return param;
}
List AcquireOACallRouteRequest(LINEtypes.AcquireOACallRouteRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.searchId],
		[13, 2, [11, 11, param.fromEnvInfo]],
		[11, 3, param.otp],
	];
}
dynamic PaidCallType(dynamic param) {
	if (param is int) {
		return LINEtypes.PaidCallType.fromValue(param);
	}
	return param;
}
dynamic og_EnumC32661b(dynamic param) {
	if (param is int) {
		return LINEtypes.og_EnumC32661b.fromValue(param);
	}
	return param;
}
List ActivateSubscriptionRequest(LINEtypes.ActivateSubscriptionRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.uniqueKey],
		[8, 2, og_EnumC32661b(param.activeStatus)],
	];
}
List AdTypeOptOutClickEventRequest(LINEtypes.AdTypeOptOutClickEventRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.moduleAdId],
		[11, 2, param.targetId],
	];
}
List AddMetaInvalid(LINEtypes.AddMetaInvalid? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.hint],
	];
}
List AddMetaByPhone(LINEtypes.AddMetaByPhone? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.phone],
	];
}
List AddMetaBySearchId(LINEtypes.AddMetaBySearchId? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.searchId],
	];
}
List AddMetaByUserTicket(LINEtypes.AddMetaByUserTicket? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.ticket],
	];
}
List AddMetaGroupMemberList(LINEtypes.AddMetaGroupMemberList? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.chatMid],
	];
}
List LN0_P(LINEtypes.LN0_P? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_L(LINEtypes.LN0_L? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_G(LINEtypes.LN0_G? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_C11282h(LINEtypes.LN0_C11282h? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_C11300q(LINEtypes.LN0_C11300q? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_C11307u(LINEtypes.LN0_C11307u? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List AddMetaShareContact(LINEtypes.AddMetaShareContact? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.messageId],
		[11, 2, param.chatMid],
		[11, 3, param.senderMid],
	];
}
List AddMetaStrangerMessage(LINEtypes.AddMetaStrangerMessage? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.messageId],
		[11, 2, param.chatMid],
	];
}
List AddMetaStrangerCall(LINEtypes.AddMetaStrangerCall? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.messageId],
	];
}
List AddMetaMentionInChat(LINEtypes.AddMetaMentionInChat? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.chatMid],
		[11, 2, param.messageId],
	];
}
List LN0_O(LINEtypes.LN0_O? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_Q(LINEtypes.LN0_Q? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_C11313x(LINEtypes.LN0_C11313x? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_A(LINEtypes.LN0_A? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List AddMetaGroupVideoCall(LINEtypes.AddMetaGroupVideoCall? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.chatMid],
	];
}
List LN0_r(LINEtypes.LN0_r? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_C11315y(LINEtypes.LN0_C11315y? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_C11316z(LINEtypes.LN0_C11316z? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_B(LINEtypes.LN0_B? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_C11280g(LINEtypes.LN0_C11280g? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_T(LINEtypes.LN0_T? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_C11276e(LINEtypes.LN0_C11276e? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_S(LINEtypes.LN0_S? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List AddMetaProfileUndefined(LINEtypes.AddMetaProfileUndefined? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.hint],
	];
}
List LN0_F(LINEtypes.LN0_F? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_C11294n(LINEtypes.LN0_C11294n? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_C11290l(LINEtypes.LN0_C11290l? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_C11309v(LINEtypes.LN0_C11309v? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_C11292m(LINEtypes.LN0_C11292m? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List AddMetaChatNote(LINEtypes.AddMetaChatNote? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.chatMid],
	];
}
List AddMetaChatNoteMenu(LINEtypes.AddMetaChatNoteMenu? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.chatMid],
	];
}
List LN0_U(LINEtypes.LN0_U? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_E(LINEtypes.LN0_E? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List AddMetaSearchIdInUnifiedSearch(LINEtypes.AddMetaSearchIdInUnifiedSearch? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.searchId],
	];
}
List LN0_D(LINEtypes.LN0_D? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_C11278f(LINEtypes.LN0_C11278f? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_H(LINEtypes.LN0_H? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LN0_C11274d(LINEtypes.LN0_C11274d? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, AddMetaInvalid(param.invalid)],
		[12, 2, AddMetaByPhone(param.byPhone)],
		[12, 3, AddMetaBySearchId(param.bySearchId)],
		[12, 4, AddMetaByUserTicket(param.byUserTicket)],
		[12, 5, AddMetaGroupMemberList(param.groupMemberList)],
		[12, 6, LN0_P(param.timelineCPF)],
		[12, 7, LN0_L(param.smartChannelCPF)],
		[12, 8, LN0_G(param.openchatCPF)],
		[12, 9, LN0_C11282h(param.beaconBanner)],
		[12, 10, LN0_C11300q(param.friendRecommendation)],
		[12, 11, LN0_C11307u(param.homeRecommendation)],
		[12, 12, AddMetaShareContact(param.shareContact)],
		[12, 13, AddMetaStrangerMessage(param.strangerMessage)],
		[12, 14, AddMetaStrangerCall(param.strangerCall)],
		[12, 15, AddMetaMentionInChat(param.mentionInChat)],
		[12, 16, LN0_O(param.timeline)],
		[12, 17, LN0_Q(param.unifiedSearch)],
		[12, 18, LN0_C11313x(param.lineLab)],
		[12, 19, LN0_A(param.lineToCall)],
		[12, 20, AddMetaGroupVideoCall(param.groupVideo)],
		[12, 21, LN0_r(param.friendRequest)],
		[12, 22, LN0_C11315y(param.liveViewer)],
		[12, 23, LN0_C11316z(param.lineThings)],
		[12, 24, LN0_B(param.mediaCapture)],
		[12, 25, LN0_C11280g(param.avatarOASetting)],
		[12, 26, LN0_T(param.urlScheme)],
		[12, 27, LN0_C11276e(param.addressBook)],
		[12, 28, LN0_S(param.unifiedSearchOATab)],
		[12, 29, AddMetaProfileUndefined(param.profileUndefined)],
		[12, 30, LN0_F(param.DEPRECATED_oaChatHeader)],
		[12, 31, LN0_C11294n(param.chatMenu)],
		[12, 32, LN0_C11290l(param.chatHeader)],
		[12, 33, LN0_C11309v(param.homeTabCPF)],
		[12, 34, LN0_C11292m(param.chatList)],
		[12, 35, AddMetaChatNote(param.chatNote)],
		[12, 36, AddMetaChatNoteMenu(param.chatNoteMenu)],
		[12, 37, LN0_U(param.walletTabCPF)],
		[12, 38, LN0_E(param.oaCall)],
		[12, 39, AddMetaSearchIdInUnifiedSearch(param.searchIdInUnifiedSearch)],
		[12, 40, LN0_D(param.newsDigestADCPF)],
		[12, 41, LN0_C11278f(param.albumCPF)],
		[12, 42, LN0_H(param.premiumAgreement)],
	];
}
List AddFriendTracking(LINEtypes.AddFriendTracking? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.reference],
		[12, 2, LN0_C11274d(param.trackingMeta)],
	];
}
List AddFriendByMidRequest(LINEtypes.AddFriendByMidRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.userMid],
		[12, 3, AddFriendTracking(param.tracking)],
	];
}
dynamic Ob1_O0(dynamic param) {
	if (param is int) {
		return LINEtypes.Ob1_O0.fromValue(param);
	}
	return param;
}
List AddItemToCollectionRequest(LINEtypes.AddItemToCollectionRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.collectionId],
		[8, 2, Ob1_O0(param.productType)],
		[11, 3, param.productId],
		[11, 4, param.itemId],
	];
}
List NZ0_C12155c(LINEtypes.NZ0_C12155c? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List AddProductToSubscriptionSlotRequest(LINEtypes.AddProductToSubscriptionSlotRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Ob1_O0(param.productType)],
		[11, 2, param.productId],
		[11, 3, param.oldProductId],
	];
}
List AddThemeToSubscriptionSlotRequest(LINEtypes.AddThemeToSubscriptionSlotRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.productId],
		[11, 2, param.currentlyAppliedProductId],
	];
}
List Pb1_A4(LINEtypes.Pb1_A4? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.mid],
		[11, 2, param.eMid],
	];
}
List AddToFollowBlacklistRequest(LINEtypes.AddToFollowBlacklistRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, Pb1_A4(param.followMid)],
	];
}
List TermsAgreement(LINEtypes.TermsAgreement? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List AgreeToTermsRequest(LINEtypes.AgreeToTermsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, TermsAgreement(param.termsAgreement)],
	];
}
List ApproveSquareMembersRequest(LINEtypes.ApproveSquareMembersRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareMid],
		[15, 3, [11, param.requestedMemberMids]],
	];
}
List CheckJoinCodeRequest(LINEtypes.CheckJoinCodeRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareMid],
		[11, 3, param.joinCode],
	];
}
List TextMessageAnnouncementContents(LINEtypes.TextMessageAnnouncementContents? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.messageId],
		[11, 2, param.text],
		[11, 3, param.senderSquareMemberMid],
		[10, 4, param.createdAt],
	];
}
List SquareChatAnnouncementContents(LINEtypes.SquareChatAnnouncementContents? param) {
	if (param == null) {
		return [];
	}
	return [
		[
			12,
			1,
			TextMessageAnnouncementContents(param.textMessageAnnouncementContents),
		],
	];
}
List SquareChatAnnouncement(LINEtypes.SquareChatAnnouncement? param) {
	if (param == null) {
		return [];
	}
	return [
		[10, 1, param.announcementSeq],
		[8, 2, param.type],
		[12, 3, SquareChatAnnouncementContents(param.contents)],
		[10, 4, param.createdAt],
		[11, 5, param.creator],
	];
}
List CreateSquareChatAnnouncementRequest(LINEtypes.CreateSquareChatAnnouncementRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.squareChatMid],
		[12, 3, SquareChatAnnouncement(param.squareChatAnnouncement)],
	];
}
dynamic SquareChatType(dynamic param) {
	if (param is int) {
		return LINEtypes.SquareChatType.fromValue(param);
	}
	return param;
}
dynamic SquareChatState(dynamic param) {
	if (param is int) {
		return LINEtypes.SquareChatState.fromValue(param);
	}
	return param;
}
List MessageVisibility(LINEtypes.MessageVisibility? param) {
	if (param == null) {
		return [];
	}
	return [
		[2, 1, param.showJoinMessage],
		[2, 2, param.showLeaveMessage],
		[2, 3, param.showKickoutMessage],
	];
}
List SquareChat(LINEtypes.SquareChat? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.squareMid],
		[8, 3, SquareChatType(param.type)],
		[11, 4, param.name],
		[11, 5, param.chatImageObsHash],
		[10, 6, param.squareChatRevision],
		[8, 7, param.maxMemberCount],
		[8, 8, SquareChatState(param.state)],
		[11, 9, param.invitationUrl],
		[12, 10, MessageVisibility(param.messageVisibility)],
		[8, 11, BooleanState(param.ableToSearchMessage)],
	];
}
List CreateSquareChatRequest(LINEtypes.CreateSquareChatRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[12, 2, SquareChat(param.squareChat)],
		[15, 3, [11, param.squareMemberMids]],
	];
}
dynamic SquareType(dynamic param) {
	if (param is int) {
		return LINEtypes.SquareType.fromValue(param);
	}
	return param;
}
dynamic SquareState(dynamic param) {
	if (param is int) {
		return LINEtypes.SquareState.fromValue(param);
	}
	return param;
}
dynamic SquareEmblem(dynamic param) {
	if (param is int) {
		return LINEtypes.SquareEmblem.fromValue(param);
	}
	return param;
}
dynamic SquareJoinMethodType(dynamic param) {
	if (param is int) {
		return LINEtypes.SquareJoinMethodType.fromValue(param);
	}
	return param;
}
List ApprovalValue(LINEtypes.ApprovalValue? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.message],
	];
}
List CodeValue(LINEtypes.CodeValue? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.code],
	];
}
List SquareJoinMethodValue(LINEtypes.SquareJoinMethodValue? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ApprovalValue(param.approvalValue)],
		[12, 2, CodeValue(param.codeValue)],
	];
}
List SquareJoinMethod(LINEtypes.SquareJoinMethod? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, SquareJoinMethodType(param.type)],
		[12, 2, SquareJoinMethodValue(param.value)],
	];
}
List Square(LINEtypes.Square? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.mid],
		[11, 2, param.name],
		[11, 3, param.welcomeMessage],
		[11, 4, param.profileImageObsHash],
		[11, 5, param.desc],
		[2, 6, param.searchable],
		[8, 7, SquareType(param.type)],
		[8, 8, param.categoryId],
		[11, 9, param.invitationURL],
		[10, 10, param.revision],
		[2, 11, param.ableToUseInvitationTicket],
		[8, 12, SquareState(param.state)],
		[15, 13, [8, param.emblems != null ? param.emblems.map((e) => SquareEmblem(e)).toList() : []]],
		[12, 14, SquareJoinMethod(param.joinMethod)],
		[8, 15, BooleanState(param.adultOnly)],
		[15, 16, [11, param.svcTags]],
		[10, 17, param.createdAt],
	];
}
dynamic SquareMembershipState(dynamic param) {
	if (param is int) {
		return LINEtypes.SquareMembershipState.fromValue(param);
	}
	return param;
}
dynamic SquareMemberRole(dynamic param) {
	if (param is int) {
		return LINEtypes.SquareMemberRole.fromValue(param);
	}
	return param;
}
List SquarePreference(LINEtypes.SquarePreference? param) {
	if (param == null) {
		return [];
	}
	return [
		[10, 1, param.favoriteTimestamp],
		[2, 2, param.notiForNewJoinRequest],
	];
}
List SquareMember(LINEtypes.SquareMember? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareMemberMid],
		[11, 2, param.squareMid],
		[11, 3, param.displayName],
		[11, 4, param.profileImageObsHash],
		[2, 5, param.ableToReceiveMessage],
		[8, 7, SquareMembershipState(param.membershipState)],
		[8, 8, SquareMemberRole(param.role)],
		[10, 9, param.revision],
		[12, 10, SquarePreference(param.preference)],
		[11, 11, param.joinMessage],
		[10, 12, param.createdAt],
	];
}
List CreateSquareRequest(LINEtypes.CreateSquareRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[12, 2, Square(param.square)],
		[12, 3, SquareMember(param.creator)],
	];
}
List DeleteSquareChatAnnouncementRequest(LINEtypes.DeleteSquareChatAnnouncementRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareChatMid],
		[10, 3, param.announcementSeq],
	];
}
List DeleteSquareChatRequest(LINEtypes.DeleteSquareChatRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareChatMid],
		[10, 3, param.revision],
	];
}
List DeleteSquareRequest(LINEtypes.DeleteSquareRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.mid],
		[10, 3, param.revision],
	];
}
List DestroyMessageRequest(LINEtypes.DestroyMessageRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareChatMid],
		[11, 4, param.messageId],
		[11, 5, param.threadMid],
	];
}
List DestroyMessagesRequest(LINEtypes.DestroyMessagesRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareChatMid],
		[14, 4, [11, param.messageIds]],
		[11, 5, param.threadMid],
	];
}
List FetchMyEventsRequest(LINEtypes.FetchMyEventsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[10, 1, param.subscriptionId],
		[11, 2, param.syncToken],
		[8, 3, param.limit],
		[11, 4, param.continuationToken],
	];
}
dynamic FetchDirection(dynamic param) {
	if (param is int) {
		return LINEtypes.FetchDirection.fromValue(param);
	}
	return param;
}
dynamic FetchType(dynamic param) {
	if (param is int) {
		return LINEtypes.FetchType.fromValue(param);
	}
	return param;
}
List FetchSquareChatEventsRequest(LINEtypes.FetchSquareChatEventsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[10, 1, param.subscriptionId],
		[11, 2, param.squareChatMid],
		[11, 3, param.syncToken],
		[8, 4, param.limit],
		[8, 5, FetchDirection(param.direction)],
		[8, 6, BooleanState(param.inclusive)],
		[11, 7, param.continuationToken],
		[8, 8, FetchType(param.fetchType)],
		[11, 9, param.threadMid],
	];
}
List FindSquareByEmidRequest(LINEtypes.FindSquareByEmidRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.emid],
	];
}
List FindSquareByInvitationTicketRequest(LINEtypes.FindSquareByInvitationTicketRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.invitationTicket],
	];
}
List FindSquareByInvitationTicketV2Request(LINEtypes.FindSquareByInvitationTicketV2Request? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.invitationTicket],
	];
}
dynamic AdScreen(dynamic param) {
	if (param is int) {
		return LINEtypes.AdScreen.fromValue(param);
	}
	return param;
}
List GetGoogleAdOptionsRequest(LINEtypes.GetGoogleAdOptionsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareMid],
		[11, 2, param.chatMid],
		[8, 3, AdScreen(param.adScreen)],
	];
}
List GetInvitationTicketUrlRequest(LINEtypes.GetInvitationTicketUrlRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.mid],
	];
}
List GetJoinableSquareChatsRequest(LINEtypes.GetJoinableSquareChatsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareMid],
		[11, 10, param.continuationToken],
		[8, 11, param.limit],
	];
}
List GetJoinedSquareChatsRequest(LINEtypes.GetJoinedSquareChatsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.continuationToken],
		[8, 3, param.limit],
	];
}
List GetJoinedSquaresRequest(LINEtypes.GetJoinedSquaresRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.continuationToken],
		[8, 3, param.limit],
	];
}
dynamic MessageReactionType(dynamic param) {
	if (param is int) {
		return LINEtypes.MessageReactionType.fromValue(param);
	}
	return param;
}
List GetMessageReactionsRequest(LINEtypes.GetMessageReactionsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.messageId],
		[8, 3, MessageReactionType(param.type)],
		[11, 4, param.continuationToken],
		[8, 5, param.limit],
		[11, 6, param.threadMid],
	];
}
List GetNoteStatusRequest(LINEtypes.GetNoteStatusRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareMid],
	];
}
List GetPopularKeywordsRequest(LINEtypes.GetPopularKeywordsRequest? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List GetSquareAuthoritiesRequest(LINEtypes.GetSquareAuthoritiesRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[14, 2, [11, param.squareMids]],
	];
}
List GetSquareAuthorityRequest(LINEtypes.GetSquareAuthorityRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareMid],
	];
}
List GetSquareCategoriesRequest(LINEtypes.GetSquareCategoriesRequest? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List GetSquareChatAnnouncementsRequest(LINEtypes.GetSquareChatAnnouncementsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareChatMid],
	];
}
List GetSquareChatEmidRequest(LINEtypes.GetSquareChatEmidRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
	];
}
List GetSquareChatFeatureSetRequest(LINEtypes.GetSquareChatFeatureSetRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareChatMid],
	];
}
List GetSquareChatMemberRequest(LINEtypes.GetSquareChatMemberRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareMemberMid],
		[11, 3, param.squareChatMid],
	];
}
List GetSquareChatMembersRequest(LINEtypes.GetSquareChatMembersRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[11, 2, param.continuationToken],
		[8, 3, param.limit],
	];
}
List GetSquareChatRequest(LINEtypes.GetSquareChatRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
	];
}
List GetSquareChatStatusRequest(LINEtypes.GetSquareChatStatusRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareChatMid],
	];
}
List GetSquareEmidRequest(LINEtypes.GetSquareEmidRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareMid],
	];
}
List GetSquareFeatureSetRequest(LINEtypes.GetSquareFeatureSetRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareMid],
	];
}
List GetSquareMemberRelationRequest(LINEtypes.GetSquareMemberRelationRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareMid],
		[11, 3, param.targetSquareMemberMid],
	];
}
dynamic SquareMemberRelationState(dynamic param) {
	if (param is int) {
		return LINEtypes.SquareMemberRelationState.fromValue(param);
	}
	return param;
}
List GetSquareMemberRelationsRequest(LINEtypes.GetSquareMemberRelationsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 2, SquareMemberRelationState(param.state)],
		[11, 3, param.continuationToken],
		[8, 4, param.limit],
	];
}
List GetSquareMemberRequest(LINEtypes.GetSquareMemberRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareMemberMid],
	];
}
List GetSquareMembersBySquareRequest(LINEtypes.GetSquareMembersBySquareRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareMid],
		[14, 3, [11, param.squareMemberMids]],
	];
}
List GetSquareMembersRequest(LINEtypes.GetSquareMembersRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[14, 2, [11, param.mids]],
	];
}
List GetSquareRequest(LINEtypes.GetSquareRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.mid],
	];
}
List GetSquareStatusRequest(LINEtypes.GetSquareStatusRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareMid],
	];
}
List GetSquareThreadMidRequest(LINEtypes.GetSquareThreadMidRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.chatMid],
		[11, 2, param.messageId],
	];
}
List GetSquareThreadRequest(LINEtypes.GetSquareThreadRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.threadMid],
		[2, 2, param.includeRootMessage],
	];
}
List GetUserSettingsRequest(LINEtypes.GetUserSettingsRequest? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List HideSquareMemberContentsRequest(LINEtypes.HideSquareMemberContentsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareMemberMid],
	];
}
List InviteIntoSquareChatRequest(LINEtypes.InviteIntoSquareChatRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[15, 1, [11, param.inviteeMids]],
		[11, 2, param.squareChatMid],
	];
}
List InviteToSquareRequest(LINEtypes.InviteToSquareRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareMid],
		[15, 3, [11, param.invitees]],
		[11, 4, param.squareChatMid],
	];
}
List JoinSquareChatRequest(LINEtypes.JoinSquareChatRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
	];
}
List JoinSquareRequest(LINEtypes.JoinSquareRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareMid],
		[12, 3, SquareMember(param.member)],
		[11, 4, param.squareChatMid],
		[12, 5, SquareJoinMethodValue(param.joinValue)],
		[8, 6, BooleanState(param.claimAdult)],
	];
}
List JoinSquareThreadRequest(LINEtypes.JoinSquareThreadRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.chatMid],
		[11, 2, param.threadMid],
	];
}
List LeaveSquareChatRequest(LINEtypes.LeaveSquareChatRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareChatMid],
		[2, 3, param.sayGoodbye],
		[10, 4, param.squareChatMemberRevision],
	];
}
List LeaveSquareRequest(LINEtypes.LeaveSquareRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareMid],
	];
}
List LeaveSquareThreadRequest(LINEtypes.LeaveSquareThreadRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.chatMid],
		[11, 2, param.threadMid],
	];
}
List ManualRepairRequest(LINEtypes.ManualRepairRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.syncToken],
		[8, 2, param.limit],
		[11, 3, param.continuationToken],
	];
}
List MarkAsReadRequest(LINEtypes.MarkAsReadRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareChatMid],
		[11, 4, param.messageId],
		[11, 5, param.threadMid],
	];
}
List MarkChatsAsReadRequest(LINEtypes.MarkChatsAsReadRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[14, 2, [11, param.chatMids]],
	];
}
List MarkThreadsAsReadRequest(LINEtypes.MarkThreadsAsReadRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.chatMid],
	];
}
List ReactToMessageRequest(LINEtypes.ReactToMessageRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.squareChatMid],
		[11, 3, param.messageId],
		[8, 4, MessageReactionType(param.reactionType)],
		[11, 5, param.threadMid],
	];
}
List RefreshSubscriptionsRequest(LINEtypes.RefreshSubscriptionsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[15, 2, [10, param.subscriptions]],
	];
}
List RejectSquareMembersRequest(LINEtypes.RejectSquareMembersRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareMid],
		[15, 3, [11, param.requestedMemberMids]],
	];
}
List RemoveSubscriptionsRequest(LINEtypes.RemoveSubscriptionsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[15, 2, [10, param.unsubscriptions]],
	];
}
dynamic MessageSummaryReportType(dynamic param) {
	if (param is int) {
		return LINEtypes.MessageSummaryReportType.fromValue(param);
	}
	return param;
}
List ReportMessageSummaryRequest(LINEtypes.ReportMessageSummaryRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.chatEmid],
		[10, 2, param.messageSummaryRangeTo],
		[8, 3, MessageSummaryReportType(param.reportType)],
	];
}
dynamic ReportType(dynamic param) {
	if (param is int) {
		return LINEtypes.ReportType.fromValue(param);
	}
	return param;
}
List ReportSquareChatRequest(LINEtypes.ReportSquareChatRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareMid],
		[11, 3, param.squareChatMid],
		[8, 5, ReportType(param.reportType)],
		[11, 6, param.otherReason],
	];
}
List ReportSquareMemberRequest(LINEtypes.ReportSquareMemberRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareMemberMid],
		[8, 3, ReportType(param.reportType)],
		[11, 4, param.otherReason],
		[11, 5, param.squareChatMid],
		[11, 6, param.threadMid],
	];
}
List ReportSquareMessageRequest(LINEtypes.ReportSquareMessageRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareMid],
		[11, 3, param.squareChatMid],
		[11, 4, param.squareMessageId],
		[8, 5, ReportType(param.reportType)],
		[11, 6, param.otherReason],
		[11, 7, param.threadMid],
	];
}
List ReportSquareRequest(LINEtypes.ReportSquareRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareMid],
		[8, 3, ReportType(param.reportType)],
		[11, 4, param.otherReason],
	];
}
List SquareChatMemberSearchOption(LINEtypes.SquareChatMemberSearchOption? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.displayName],
		[2, 2, param.includingMe],
	];
}
List SearchSquareChatMembersRequest(LINEtypes.SearchSquareChatMembersRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[12, 2, SquareChatMemberSearchOption(param.searchOption)],
		[11, 3, param.continuationToken],
		[8, 4, param.limit],
	];
}
List SquareChatMentionableSearchOption(LINEtypes.SquareChatMentionableSearchOption? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.displayName],
	];
}
List SearchSquareChatMentionablesRequest(LINEtypes.SearchSquareChatMentionablesRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
		[12, 2, SquareChatMentionableSearchOption(param.searchOption)],
		[11, 3, param.continuationToken],
		[8, 4, param.limit],
	];
}
List SquareMemberSearchOption(LINEtypes.SquareMemberSearchOption? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, SquareMembershipState(param.membershipState)],
		[14, 2, [
			8,
			param.memberRoles != null ? param.memberRoles.map((e) => SquareMemberRole(e)).toList() : [],
		]],
		[11, 3, param.displayName],
		[8, 4, BooleanState(param.ableToReceiveMessage)],
		[8, 5, BooleanState(param.ableToReceiveFriendRequest)],
		[11, 6, param.chatMidToExcludeMembers],
		[2, 7, param.includingMe],
		[2, 8, param.excludeBlockedMembers],
		[2, 9, param.includingMeOnlyMatch],
	];
}
List SearchSquareMembersRequest(LINEtypes.SearchSquareMembersRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareMid],
		[12, 3, SquareMemberSearchOption(param.searchOption)],
		[11, 4, param.continuationToken],
		[8, 5, param.limit],
	];
}
List SearchSquaresRequest(LINEtypes.SearchSquaresRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.query],
		[11, 3, param.continuationToken],
		[8, 4, param.limit],
	];
}
dynamic MIDType(dynamic param) {
	if (param is int) {
		return LINEtypes.MIDType.fromValue(param);
	}
	return param;
}
dynamic Pb1_D6(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_D6.fromValue(param);
	}
	return param;
}
dynamic Pb1_EnumC13050k(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_EnumC13050k.fromValue(param);
	}
	return param;
}
List GeolocationAccuracy(LINEtypes.GeolocationAccuracy? param) {
	if (param == null) {
		return [];
	}
	return [
		[4, 1, param.radiusMeters],
		[4, 2, param.radiusConfidence],
		[4, 3, param.altitudeAccuracy],
		[4, 4, param.velocityAccuracy],
		[4, 5, param.bearingAccuracy],
		[8, 6, Pb1_EnumC13050k(param.accuracyMode)],
	];
}
List Location(LINEtypes.Location? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.title],
		[11, 2, param.address],
		[4, 3, param.latitude],
		[4, 4, param.longitude],
		[11, 5, param.phone],
		[11, 6, param.categoryId],
		[8, 7, Pb1_D6(param.provider)],
		[12, 8, GeolocationAccuracy(param.accuracy)],
		[4, 9, param.altitudeMeters],
	];
}
dynamic ContentType(dynamic param) {
	if (param is int) {
		return LINEtypes.ContentType.fromValue(param);
	}
	return param;
}
dynamic Pb1_EnumC13015h6(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_EnumC13015h6.fromValue(param);
	}
	return param;
}
dynamic Pb1_E7(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_E7.fromValue(param);
	}
	return param;
}
dynamic Pb1_B(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_B.fromValue(param);
	}
	return param;
}
List ReactionType(LINEtypes.ReactionType? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, MessageReactionType(param.predefinedReactionType)],
	];
}
List Reaction(LINEtypes.Reaction? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.fromUserMid],
		[10, 2, param.atMillis],
		[12, 3, ReactionType(param.reactionType)],
	];
}
List Message(LINEtypes.Message? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.from],
		[11, 2, param.to],
		[8, 3, MIDType(param.toType)],
		[11, 4, param.id],
		[10, 5, param.createdTime],
		[10, 6, param.deliveredTime],
		[11, 10, param.text],
		[12, 11, Location(param.location)],
		[2, 14, param.hasContent],
		[8, 15, ContentType(param.contentType)],
		[11, 17, param.contentPreview],
		[13, 18, [11, 11, param.contentMetadata]],
		[3, 19, param.sessionId],
		[15, 20, [11, param.chunks]],
		[11, 21, param.relatedMessageId],
		[8, 22, Pb1_EnumC13015h6(param.messageRelationType)],
		[8, 23, param.readCount],
		[8, 24, Pb1_E7(param.relatedMessageServiceCode)],
		[8, 25, Pb1_B(param.appExtensionType)],
		[15, 27, [12, param.reactions != null ? param.reactions.map((e) => Reaction(e)).toList() : []]],
	];
}
dynamic SquareMessageState(dynamic param) {
	if (param is int) {
		return LINEtypes.SquareMessageState.fromValue(param);
	}
	return param;
}
List SquareMessageThreadInfo(LINEtypes.SquareMessageThreadInfo? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.chatThreadMid],
		[2, 2, param.threadRoot],
	];
}
List SquareMessage(LINEtypes.SquareMessage? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, Message(param.message)],
		[8, 3, MIDType(param.fromType)],
		[10, 4, param.squareMessageRevision],
		[8, 5, SquareMessageState(param.state)],
		[12, 6, SquareMessageThreadInfo(param.threadInfo)],
	];
}
List SendMessageRequest(LINEtypes.SendMessageRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.squareChatMid],
		[12, 3, SquareMessage(param.squareMessage)],
	];
}
List SendSquareThreadMessageRequest(LINEtypes.SendSquareThreadMessageRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.chatMid],
		[11, 3, param.threadMid],
		[12, 4, SquareMessage(param.threadMessage)],
	];
}
List SyncSquareMembersRequest(LINEtypes.SyncSquareMembersRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareMid],
		[13, 2, [11, 10, param.squareMembers]],
	];
}
List UnhideSquareMemberContentsRequest(LINEtypes.UnhideSquareMemberContentsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareMemberMid],
	];
}
List UnsendMessageRequest(LINEtypes.UnsendMessageRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareChatMid],
		[11, 3, param.messageId],
		[11, 4, param.threadMid],
	];
}
dynamic SquareAuthorityAttribute(dynamic param) {
	if (param is int) {
		return LINEtypes.SquareAuthorityAttribute.fromValue(param);
	}
	return param;
}
List SquareAuthority(LINEtypes.SquareAuthority? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareMid],
		[8, 2, SquareMemberRole(param.updateSquareProfile)],
		[8, 3, SquareMemberRole(param.inviteNewMember)],
		[8, 4, SquareMemberRole(param.approveJoinRequest)],
		[8, 5, SquareMemberRole(param.createPost)],
		[8, 6, SquareMemberRole(param.createOpenSquareChat)],
		[8, 7, SquareMemberRole(param.deleteSquareChatOrPost)],
		[8, 8, SquareMemberRole(param.removeSquareMember)],
		[8, 9, SquareMemberRole(param.grantRole)],
		[8, 10, SquareMemberRole(param.enableInvitationTicket)],
		[10, 11, param.revision],
		[8, 12, SquareMemberRole(param.createSquareChatAnnouncement)],
		[8, 13, SquareMemberRole(param.updateMaxChatMemberCount)],
		[8, 14, SquareMemberRole(param.useReadonlyDefaultChat)],
		[8, 15, SquareMemberRole(param.sendAllMention)],
	];
}
List UpdateSquareAuthorityRequest(LINEtypes.UpdateSquareAuthorityRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[14, 2, [
			8,
			param.updateAttributes != null ? param.updateAttributes.map((e) => SquareAuthorityAttribute(e)).toList() : [],
		]],
		[12, 3, SquareAuthority(param.authority)],
	];
}
dynamic SquareChatMemberAttribute(dynamic param) {
	if (param is int) {
		return LINEtypes.SquareChatMemberAttribute.fromValue(param);
	}
	return param;
}
dynamic SquareChatMembershipState(dynamic param) {
	if (param is int) {
		return LINEtypes.SquareChatMembershipState.fromValue(param);
	}
	return param;
}
List SquareChatMember(LINEtypes.SquareChatMember? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareMemberMid],
		[11, 2, param.squareChatMid],
		[10, 3, param.revision],
		[8, 4, SquareChatMembershipState(param.membershipState)],
		[2, 5, param.notificationForMessage],
		[2, 6, param.notificationForNewMember],
	];
}
List UpdateSquareChatMemberRequest(LINEtypes.UpdateSquareChatMemberRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[14, 2, [
			8,
			param.updatedAttrs != null ? param.updatedAttrs.map((e) => SquareChatMemberAttribute(e)).toList() : [],
		]],
		[12, 3, SquareChatMember(param.chatMember)],
	];
}
dynamic SquareChatAttribute(dynamic param) {
	if (param is int) {
		return LINEtypes.SquareChatAttribute.fromValue(param);
	}
	return param;
}
List UpdateSquareChatRequest(LINEtypes.UpdateSquareChatRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[14, 2, [
			8,
			param.updatedAttrs != null ? param.updatedAttrs.map((e) => SquareChatAttribute(e)).toList() : [],
		]],
		[12, 3, SquareChat(param.squareChat)],
	];
}
dynamic SquareFeatureSetAttribute(dynamic param) {
	if (param is int) {
		return LINEtypes.SquareFeatureSetAttribute.fromValue(param);
	}
	return param;
}
dynamic SquareFeatureControlState(dynamic param) {
	if (param is int) {
		return LINEtypes.SquareFeatureControlState.fromValue(param);
	}
	return param;
}
List SquareFeature(LINEtypes.SquareFeature? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, SquareFeatureControlState(param.controlState)],
		[8, 2, BooleanState(param.booleanValue)],
	];
}
List SquareFeatureSet(LINEtypes.SquareFeatureSet? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareMid],
		[10, 2, param.revision],
		[12, 11, SquareFeature(param.creatingSecretSquareChat)],
		[12, 12, SquareFeature(param.invitingIntoOpenSquareChat)],
		[12, 13, SquareFeature(param.creatingSquareChat)],
		[12, 14, SquareFeature(param.readonlyDefaultChat)],
		[12, 15, SquareFeature(param.showingAdvertisement)],
		[12, 16, SquareFeature(param.delegateJoinToPlug)],
		[12, 17, SquareFeature(param.delegateKickOutToPlug)],
		[12, 18, SquareFeature(param.disableUpdateJoinMethod)],
		[12, 19, SquareFeature(param.disableTransferAdmin)],
		[12, 20, SquareFeature(param.creatingLiveTalk)],
		[12, 21, SquareFeature(param.disableUpdateSearchable)],
		[12, 22, SquareFeature(param.summarizingMessages)],
		[12, 23, SquareFeature(param.creatingSquareThread)],
		[12, 24, SquareFeature(param.enableSquareThread)],
		[12, 25, SquareFeature(param.disableChangeRoleCoAdmin)],
	];
}
List UpdateSquareFeatureSetRequest(LINEtypes.UpdateSquareFeatureSetRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[14, 2, [
			8,
			param.updateAttributes != null ? param.updateAttributes.map((e) => SquareFeatureSetAttribute(e)).toList() : [],
		]],
		[12, 3, SquareFeatureSet(param.squareFeatureSet)],
	];
}
List SquareMemberRelation(LINEtypes.SquareMemberRelation? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, SquareMemberRelationState(param.state)],
		[10, 2, param.revision],
	];
}
List UpdateSquareMemberRelationRequest(LINEtypes.UpdateSquareMemberRelationRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.squareMid],
		[11, 3, param.targetSquareMemberMid],
		[14, 4, [8, param.updatedAttrs]],
		[12, 5, SquareMemberRelation(param.relation)],
	];
}
dynamic SquareMemberAttribute(dynamic param) {
	if (param is int) {
		return LINEtypes.SquareMemberAttribute.fromValue(param);
	}
	return param;
}
dynamic SquarePreferenceAttribute(dynamic param) {
	if (param is int) {
		return LINEtypes.SquarePreferenceAttribute.fromValue(param);
	}
	return param;
}
List UpdateSquareMemberRequest(LINEtypes.UpdateSquareMemberRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[14, 2, [
			8,
			param.updatedAttrs != null ? param.updatedAttrs.map((e) => SquareMemberAttribute(e)).toList() : [],
		]],
		[14, 3, [
			8,
			param.updatedPreferenceAttrs != null ? param.updatedPreferenceAttrs.map((e) => SquarePreferenceAttribute(e)).toList() : [],
		]],
		[12, 4, SquareMember(param.squareMember)],
	];
}
List UpdateSquareMembersRequest(LINEtypes.UpdateSquareMembersRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[14, 2, [
			8,
			param.updatedAttrs != null ? param.updatedAttrs.map((e) => SquareMemberAttribute(e)).toList() : [],
		]],
		[15, 3, [12, param.members != null ? param.members.map((e) => SquareMember(e)).toList() : []]],
	];
}
dynamic SquareAttribute(dynamic param) {
	if (param is int) {
		return LINEtypes.SquareAttribute.fromValue(param);
	}
	return param;
}
List UpdateSquareRequest(LINEtypes.UpdateSquareRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[14, 2, [
			8,
			param.updatedAttrs != null ? param.updatedAttrs.map((e) => SquareAttribute(e)).toList() : [],
		]],
		[12, 3, Square(param.square)],
	];
}
List SquareUserSettings(LINEtypes.SquareUserSettings? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, BooleanState(param.liveTalkNotification)],
	];
}
List UpdateUserSettingsRequest(LINEtypes.UpdateUserSettingsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, SquareUserSettings(param.userSettings)],
	];
}
dynamic r80_EnumC34362b(dynamic param) {
	if (param is int) {
		return LINEtypes.r80_EnumC34362b.fromValue(param);
	}
	return param;
}
dynamic r80_EnumC34361a(dynamic param) {
	if (param is int) {
		return LINEtypes.r80_EnumC34361a.fromValue(param);
	}
	return param;
}
List AuthenticatorAssertionResponse(LINEtypes.AuthenticatorAssertionResponse? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.clientDataJSON],
		[11, 2, param.authenticatorData],
		[11, 3, param.signature],
		[11, 4, param.userHandle],
	];
}
List AuthenticationExtensionsClientOutputs(LINEtypes.AuthenticationExtensionsClientOutputs? param) {
	if (param == null) {
		return [];
	}
	return [
		[2, 91, param.lineAuthenSel],
	];
}
List AuthPublicKeyCredential(LINEtypes.AuthPublicKeyCredential? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.id],
		[11, 2, param.type],
		[12, 3, AuthenticatorAssertionResponse(param.response)],
		[12, 4, AuthenticationExtensionsClientOutputs(param.extensionResults)],
	];
}
List AuthenticateWithPaakRequest(LINEtypes.AuthenticateWithPaakRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.sessionId],
		[12, 2, AuthPublicKeyCredential(param.credential)],
	];
}
List BulkFollowRequest(LINEtypes.BulkFollowRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[14, 1, [11, param.followTargetMids]],
		[14, 2, [11, param.unfollowTargetMids]],
		[2, 3, param.hasNext],
	];
}
dynamic t80_h(dynamic param) {
	if (param is int) {
		return LINEtypes.t80_h.fromValue(param);
	}
	return param;
}
List GetRequest(LINEtypes.GetRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.keyName],
		[8, 2, t80_h(param.ns)],
	];
}
List BulkGetRequest(LINEtypes.BulkGetRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[14, 1, [12, param.requests != null ? param.requests.map((e) => GetRequest(e)).toList() : []]],
	];
}
List BuyMustbuyRequest(LINEtypes.BuyMustbuyRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Ob1_O0(param.productType)],
		[11, 2, param.productId],
		[11, 3, param.serialNumber],
	];
}
List CanCreateCombinationStickerRequest(LINEtypes.CanCreateCombinationStickerRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[14, 1, [11, param.packageIds]],
	];
}
List Locale(LINEtypes.Locale? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.language],
		[11, 2, param.country],
	];
}
List CancelChatInvitationRequest(LINEtypes.CancelChatInvitationRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.chatMid],
		[14, 3, [11, param.targetUserMids]],
	];
}
List CancelPaakAuthRequest(LINEtypes.CancelPaakAuthRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.sessionId],
	];
}
List CancelPaakAuthenticationRequest(LINEtypes.CancelPaakAuthenticationRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
	];
}
List CancelPinCodeRequest(LINEtypes.CancelPinCodeRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
	];
}
List CancelReactionRequest(LINEtypes.CancelReactionRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[10, 2, param.messageId],
	];
}
dynamic VerificationMethod(dynamic param) {
	if (param is int) {
		return LINEtypes.VerificationMethod.fromValue(param);
	}
	return param;
}
dynamic r80_n0(dynamic param) {
	if (param is int) {
		return LINEtypes.r80_n0.fromValue(param);
	}
	return param;
}
dynamic T70_EnumC14390b(dynamic param) {
	if (param is int) {
		return LINEtypes.T70_EnumC14390b.fromValue(param);
	}
	return param;
}
List AccountIdentifier(LINEtypes.AccountIdentifier? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, T70_EnumC14390b(param.type)],
		[11, 2, param.identifier],
		[11, 11, param.countryCode],
	];
}
List h80_t(LINEtypes.h80_t? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.newDevicePublicKey],
		[11, 2, param.encryptedQrIdentifier],
	];
}
List CheckIfEncryptedE2EEKeyReceivedRequest(LINEtypes.CheckIfEncryptedE2EEKeyReceivedRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.sessionId],
		[12, 2, h80_t(param.secureChannelData)],
	];
}
List UserPhoneNumber(LINEtypes.UserPhoneNumber? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.phoneNumber],
		[11, 2, param.countryCode],
	];
}
List CheckIfPhonePinCodeMsgVerifiedRequest(LINEtypes.CheckIfPhonePinCodeMsgVerifiedRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
		[12, 2, UserPhoneNumber(param.userPhoneNumber)],
	];
}
dynamic r80_EnumC34368h(dynamic param) {
	if (param is int) {
		return LINEtypes.r80_EnumC34368h.fromValue(param);
	}
	return param;
}
dynamic r80_EnumC34371k(dynamic param) {
	if (param is int) {
		return LINEtypes.r80_EnumC34371k.fromValue(param);
	}
	return param;
}
List CheckUserAgeAfterApprovalWithDocomoV2Request(LINEtypes.CheckUserAgeAfterApprovalWithDocomoV2Request? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.accessToken],
		[11, 2, param.agprm],
	];
}
List CheckUserAgeWithDocomoV2Request(LINEtypes.CheckUserAgeWithDocomoV2Request? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authCode],
	];
}
dynamic CarrierCode(dynamic param) {
	if (param is int) {
		return LINEtypes.CarrierCode.fromValue(param);
	}
	return param;
}
dynamic IdentityProvider(dynamic param) {
	if (param is int) {
		return LINEtypes.IdentityProvider.fromValue(param);
	}
	return param;
}
List IdentifierConfirmationRequest(LINEtypes.IdentifierConfirmationRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[13, 1, [11, 11, param.metaData]],
		[2, 2, param.forceRegistration],
		[11, 3, param.verificationCode],
	];
}
List IdentityCredentialRequest(LINEtypes.IdentityCredentialRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[13, 1, [11, 11, param.metaData]],
		[8, 2, IdentityProvider(param.identityProvider)],
		[11, 3, param.cipherKeyId],
		[11, 4, param.cipherText],
		[12, 5, IdentifierConfirmationRequest(param.confirmationRequest)],
	];
}
List ConnectEapAccountRequest(LINEtypes.ConnectEapAccountRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
	];
}
dynamic Pb1_X2(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_X2.fromValue(param);
	}
	return param;
}
List ChatRoomAnnouncementContentMetadata(LINEtypes.ChatRoomAnnouncementContentMetadata? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.replace],
		[11, 2, param.sticonOwnership],
		[11, 3, param.postNotificationMetadata],
	];
}
List ChatRoomAnnouncementContents(LINEtypes.ChatRoomAnnouncementContents? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.displayFields],
		[11, 2, param.text],
		[11, 3, param.link],
		[11, 4, param.thumbnail],
		[12, 5, ChatRoomAnnouncementContentMetadata(param.contentMetadata)],
	];
}
dynamic Pb1_Z2(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_Z2.fromValue(param);
	}
	return param;
}
List CreateChatRequest(LINEtypes.CreateChatRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[8, 2, Pb1_Z2(param.type)],
		[11, 3, param.name],
		[14, 4, [11, param.targetUserMids]],
		[11, 5, param.picturePath],
	];
}
dynamic Pb1_A3(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_A3.fromValue(param);
	}
	return param;
}
List Pb1_C13263z3(LINEtypes.Pb1_C13263z3? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.blobHeader],
		[11, 2, param.blobPayload],
		[8, 3, Pb1_A3(param.reason)],
	];
}
List CreateGroupCallUrlRequest(LINEtypes.CreateGroupCallUrlRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.title],
	];
}
List E2EEMetadata(LINEtypes.E2EEMetadata? param) {
	if (param == null) {
		return [];
	}
	return [
		[10, 1, param.e2EEPublicKeyId],
	];
}
List SingleValueMetadata(LINEtypes.SingleValueMetadata? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List Pb1_W5(LINEtypes.Pb1_W5? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, E2EEMetadata(param.e2ee)],
		[12, 2, SingleValueMetadata(param.singleValue)],
	];
}
List Pb1_X5(LINEtypes.Pb1_X5? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, Pb1_W5(param.metadata)],
		[11, 2, param.blobPayload],
	];
}
List Pb1_E3(LINEtypes.Pb1_E3? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.blobHeader],
		[15, 2, [
			12,
			param.payloadDataList != null ? param.payloadDataList.map((e) => Pb1_X5(e)).toList() : [],
		]],
	];
}
List CreateMultiProfileRequest(LINEtypes.CreateMultiProfileRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.displayName],
	];
}
List h80_C25643c(LINEtypes.h80_C25643c? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List Pb1_H3(LINEtypes.Pb1_H3? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List DeleteGroupCallUrlRequest(LINEtypes.DeleteGroupCallUrlRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.urlId],
	];
}
List DeleteMultiProfileRequest(LINEtypes.DeleteMultiProfileRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.profileId],
	];
}
List DeleteOtherFromChatRequest(LINEtypes.DeleteOtherFromChatRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.chatMid],
		[14, 3, [11, param.targetUserMids]],
	];
}
List R70_c(LINEtypes.R70_c? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List DeleteSafetyStatusRequest(LINEtypes.DeleteSafetyStatusRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.disasterId],
	];
}
List DeleteSelfFromChatRequest(LINEtypes.DeleteSelfFromChatRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.chatMid],
		[10, 3, param.lastSeenMessageDeliveredTime],
		[11, 4, param.lastSeenMessageId],
		[10, 5, param.lastMessageDeliveredTime],
		[11, 6, param.lastMessageId],
	];
}
List DetermineMediaMessageFlowRequest(LINEtypes.DetermineMediaMessageFlowRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.chatMid],
	];
}
dynamic Q70_q(dynamic param) {
	if (param is int) {
		return LINEtypes.Q70_q.fromValue(param);
	}
	return param;
}
List DisconnectEapAccountRequest(LINEtypes.DisconnectEapAccountRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Q70_q(param.eapType)],
	];
}
List S70_b(LINEtypes.S70_b? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List FetchOperationsRequest(LINEtypes.FetchOperationsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.deviceId],
		[10, 2, param.offsetFrom],
	];
}
List FetchPhonePinCodeMsgRequest(LINEtypes.FetchPhonePinCodeMsgRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
		[12, 2, UserPhoneNumber(param.userPhoneNumber)],
	];
}
dynamic Pb1_F0(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_F0.fromValue(param);
	}
	return param;
}
List FindChatByTicketRequest(LINEtypes.FindChatByTicketRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.ticketId],
	];
}
List FollowRequest(LINEtypes.FollowRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, Pb1_A4(param.followMid)],
	];
}
List GetAccessTokenRequest(LINEtypes.GetAccessTokenRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.fontId],
	];
}
List GetAllChatMidsRequest(LINEtypes.GetAllChatMidsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[2, 1, param.withMemberChats],
		[2, 2, param.withInvitedChats],
	];
}
dynamic Pb1_V7(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_V7.fromValue(param);
	}
	return param;
}
List m80_l(LINEtypes.m80_l? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List m80_n(LINEtypes.m80_n? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LatestProductsByAuthorRequest(LINEtypes.LatestProductsByAuthorRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Ob1_O0(param.productType)],
		[10, 2, param.authorId],
		[8, 3, param.limit],
	];
}
dynamic Ob1_a2(dynamic param) {
	if (param is int) {
		return LINEtypes.Ob1_a2.fromValue(param);
	}
	return param;
}
List AutoSuggestionShowcaseRequest(LINEtypes.AutoSuggestionShowcaseRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Ob1_O0(param.productType)],
		[8, 2, Ob1_a2(param.suggestionType)],
	];
}
List NZ0_C12208u(LINEtypes.NZ0_C12208u? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List NZ0_C12214w(LINEtypes.NZ0_C12214w? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List ZQ0_b(LINEtypes.ZQ0_b? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List UEN(LINEtypes.UEN? param) {
	if (param == null) {
		return [];
	}
	return [
		[10, 1, param.revision],
	];
}
List Beacon(LINEtypes.Beacon? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.hardwareId],
	];
}
List Uf_C14856C(LINEtypes.Uf_C14856C? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, UEN(param.uen)],
		[12, 2, Beacon(param.beacon)],
	];
}
List AdRequest(LINEtypes.AdRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[13, 1, [11, 11, param.headers]],
		[13, 2, [11, 11, param.queryParams]],
	];
}
dynamic Uf_EnumC14873o(dynamic param) {
	if (param is int) {
		return LINEtypes.Uf_EnumC14873o.fromValue(param);
	}
	return param;
}
List ContentRequest(LINEtypes.ContentRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Uf_EnumC14873o(param.os)],
		[11, 2, param.appv],
		[11, 3, param.lineAcceptableLanguage],
		[11, 4, param.countryCode],
	];
}
List BannerRequest(LINEtypes.BannerRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[2, 1, param.test],
		[12, 2, Uf_C14856C(param.trigger)],
		[12, 3, AdRequest(param.ad)],
		[12, 4, ContentRequest(param.content)],
	];
}
List Eh_C8933a(LINEtypes.Eh_C8933a? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List GetBleDeviceRequest(LINEtypes.GetBleDeviceRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.serviceUuid],
		[11, 2, param.psdi],
	];
}
List GetBuddyChatBarRequest(LINEtypes.GetBuddyChatBarRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.buddyMid],
		[10, 2, param.chatBarRevision],
		[11, 3, param.richMenuId],
	];
}
dynamic Pb1_D0(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_D0.fromValue(param);
	}
	return param;
}
List GetBuddyLiveRequest(LINEtypes.GetBuddyLiveRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.mid],
	];
}
List GetBuddyStatusBarV2Request(LINEtypes.GetBuddyStatusBarV2Request? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.botMid],
		[10, 2, param.revision],
	];
}
List GetCallStatusRequest(LINEtypes.GetCallStatusRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.basicSearchId],
		[11, 2, param.otp],
	];
}
List GetCampaignRequest(LINEtypes.GetCampaignRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.campaignType],
	];
}
List GetChallengeForPaakAuthRequest(LINEtypes.GetChallengeForPaakAuthRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.sessionId],
	];
}
List GetChallengeForPrimaryRegRequest(LINEtypes.GetChallengeForPrimaryRegRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.sessionId],
	];
}
List GetChannelContextRequest(LINEtypes.GetChannelContextRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
	];
}
dynamic Pb1_Q2(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_Q2.fromValue(param);
	}
	return param;
}
List GetChatappRequest(LINEtypes.GetChatappRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.chatappId],
		[11, 2, param.language],
	];
}
List GetChatsRequest(LINEtypes.GetChatsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[15, 1, [11, param.chatMids]],
		[2, 2, param.withMembers],
		[2, 3, param.withInvitees],
	];
}
dynamic jO0_EnumC27533B(dynamic param) {
	if (param is int) {
		return LINEtypes.jO0_EnumC27533B.fromValue(param);
	}
	return param;
}
dynamic jO0_EnumC27559z(dynamic param) {
	if (param is int) {
		return LINEtypes.jO0_EnumC27559z.fromValue(param);
	}
	return param;
}
List GetCoinProductsRequest(LINEtypes.GetCoinProductsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, jO0_EnumC27533B(param.appStoreCode)],
		[11, 2, param.country],
		[11, 3, param.language],
		[8, 4, jO0_EnumC27559z(param.pgCode)],
	];
}
List GetCoinHistoryRequest(LINEtypes.GetCoinHistoryRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, jO0_EnumC27533B(param.appStoreCode)],
		[11, 2, param.country],
		[11, 3, param.language],
		[11, 4, param.searchEndDate],
		[8, 5, param.offset],
		[8, 6, param.limit],
	];
}
List GetContactCalendarEventTarget(LINEtypes.GetContactCalendarEventTarget? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.targetUserMid],
	];
}
List GetContactCalendarEventsRequest(LINEtypes.GetContactCalendarEventsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[15, 1, [
			12,
			param.targetUsers != null ? param.targetUsers.map((e) => GetContactCalendarEventTarget(e)).toList() : [],
		]],
		[8, 2, Pb1_V7(param.syncReason)],
	];
}
List GetContactV3Target(LINEtypes.GetContactV3Target? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.targetUserMid],
	];
}
List GetContactsV3Request(LINEtypes.GetContactsV3Request? param) {
	if (param == null) {
		return [];
	}
	return [
		[15, 1, [
			12,
			param.targetUsers != null ? param.targetUsers.map((e) => GetContactV3Target(e)).toList() : [],
		]],
		[8, 2, Pb1_V7(param.syncReason)],
		[2, 3, param.checkUserStatusStrictly],
	];
}
dynamic Pb1_EnumC13221w3(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_EnumC13221w3.fromValue(param);
	}
	return param;
}
List SimCard(LINEtypes.SimCard? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.countryCode],
		[11, 2, param.hni],
		[11, 3, param.carrierName],
	];
}
List fN0_C24473e(LINEtypes.fN0_C24473e? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List DestinationLIFFRequest(LINEtypes.DestinationLIFFRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.originalUrl],
	];
}
List vh_C37633d(LINEtypes.vh_C37633d? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List Pb1_W4(LINEtypes.Pb1_W4? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List Pb1_Y4(LINEtypes.Pb1_Y4? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List GetExchangeKeyRequest(LINEtypes.GetExchangeKeyRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.sessionId],
	];
}
List GetFollowBlacklistRequest(LINEtypes.GetFollowBlacklistRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.cursor],
	];
}
List GetFollowersRequest(LINEtypes.GetFollowersRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, Pb1_A4(param.followMid)],
		[11, 2, param.cursor],
	];
}
List GetFollowingsRequest(LINEtypes.GetFollowingsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, Pb1_A4(param.followMid)],
		[11, 2, param.cursor],
	];
}
dynamic VR0_l(dynamic param) {
	if (param is int) {
		return LINEtypes.VR0_l.fromValue(param);
	}
	return param;
}
List GetFontMetasRequest(LINEtypes.GetFontMetasRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, VR0_l(param.requestCause)],
	];
}
List GetFriendDetailTarget(LINEtypes.GetFriendDetailTarget? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.targetUserMid],
	];
}
List GetFriendDetailsRequest(LINEtypes.GetFriendDetailsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[15, 1, [
			12,
			param.targetUsers != null ? param.targetUsers.map((e) => GetFriendDetailTarget(e)).toList() : [],
		]],
		[8, 2, Pb1_V7(param.syncReason)],
	];
}
dynamic Pb1_F4(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_F4.fromValue(param);
	}
	return param;
}
List GetGnbBadgeStatusRequest(LINEtypes.GetGnbBadgeStatusRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.uenRevision],
	];
}
List GetGroupCallUrlInfoRequest(LINEtypes.GetGroupCallUrlInfoRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.urlId],
	];
}
List Pb1_C13042j5(LINEtypes.Pb1_C13042j5? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List GetHomeFlexContentRequest(LINEtypes.GetHomeFlexContentRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.supportedFlexVersion],
	];
}
List Eg_C8928b(LINEtypes.Eg_C8928b? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List GetHomeServicesRequest(LINEtypes.GetHomeServicesRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[15, 1, [8, param.ids]],
	];
}
List fN0_C24471c(LINEtypes.fN0_C24471c? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List GetJoinedMembershipByBotMidRequest(LINEtypes.GetJoinedMembershipByBotMidRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.botMid],
	];
}
List GetJoinedMembershipRequest(LINEtypes.GetJoinedMembershipRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.uniqueKey],
	];
}
List Pb1_C13070l5(LINEtypes.Pb1_C13070l5? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List LiffViewWithoutUserContextRequest(LINEtypes.LiffViewWithoutUserContextRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.liffId],
	];
}
dynamic r80_EnumC34372l(dynamic param) {
	if (param is int) {
		return LINEtypes.r80_EnumC34372l.fromValue(param);
	}
	return param;
}
List GetLoginActorContextRequest(LINEtypes.GetLoginActorContextRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.sessionId],
	];
}
List GetMappedProfileIdsRequest(LINEtypes.GetMappedProfileIdsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[15, 1, [11, param.targetUserMids]],
	];
}
List MessageBoxListRequest(LINEtypes.MessageBoxListRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.minChatId],
		[11, 2, param.maxChatId],
		[2, 3, param.activeOnly],
		[8, 4, param.messageBoxCountLimit],
		[2, 5, param.withUnreadCount],
		[8, 6, param.lastMessagesPerMessageBoxCount],
		[2, 7, param.unreadOnly],
	];
}
List GetModuleLayoutV4Request(LINEtypes.GetModuleLayoutV4Request? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.etag],
	];
}
List NZ0_G(LINEtypes.NZ0_G? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.id],
		[11, 2, param.etag],
		[11, 3, param.recommendedModelId],
		[11, 4, param.deviceAdId],
		[2, 5, param.agreedWithTargetingAdByMid],
		[11, 6, param.deviceId],
	];
}
List NZ0_E(LINEtypes.NZ0_E? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.id],
		[11, 2, param.etag],
		[11, 3, param.recommendedModelId],
		[11, 4, param.deviceAdId],
		[2, 5, param.agreedWithTargetingAdByMid],
		[11, 6, param.deviceId],
	];
}
List GetModulesRequestV2(LINEtypes.GetModulesRequestV2? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.etag],
		[11, 2, param.deviceAdId],
	];
}
dynamic NZ0_EnumC12169g1(dynamic param) {
	if (param is int) {
		return LINEtypes.NZ0_EnumC12169g1.fromValue(param);
	}
	return param;
}
List GetModulesRequestV3(LINEtypes.GetModulesRequestV3? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.etag],
		[8, 2, NZ0_EnumC12169g1(param.tabIdentifier)],
		[11, 3, param.deviceAdId],
		[2, 4, param.agreedWithTargetingAdByMid],
	];
}
List GetModulesV4WithStatusRequest(LINEtypes.GetModulesV4WithStatusRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.etag],
		[11, 2, param.subTabId],
		[11, 3, param.deviceAdId],
		[2, 4, param.agreedWithTargetingAdByMid],
		[11, 5, param.deviceId],
	];
}
List GetMyAssetInformationV2Request(LINEtypes.GetMyAssetInformationV2Request? param) {
	if (param == null) {
		return [];
	}
	return [
		[2, 1, param.refresh],
	];
}
List GetMyChatappsRequest(LINEtypes.GetMyChatappsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.language],
		[11, 2, param.continuationToken],
	];
}
List GetMyDashboardRequest(LINEtypes.GetMyDashboardRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, NZ0_EnumC12169g1(param.tabIdentifier)],
	];
}
List GetNotificationSettingsRequest(LINEtypes.GetNotificationSettingsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[14, 1, [11, param.chatMids]],
		[8, 2, Pb1_V7(param.syncReason)],
	];
}
List GetPasswordHashingParametersRequest(LINEtypes.GetPasswordHashingParametersRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.sessionId],
	];
}
List GetPasswordHashingParametersForPwdRegRequest(LINEtypes.GetPasswordHashingParametersForPwdRegRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
	];
}
List GetPasswordHashingParametersForPwdVerifRequest(LINEtypes.GetPasswordHashingParametersForPwdVerifRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
		[12, 2, AccountIdentifier(param.accountIdentifier)],
	];
}
List Device(LINEtypes.Device? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.udid],
		[11, 2, param.deviceModel],
	];
}
List GetPhoneVerifMethodForRegistrationRequest(LINEtypes.GetPhoneVerifMethodForRegistrationRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
		[12, 2, Device(param.device)],
		[12, 3, UserPhoneNumber(param.userPhoneNumber)],
	];
}
List GetPhoneVerifMethodV2Request(LINEtypes.GetPhoneVerifMethodV2Request? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
		[12, 2, Device(param.device)],
		[12, 3, UserPhoneNumber(param.userPhoneNumber)],
	];
}
List Pb1_C13126p5(LINEtypes.Pb1_C13126p5? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List GetPredefinedScenarioSetsRequest(LINEtypes.GetPredefinedScenarioSetsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[15, 1, [11, param.deviceIds]],
	];
}
List fN0_C24475g(LINEtypes.fN0_C24475g? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List fN0_C24476h(LINEtypes.fN0_C24476h? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List MessageBoxV2MessageId(LINEtypes.MessageBoxV2MessageId? param) {
	if (param == null) {
		return [];
	}
	return [
		[10, 1, param.deliveredTime],
		[10, 2, param.messageId],
	];
}
List GetPreviousMessagesV2Request(LINEtypes.GetPreviousMessagesV2Request? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.messageBoxId],
		[12, 2, MessageBoxV2MessageId(param.endMessageId)],
		[8, 3, param.messagesCount],
		[2, 4, param.withReadCount],
		[2, 5, param.receivedOnly],
	];
}
List GetPublishedMembershipsRequest(LINEtypes.GetPublishedMembershipsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.basicSearchId],
	];
}
List PurchaseEnabledRequest(LINEtypes.PurchaseEnabledRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.uniqueKey],
	];
}
List NZ0_S(LINEtypes.NZ0_S? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List GetRecommendationDetailTarget(LINEtypes.GetRecommendationDetailTarget? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.targetUserMid],
	];
}
List GetRecommendationDetailsRequest(LINEtypes.GetRecommendationDetailsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[15, 1, [
			12,
			param.targetUsers != null ? param.targetUsers.map((e) => GetRecommendationDetailTarget(e)).toList() : [],
		]],
		[8, 2, Pb1_V7(param.syncReason)],
	];
}
List ConfigurationsParams(LINEtypes.ConfigurationsParams? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.regionOfUsim],
		[11, 2, param.regionOfTelephone],
		[11, 3, param.regionOfLocale],
		[11, 4, param.carrier],
	];
}
List RepairGroupMembers(LINEtypes.RepairGroupMembers? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.numMembers],
		[2, 3, param.invalidGroup],
	];
}
List GetRepairElementsRequest(LINEtypes.GetRepairElementsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[2, 1, param.profile],
		[2, 2, param.settings],
		[12, 3, ConfigurationsParams(param.configurations)],
		[8, 4, param.numLocalJoinedGroups],
		[8, 5, param.numLocalInvitedGroups],
		[8, 6, param.numLocalFriends],
		[8, 7, param.numLocalRecommendations],
		[8, 8, param.numLocalBlockedFriends],
		[8, 9, param.numLocalBlockedRecommendations],
		[13, 10, [11, 12, map(RepairGroupMembers, param.localGroupMembers)]],
		[8, 11, Pb1_V7(param.syncReason)],
		[13, 12, [11, 8, param.localProfileMappings]],
	];
}
List GetResponseStatusRequest(LINEtypes.GetResponseStatusRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.botMid],
	];
}
List WebLoginRequest(LINEtypes.WebLoginRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.hookedFullUrl],
		[11, 2, param.sessionString],
		[2, 3, param.fromIAB],
		[11, 4, param.sourceApplication],
	];
}
List LiffChatContext(LINEtypes.LiffChatContext? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.chatMid],
	];
}
List LiffSquareChatContext(LINEtypes.LiffSquareChatContext? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.squareChatMid],
	];
}
List Qj_C13595l(LINEtypes.Qj_C13595l? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, LiffChatContext(param.chat)],
		[12, 3, LiffSquareChatContext(param.squareChat)],
	];
}
dynamic Qj_EnumC13584a(dynamic param) {
	if (param is int) {
		return LINEtypes.Qj_EnumC13584a.fromValue(param);
	}
	return param;
}
List SKAdNetwork(LINEtypes.SKAdNetwork? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.identifiers],
		[11, 2, param.version],
	];
}
List LiffAdvertisingId(LINEtypes.LiffAdvertisingId? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.advertisingId],
		[2, 2, param.tracking],
		[8, 3, Qj_EnumC13584a(param.att)],
		[12, 4, SKAdNetwork(param.skAdNetwork)],
	];
}
List LiffDeviceSetting(LINEtypes.LiffDeviceSetting? param) {
	if (param == null) {
		return [];
	}
	return [
		[2, 1, param.videoAutoPlayAllowed],
		[12, 2, LiffAdvertisingId(param.advertisingId)],
	];
}
List LiffWebLoginRequest(LINEtypes.LiffWebLoginRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.hookedFullUrl],
		[11, 2, param.sessionString],
		[12, 3, Qj_C13595l(param.context)],
		[12, 4, LiffDeviceSetting(param.deviceSetting)],
	];
}
List GetSCCRequest(LINEtypes.GetSCCRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.basicSearchId],
	];
}
List Eh_C8935c(LINEtypes.Eh_C8935c? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List NZ0_U(LINEtypes.NZ0_U? param) {
	if (param == null) {
		return [];
	}
	return [];
}
dynamic SettingsAttributeEx(dynamic param) {
	if (param is int) {
		return LINEtypes.SettingsAttributeEx.fromValue(param);
	}
	return param;
}
List GetSmartChannelRecommendationsRequest(LINEtypes.GetSmartChannelRecommendationsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.maxResults],
		[11, 2, param.placement],
		[2, 3, param.testMode],
	];
}
List GetSquareBotRequest(LINEtypes.GetSquareBotRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.botMid],
	];
}
List Ob1_C12606a0(LINEtypes.Ob1_C12606a0? param) {
	if (param == null) {
		return [];
	}
	return [];
}
dynamic Ob1_K1(dynamic param) {
	if (param is int) {
		return LINEtypes.Ob1_K1.fromValue(param);
	}
	return param;
}
List GetSubscriptionPlansRequest(LINEtypes.GetSubscriptionPlansRequest? param) {
	if (param == null) {
		return [];
	}
	return [

		[8, 2, Ob1_K1(param.storeCode)],
	];
}
List Ob1_C12618e0(LINEtypes.Ob1_C12618e0? param) {
	if (param == null) {
		return [];
	}
	return [

		[11, 2, param.continuationToken],
		[8, 3, param.limit],
		[8, 4, Ob1_O0(param.productType)],
	];
}
List GetSubscriptionStatusRequest(LINEtypes.GetSubscriptionStatusRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[2, 1, param.includeOtherOwnedSubscriptions],
	];
}
List Ob1_C12630i0(LINEtypes.Ob1_C12630i0? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List GetSuggestResourcesV2Request(LINEtypes.GetSuggestResourcesV2Request? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Ob1_O0(param.productType)],
		[15, 2, [11, param.productIds]],
	];
}
List GetTaiwanBankBalanceRequest(LINEtypes.GetTaiwanBankBalanceRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.accessToken],
		[11, 2, param.authorizationCode],
		[11, 3, param.codeVerifier],
	];
}
List GetTargetProfileTarget(LINEtypes.GetTargetProfileTarget? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.targetUserMid],
	];
}
List GetTargetProfilesRequest(LINEtypes.GetTargetProfilesRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[15, 1, [
			12,
			param.targetUsers != null ? param.targetUsers.map((e) => GetTargetProfileTarget(e)).toList() : [],
		]],
		[8, 2, Pb1_V7(param.syncReason)],
	];
}
List NZ0_C12150a0(LINEtypes.NZ0_C12150a0? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List GetThaiBankBalanceRequest(LINEtypes.GetThaiBankBalanceRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.deviceId],
	];
}
List GetTotalCoinBalanceRequest(LINEtypes.GetTotalCoinBalanceRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, jO0_EnumC27533B(param.appStoreCode)],
	];
}
List ChannelIdWithLastUpdated(LINEtypes.ChannelIdWithLastUpdated? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.channelId],
		[10, 2, param.lastUpdated],
	];
}
List GetUserCollectionsRequest(LINEtypes.GetUserCollectionsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[10, 1, param.lastUpdatedTimeMillis],
		[2, 2, param.includeSummary],
		[8, 3, Ob1_O0(param.productType)],
	];
}
List GetUserVectorRequest(LINEtypes.GetUserVectorRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.majorVersion],
	];
}
List GetUsersMappedByProfileRequest(LINEtypes.GetUsersMappedByProfileRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.profileId],
		[8, 2, Pb1_V7(param.syncReason)],
	];
}
List InviteFriendsRequest(LINEtypes.InviteFriendsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.campaignId],
		[15, 2, [11, param.invitees]],
	];
}
List InviteIntoChatRequest(LINEtypes.InviteIntoChatRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.chatMid],
		[14, 3, [11, param.targetUserMids]],
	];
}
List IsProductForCollectionsRequest(LINEtypes.IsProductForCollectionsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Ob1_O0(param.productType)],
		[11, 2, param.productId],
	];
}
List IsStickerAvailableForCombinationStickerRequest(LINEtypes.IsStickerAvailableForCombinationStickerRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.packageId],
	];
}
List LiffViewRequest(LINEtypes.LiffViewRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.liffId],
		[12, 2, Qj_C13595l(param.context)],
		[11, 3, param.lang],
		[12, 4, LiffDeviceSetting(param.deviceSetting)],
		[11, 5, param.msit],
		[2, 6, param.subsequentLiff],
		[11, 7, param.domain],
	];
}
List IssueBirthdayGiftTokenRequest(LINEtypes.IssueBirthdayGiftTokenRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.recipientUserMid],
	];
}
List IssueV3TokenForPrimaryRequest(LINEtypes.IssueV3TokenForPrimaryRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.udid],
		[11, 2, param.systemDisplayName],
		[11, 3, param.modelName],
	];
}
List JoinChatByCallUrlRequest(LINEtypes.JoinChatByCallUrlRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.urlId],
		[8, 2, param.reqSeq],
	];
}
List KickoutFromGroupCallRequest(LINEtypes.KickoutFromGroupCallRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.chatMid],
		[15, 2, [11, param.targetMids]],
	];
}
List DeviceLinkRequest(LINEtypes.DeviceLinkRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.deviceId],
	];
}
List LookupAvailableEapRequest(LINEtypes.LookupAvailableEapRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
	];
}
List MapProfileToUsersRequest(LINEtypes.MapProfileToUsersRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.profileId],
		[15, 2, [11, param.targetMids]],
	];
}
List MigratePrimaryUsingQrCodeRequest(LINEtypes.MigratePrimaryUsingQrCodeRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.sessionId],
		[11, 2, param.nonce],
	];
}
List NotifyChatAdEntryRequest(LINEtypes.NotifyChatAdEntryRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.chatMid],
		[11, 2, param.scenarioId],
		[11, 3, param.sdata],
	];
}
dynamic do0_EnumC23148f(dynamic param) {
	if (param is int) {
		return LINEtypes.do0_EnumC23148f.fromValue(param);
	}
	return param;
}
dynamic do0_EnumC23147e(dynamic param) {
	if (param is int) {
		return LINEtypes.do0_EnumC23147e.fromValue(param);
	}
	return param;
}
List NotifyDeviceConnectionRequest(LINEtypes.NotifyDeviceConnectionRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.deviceId],
		[11, 2, param.connectionId],
		[8, 3, do0_EnumC23148f(param.connectionType)],
		[8, 4, do0_EnumC23147e(param.code)],
		[11, 5, param.errorReason],
		[10, 6, param.startTime],
		[10, 7, param.endTime],
	];
}
List NotifyDeviceDisconnectionRequest(LINEtypes.NotifyDeviceDisconnectionRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.deviceId],
		[11, 2, param.connectionId],
		[10, 4, param.disconnectedTime],
	];
}
dynamic kf_p(dynamic param) {
	if (param is int) {
		return LINEtypes.kf_p.fromValue(param);
	}
	return param;
}
dynamic kf_o(dynamic param) {
	if (param is int) {
		return LINEtypes.kf_o.fromValue(param);
	}
	return param;
}
List OATalkroomEventContext(LINEtypes.OATalkroomEventContext? param) {
	if (param == null) {
		return [];
	}
	return [
		[10, 1, param.timestampMillis],
		[11, 2, param.botMid],
		[11, 3, param.userMid],
		[8, 4, kf_o(param.os)],
		[11, 5, param.osVersion],
		[11, 6, param.appVersion],
		[11, 7, param.region],
	];
}
dynamic kf_u(dynamic param) {
	if (param is int) {
		return LINEtypes.kf_u.fromValue(param);
	}
	return param;
}
List RichmenuCoordinates(LINEtypes.RichmenuCoordinates? param) {
	if (param == null) {
		return [];
	}
	return [
		[4, 1, param.x],
		[4, 2, param.y],
	];
}
dynamic kf_r(dynamic param) {
	if (param is int) {
		return LINEtypes.kf_r.fromValue(param);
	}
	return param;
}
List RichmenuEvent(LINEtypes.RichmenuEvent? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, kf_u(param.type)],
		[11, 2, param.richmenuId],
		[12, 3, RichmenuCoordinates(param.coordinates)],
		[8, 4, param.areaIndex],
		[11, 5, param.clickUrl],
		[8, 6, kf_r(param.clickAction)],
	];
}
dynamic kf_x(dynamic param) {
	if (param is int) {
		return LINEtypes.kf_x.fromValue(param);
	}
	return param;
}
List kf_w(LINEtypes.kf_w? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List TalkroomEnterReferer(LINEtypes.TalkroomEnterReferer? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.urlScheme],
		[8, 2, kf_x(param.type)],
		[12, 3, kf_w(param.content)],
	];
}
List TalkroomEvent(LINEtypes.TalkroomEvent? param) {
	if (param == null) {
		return [];
	}
	return [

		[12, 2, TalkroomEnterReferer(param.referer)],
	];
}
List kf_m(LINEtypes.kf_m? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, RichmenuEvent(param.richmenu)],
		[12, 2, TalkroomEvent(param.talkroom)],
	];
}
List OATalkroomEvent(LINEtypes.OATalkroomEvent? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.eventId],
		[8, 2, kf_p(param.type)],
		[12, 3, OATalkroomEventContext(param.context)],
		[12, 4, kf_m(param.content)],
	];
}
List NotifyOATalkroomEventsRequest(LINEtypes.NotifyOATalkroomEventsRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[15, 1, [12, param.events != null ? param.events.map((e) => OATalkroomEvent(e)).toList() : []]],
	];
}
dynamic do0_G(dynamic param) {
	if (param is int) {
		return LINEtypes.do0_G.fromValue(param);
	}
	return param;
}
List do0_m0(LINEtypes.do0_m0? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List do0_C23143a(LINEtypes.do0_C23143a? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.bytes],
	];
}
List do0_C23142E(LINEtypes.do0_C23142E? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, do0_m0(param.voidResult)],
		[12, 2, do0_C23143a(param.binaryResult)],
	];
}
List do0_F(LINEtypes.do0_F? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.scenarioId],
		[11, 2, param.deviceId],
		[10, 3, param.revision],
		[10, 4, param.startTime],
		[10, 5, param.endTime],
		[8, 6, do0_G(param.code)],
		[11, 7, param.errorReason],
		[11, 8, param.bleNotificationPayload],
		[15, 9, [
			12,
			param.actionResults != null ? param.actionResults.map((e) => do0_C23142E(e)).toList() : [],
		]],
		[11, 10, param.connectionId],
	];
}
List NotifyScenarioExecutedRequest(LINEtypes.NotifyScenarioExecutedRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[15, 2, [
			12,
			param.scenarioResults != null ? param.scenarioResults.map((e) => do0_F(e)).toList() : [],
		]],
	];
}
dynamic ApplicationType(dynamic param) {
	if (param is int) {
		return LINEtypes.ApplicationType.fromValue(param);
	}
	return param;
}
List DeviceInfo(LINEtypes.DeviceInfo? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.deviceName],
		[11, 2, param.systemName],
		[11, 3, param.systemVersion],
		[11, 4, param.model],
		[11, 5, param.webViewVersion],
		[8, 10, CarrierCode(param.carrierCode)],
		[11, 11, param.carrierName],
		[8, 20, ApplicationType(param.applicationType)],
	];
}
List AuthSessionRequest(LINEtypes.AuthSessionRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[13, 1, [11, 11, param.metaData]],
	];
}
List OpenSessionRequest(LINEtypes.OpenSessionRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[13, 1, [11, 11, param.metaData]],
	];
}
List PermitLoginRequest(LINEtypes.PermitLoginRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.sessionId],
		[13, 2, [11, 11, param.metaData]],
	];
}
List Price(LINEtypes.Price? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.currency],
		[11, 2, param.amount],
		[11, 3, param.priceString],
	];
}
List PurchaseOrder(LINEtypes.PurchaseOrder? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.shopId],
		[11, 2, param.productId],
		[11, 5, param.recipientMid],
		[12, 11, Price(param.price)],
		[2, 12, param.enableLinePointAutoExchange],
		[12, 21, Locale(param.locale)],
		[13, 31, [11, 11, param.presentAttributes]],
	];
}
List PurchaseSubscriptionRequest(LINEtypes.PurchaseSubscriptionRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.billingItemId],

		[8, 3, Ob1_K1(param.storeCode)],
		[11, 4, param.storeOrderId],
		[2, 5, param.outsideAppPurchase],
		[2, 6, param.unavailableItemPurchase],
	];
}
List PutE2eeKeyRequest(LINEtypes.PutE2eeKeyRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.sessionId],
		[13, 2, [11, 11, param.e2eeKey]],
	];
}
List ReactRequest(LINEtypes.ReactRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[10, 2, param.messageId],
		[12, 3, ReactionType(param.reactionType)],
	];
}
List RefreshAccessTokenRequest(LINEtypes.RefreshAccessTokenRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.refreshToken],
	];
}
List RSAEncryptedPassword(LINEtypes.RSAEncryptedPassword? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.encrypted],
		[11, 2, param.keyName],
	];
}
List RegisterCampaignRewardRequest(LINEtypes.RegisterCampaignRewardRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.campaignId],
	];
}
List Pb1_C13097n4(LINEtypes.Pb1_C13097n4? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.version],
		[8, 2, param.keyId],
		[11, 4, param.keyData],
		[10, 5, param.createdTime],
	];
}
List Pb1_W6(LINEtypes.Pb1_W6? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[12, 2, Pb1_C13097n4(param.publicKey)],
		[11, 3, param.blobPayload],
	];
}
List RegisterPrimaryCredentialRequest(LINEtypes.RegisterPrimaryCredentialRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.sessionId],
	];
}
List ReissueChatTicketRequest(LINEtypes.ReissueChatTicketRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.groupMid],
	];
}
List RejectChatInvitationRequest(LINEtypes.RejectChatInvitationRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.chatMid],
	];
}
List RemoveFollowerRequest(LINEtypes.RemoveFollowerRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, Pb1_A4(param.followMid)],
	];
}
List RemoveFromFollowBlacklistRequest(LINEtypes.RemoveFromFollowBlacklistRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, Pb1_A4(param.followMid)],
	];
}
List RemoveItemFromCollectionRequest(LINEtypes.RemoveItemFromCollectionRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.collectionId],
		[11, 3, param.productId],
		[11, 4, param.itemId],
	];
}
List RemoveProductFromSubscriptionSlotRequest(LINEtypes.RemoveProductFromSubscriptionSlotRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Ob1_O0(param.productType)],
		[11, 2, param.productId],

		[14, 4, [11, param.productIds]],
	];
}
dynamic Pb1_EnumC13128p7(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_EnumC13128p7.fromValue(param);
	}
	return param;
}
List AbuseMessage(LINEtypes.AbuseMessage? param) {
	if (param == null) {
		return [];
	}
	return [
		[10, 1, param.messageId],
		[11, 2, param.message],
		[11, 3, param.senderMid],
		[8, 4, ContentType(param.contentType)],
		[10, 5, param.createdTime],
		[13, 6, [11, 11, param.metadata]],
	];
}
List AbuseReport(LINEtypes.AbuseReport? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Pb1_EnumC13128p7(param.reportSource)],
		[8, 2, ApplicationType(param.applicationType)],
		[15, 3, [8, param.spammerReasons]],
		[15, 4, [
			12,
			param.abuseMessages != null ? param.abuseMessages.map((e) => AbuseMessage(e)).toList() : [],
		]],
		[13, 5, [11, 11, param.metadata]],
	];
}
List EvidenceId(LINEtypes.EvidenceId? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.spaceId],
		[11, 2, param.objectId],
	];
}
List AbuseReportLineMeeting(LINEtypes.AbuseReportLineMeeting? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.reporteeMid],
		[15, 2, [8, param.spammerReasons]],
		[15, 3, [
			12,
			param.evidenceIds != null ? param.evidenceIds.map((e) => EvidenceId(e)).toList() : [],
		]],
		[11, 4, param.chatMid],
	];
}
List Pb1_C12938c(LINEtypes.Pb1_C12938c? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, AbuseReport(param.message)],
		[12, 2, AbuseReportLineMeeting(param.lineMeeting)],
	];
}
List ReportAbuseExRequest(LINEtypes.ReportAbuseExRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, Pb1_C12938c(param.abuseReportEntry)],
	];
}
List BeaconData(LINEtypes.BeaconData? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.hwid],
		[8, 2, param.rssi],
		[8, 3, param.txPower],
		[10, 4, param.scannedTimestampMs],
	];
}
List Geolocation(LINEtypes.Geolocation? param) {
	if (param == null) {
		return [];
	}
	return [
		[4, 1, param.longitude],
		[4, 2, param.latitude],
		[12, 3, GeolocationAccuracy(param.accuracy)],
		[4, 4, param.altitudeMeters],
		[4, 5, param.velocityMetersPerSecond],
		[4, 6, param.bearingDegrees],
		[15, 7, [
			12,
			param.beaconData != null ? param.beaconData.map((e) => BeaconData(e)).toList() : [],
		]],
	];
}
dynamic Pb1_EnumC12917a6(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_EnumC12917a6.fromValue(param);
	}
	return param;
}
dynamic Pb1_EnumC12998g3(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_EnumC12998g3.fromValue(param);
	}
	return param;
}
List WifiSignal(LINEtypes.WifiSignal? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.ssid],
		[11, 3, param.bssid],
		[11, 4, param.wifiStandard],
		[4, 5, param.frequency],
		[10, 10, param.lastSeenTimestamp],
		[8, 11, param.rssi],
	];
}
List ClientNetworkStatus(LINEtypes.ClientNetworkStatus? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Pb1_EnumC12998g3(param.networkType)],
		[15, 2, [
			12,
			param.wifiSignals != null ? param.wifiSignals.map((e) => WifiSignal(e)).toList() : [],
		]],
	];
}
dynamic Pb1_F6(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_F6.fromValue(param);
	}
	return param;
}
List PoiInfo(LINEtypes.PoiInfo? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.poiId],
		[8, 2, Pb1_F6(param.poiRealm)],
	];
}
List LocationDebugInfo(LINEtypes.LocationDebugInfo? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, PoiInfo(param.poiInfo)],
	];
}
List AvatarProfile(LINEtypes.AvatarProfile? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.version],
		[10, 2, param.updatedMillis],
		[11, 3, param.thumbnail],
		[2, 4, param.usablePublicly],
	];
}
dynamic Pb1_N6(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_N6.fromValue(param);
	}
	return param;
}
dynamic Pb1_O6(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_O6.fromValue(param);
	}
	return param;
}
List Profile(LINEtypes.Profile? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.mid],
		[11, 3, param.userid],
		[11, 10, param.phone],
		[11, 11, param.email],
		[11, 12, param.regionCode],
		[11, 20, param.displayName],
		[11, 21, param.phoneticName],
		[11, 22, param.pictureStatus],
		[11, 23, param.thumbnailUrl],
		[11, 24, param.statusMessage],
		[2, 31, param.allowSearchByUserid],
		[2, 32, param.allowSearchByEmail],
		[11, 33, param.picturePath],
		[11, 34, param.musicProfile],
		[11, 35, param.videoProfile],
		[13, 36, [11, 11, param.statusMessageContentMetadata]],
		[12, 37, AvatarProfile(param.avatarProfile)],
		[2, 38, param.nftProfile],
		[8, 39, Pb1_N6(param.pictureSource)],
		[11, 40, param.profileId],
		[8, 41, Pb1_O6(param.profileType)],
		[10, 42, param.createdTimeMillis],
	];
}
dynamic Pb1_EnumC13009h0(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_EnumC13009h0.fromValue(param);
	}
	return param;
}
List PushRecvReport(LINEtypes.PushRecvReport? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.pushTrackingId],
		[10, 2, param.recvTimestamp],
		[8, 3, param.battery],
		[8, 4, Pb1_EnumC13009h0(param.batteryMode)],
		[8, 5, Pb1_EnumC12998g3(param.clientNetworkType)],
		[11, 6, param.carrierCode],
		[10, 7, param.displayTimestamp],
	];
}
List ReportRefreshedAccessTokenRequest(LINEtypes.ReportRefreshedAccessTokenRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.accessToken],
	];
}
dynamic EmailConfirmationStatus(dynamic param) {
	if (param is int) {
		return LINEtypes.EmailConfirmationStatus.fromValue(param);
	}
	return param;
}
dynamic AccountMigrationPincodeType(dynamic param) {
	if (param is int) {
		return LINEtypes.AccountMigrationPincodeType.fromValue(param);
	}
	return param;
}
dynamic Pb1_I6(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_I6.fromValue(param);
	}
	return param;
}
dynamic Pb1_S7(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_S7.fromValue(param);
	}
	return param;
}
dynamic Pb1_M6(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_M6.fromValue(param);
	}
	return param;
}
dynamic Pb1_gd(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_gd.fromValue(param);
	}
	return param;
}
List Settings(LINEtypes.Settings? param) {
	if (param == null) {
		return [];
	}
	return [
		[2, 10, param.notificationEnable],
		[10, 11, param.notificationMuteExpiration],
		[2, 12, param.notificationNewMessage],
		[2, 13, param.notificationGroupInvitation],
		[2, 14, param.notificationShowMessage],
		[2, 15, param.notificationIncomingCall],
		[11, 16, param.notificationSoundMessage],
		[11, 17, param.notificationSoundGroup],
		[2, 18, param.notificationDisabledWithSub],
		[2, 19, param.notificationPayment],
		[2, 20, param.privacySyncContacts],
		[2, 21, param.privacySearchByPhoneNumber],
		[2, 22, param.privacySearchByUserid],
		[2, 23, param.privacySearchByEmail],
		[2, 24, param.privacyAllowSecondaryDeviceLogin],
		[2, 25, param.privacyProfileImagePostToMyhome],
		[2, 26, param.privacyReceiveMessagesFromNotFriend],
		[2, 27, param.privacyAgreeUseLineCoinToPaidCall],
		[2, 28, param.privacyAgreeUsePaidCall],
		[2, 29, param.privacyAllowFriendRequest],
		[11, 30, param.contactMyTicket],
		[8, 40, IdentityProvider(param.identityProvider)],
		[11, 41, param.identityIdentifier],
		[13, 42, [8, 11, param.snsAccounts]],
		[2, 43, param.phoneRegistration],
		[8, 44, EmailConfirmationStatus(param.emailConfirmationStatus)],
		[8, 45, AccountMigrationPincodeType(param.accountMigrationPincodeType)],
		[2, 46, param.enforcedInputAccountMigrationPincode],
		[8, 47, AccountMigrationPincodeType(param.securityCenterSettingsType)],
		[2, 48, param.allowUnregistrationSecondaryDevice],
		[2, 49, param.pwlessPrimaryCredentialRegistration],
		[11, 50, param.preferenceLocale],
		[13, 60, [8, 11, param.customModes]],
		[2, 61, param.e2eeEnable],
		[2, 62, param.hitokotoBackupRequested],
		[2, 63, param.privacyProfileMusicPostToMyhome],
		[2, 65, param.privacyAllowNearby],
		[10, 66, param.agreementNearbyTime],
		[10, 67, param.agreementSquareTime],
		[2, 68, param.notificationMention],
		[10, 69, param.botUseAgreementAcceptedAt],
		[10, 70, param.agreementShakeFunction],
		[10, 71, param.agreementMobileContactName],
		[2, 72, param.notificationThumbnail],
		[10, 73, param.agreementSoundToText],
		[11, 74, param.privacyPolicyVersion],
		[10, 75, param.agreementAdByWebAccess],
		[10, 76, param.agreementPhoneNumberMatching],
		[10, 77, param.agreementCommunicationInfo],
		[8, 78, Pb1_I6(param.privacySharePersonalInfoToFriends)],
		[10, 79, param.agreementThingsWirelessCommunication],
		[10, 80, param.agreementGdpr],
		[8, 81, Pb1_S7(param.privacyStatusMessageHistory)],
		[10, 82, param.agreementProvideLocation],
		[10, 83, param.agreementBeacon],
		[8, 85, Pb1_M6(param.privacyAllowProfileHistory)],
		[10, 86, param.agreementContentsSuggest],
		[10, 87, param.agreementContentsSuggestDataCollection],
		[8, 88, Pb1_gd(param.privacyAgeResult)],
		[2, 89, param.privacyAgeResultReceived],
		[10, 90, param.agreementOcrImageCollection],
		[2, 91, param.privacyAllowFollow],
		[2, 92, param.privacyShowFollowList],
		[2, 93, param.notificationBadgeTalkOnly],
		[10, 94, param.agreementIcna],
		[2, 95, param.notificationReaction],
		[10, 96, param.agreementMid],
		[2, 97, param.homeNotificationNewFriend],
		[2, 98, param.homeNotificationFavoriteFriendUpdate],
		[2, 99, param.homeNotificationGroupMemberUpdate],
		[2, 100, param.homeNotificationBirthday],
		[13, 101, [8, 2, param.eapAllowedToConnect]],
		[10, 102, param.agreementLineOutUse],
		[10, 103, param.agreementLineOutProvideInfo],
		[2, 104, param.notificationShowProfileImage],
		[10, 105, param.agreementPdpa],
		[11, 106, param.agreementLocationVersion],
		[2, 107, param.zhdPageAllowedToShow],
		[10, 108, param.agreementSnowAiAvatar],
		[2, 109, param.eapOnlyAccountTargetCountry],
		[10, 110, param.agreementLypPremiumAlbum],
		[10, 112, param.agreementLypPremiumAlbumVersion],
		[10, 113, param.agreementAlbumUsageData],
		[10, 114, param.agreementAlbumUsageDataVersion],
		[10, 115, param.agreementLypPremiumBackup],
		[10, 116, param.agreementLypPremiumBackupVersion],
		[10, 117, param.agreementOaAiAssistant],
		[10, 118, param.agreementOaAiAssistantVersion],
		[10, 119, param.agreementLypPremiumMultiProfile],
		[10, 120, param.agreementLypPremiumMultiProfileVersion],
	];
}
dynamic Pb1_od(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_od.fromValue(param);
	}
	return param;
}
dynamic T70_K(dynamic param) {
	if (param is int) {
		return LINEtypes.T70_K.fromValue(param);
	}
	return param;
}
List ReqToSendPhonePinCodeRequest(LINEtypes.ReqToSendPhonePinCodeRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
		[12, 2, UserPhoneNumber(param.userPhoneNumber)],
		[8, 3, T70_K(param.verifMethod)],
	];
}
dynamic r80_g0(dynamic param) {
	if (param is int) {
		return LINEtypes.r80_g0.fromValue(param);
	}
	return param;
}
List CoinPurchaseReservation(LINEtypes.CoinPurchaseReservation? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.productId],
		[11, 2, param.country],
		[11, 3, param.currency],
		[11, 4, param.price],
		[8, 5, jO0_EnumC27533B(param.appStoreCode)],
		[11, 6, param.language],
		[8, 7, jO0_EnumC27559z(param.pgCode)],
		[11, 8, param.redirectUrl],
	];
}
dynamic fN0_G(dynamic param) {
	if (param is int) {
		return LINEtypes.fN0_G.fromValue(param);
	}
	return param;
}
List ReserveSubscriptionPurchaseRequest(LINEtypes.ReserveSubscriptionPurchaseRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.billingItemId],
		[8, 2, fN0_G(param.storeCode)],
		[2, 3, param.addOaFriend],
		[11, 4, param.entryPoint],
		[11, 5, param.campaignId],
		[11, 6, param.invitationId],
	];
}
List ReserveRequest(LINEtypes.ReserveRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.uniqueKey],
	];
}
List Pb1_C13155r7(LINEtypes.Pb1_C13155r7? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.restoreClaim],
	];
}
List Pb1_C13183t7(LINEtypes.Pb1_C13183t7? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List RevokeTokensRequest(LINEtypes.RevokeTokensRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[15, 1, [11, param.accessTokens]],
	];
}
List StudentInformation(LINEtypes.StudentInformation? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.schoolName],
		[11, 2, param.graduationDate],
	];
}
List SaveStudentInformationRequest(LINEtypes.SaveStudentInformationRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, StudentInformation(param.studentInformation)],
	];
}
List SendEncryptedE2EEKeyRequest(LINEtypes.SendEncryptedE2EEKeyRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.sessionId],
	];
}
List SendPostbackRequest(LINEtypes.SendPostbackRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.messageId],
		[11, 2, param.url],
		[11, 3, param.chatMID],
		[11, 4, param.originMID],
	];
}
List SetChatHiddenStatusRequest(LINEtypes.SetChatHiddenStatusRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.chatMid],
		[10, 3, param.lastMessageId],
		[2, 4, param.hidden],
	];
}
List SetHashedPasswordRequest(LINEtypes.SetHashedPasswordRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
		[11, 2, param.password],
	];
}
List SetPasswordRequest(LINEtypes.SetPasswordRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.sessionId],
		[11, 2, param.hashedPassword],
	];
}
List Ob1_C12660s1(LINEtypes.Ob1_C12660s1? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List StartPhotoboothRequest(LINEtypes.StartPhotoboothRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.chatMid],
	];
}
List SIMInfo(LINEtypes.SIMInfo? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.phoneNumber],
		[11, 2, param.countryCode],
	];
}
List StopBundleSubscriptionRequest(LINEtypes.StopBundleSubscriptionRequest? param) {
	if (param == null) {
		return [];
	}
	return [

		[8, 2, Ob1_K1(param.storeCode)],
	];
}
dynamic Qj_e0(dynamic param) {
	if (param is int) {
		return LINEtypes.Qj_e0.fromValue(param);
	}
	return param;
}
List ShareTargetPickerResultRequest(LINEtypes.ShareTargetPickerResultRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.ott],
		[11, 2, param.liffId],
		[8, 3, Qj_e0(param.resultCode)],
		[11, 4, param.resultDescription],
	];
}
List SubWindowResultRequest(LINEtypes.SubWindowResultRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.msit],
		[11, 2, param.mstVerifier],
	];
}
dynamic Pb1_EnumC13029i6(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_EnumC13029i6.fromValue(param);
	}
	return param;
}
List ContactModification(LINEtypes.ContactModification? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Pb1_EnumC13029i6(param.type)],
		[11, 2, param.luid],
		[15, 11, [11, param.phones]],
		[15, 12, [11, param.emails]],
		[15, 13, [11, param.userids]],
		[11, 14, param.mobileContactName],
		[11, 15, param.phoneticName],
	];
}
dynamic Pb1_J4(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_J4.fromValue(param);
	}
	return param;
}
List SyncRequest(LINEtypes.SyncRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[10, 1, param.lastRevision],
		[8, 2, param.count],
		[10, 3, param.lastGlobalRevision],
		[10, 4, param.lastIndividualRevision],
		[8, 5, Pb1_J4(param.fullSyncRequestReason)],
		[13, 6, [8, 10, param.lastPartialFullSyncs]],
	];
}
dynamic Pb1_G4(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_G4.fromValue(param);
	}
	return param;
}
List UnfollowRequest(LINEtypes.UnfollowRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, Pb1_A4(param.followMid)],
	];
}
List DeviceUnlinkRequest(LINEtypes.DeviceUnlinkRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.deviceId],
	];
}
List ChannelNotificationSetting(LINEtypes.ChannelNotificationSetting? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.channelId],
		[11, 2, param.name],
		[2, 3, param.notificationReceivable],
		[2, 4, param.messageReceivable],
		[2, 5, param.showDefault],
	];
}
List ChannelSettings(LINEtypes.ChannelSettings? param) {
	if (param == null) {
		return [];
	}
	return [
		[2, 1, param.unapprovedMessageReceivable],
	];
}
List GroupExtra(LINEtypes.GroupExtra? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.creator],
		[2, 2, param.preventedJoinByTicket],
		[11, 3, param.invitationTicket],
		[13, 4, [11, 10, param.memberMids]],
		[13, 5, [11, 10, param.inviteeMids]],
		[2, 6, param.addFriendDisabled],
		[2, 7, param.ticketDisabled],
		[2, 8, param.autoName],
	];
}
List Pb1_A6(LINEtypes.Pb1_A6? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List Pb1_C13208v4(LINEtypes.Pb1_C13208v4? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GroupExtra(param.groupExtra)],
		[12, 2, Pb1_A6(param.peerExtra)],
	];
}
List Chat(LINEtypes.Chat? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Pb1_Z2(param.type)],
		[11, 2, param.chatMid],
		[10, 3, param.createdTime],
		[2, 4, param.notificationDisabled],
		[10, 5, param.favoriteTimestamp],
		[11, 6, param.chatName],
		[11, 7, param.picturePath],
		[12, 8, Pb1_C13208v4(param.extra)],
	];
}
dynamic Pb1_O2(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_O2.fromValue(param);
	}
	return param;
}
List UpdateChatRequest(LINEtypes.UpdateChatRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[12, 2, Chat(param.chat)],
		[8, 3, Pb1_O2(param.updatedAttribute)],
	];
}
dynamic ContactSetting(dynamic param) {
	if (param is int) {
		return LINEtypes.ContactSetting.fromValue(param);
	}
	return param;
}
dynamic Pb1_H6(dynamic param) {
	if (param is int) {
		return LINEtypes.Pb1_H6.fromValue(param);
	}
	return param;
}
List ExtendedProfileBirthday(LINEtypes.ExtendedProfileBirthday? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.year],
		[8, 2, Pb1_H6(param.yearPrivacyLevelType)],
		[2, 3, param.yearEnabled],
		[11, 5, param.day],
		[8, 6, Pb1_H6(param.dayPrivacyLevelType)],
		[2, 7, param.dayEnabled],
	];
}
List ExtendedProfile(LINEtypes.ExtendedProfile? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ExtendedProfileBirthday(param.birthday)],
	];
}
List Pb1_ad(LINEtypes.Pb1_ad? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.title],
	];
}
List UpdateGroupCallUrlRequest(LINEtypes.UpdateGroupCallUrlRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.urlId],
		[12, 2, Pb1_ad(param.targetAttribute)],
	];
}
dynamic NotificationType(dynamic param) {
	if (param is int) {
		return LINEtypes.NotificationType.fromValue(param);
	}
	return param;
}
List UpdatePasswordRequest(LINEtypes.UpdatePasswordRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.sessionId],
		[11, 2, param.hashedPassword],
	];
}
List ProfileContent(LINEtypes.ProfileContent? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.value],
		[13, 2, [11, 11, param.meta]],
	];
}
List UpdateProfileAttributesRequest(LINEtypes.UpdateProfileAttributesRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[13, 1, [8, 12, map(ProfileContent, param.profileAttributes)]],
	];
}
dynamic vh_m(dynamic param) {
	if (param is int) {
		return LINEtypes.vh_m.fromValue(param);
	}
	return param;
}
List UpdateSafetyStatusRequest(LINEtypes.UpdateSafetyStatusRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.disasterId],
		[8, 2, vh_m(param.safetyStatus)],
		[11, 3, param.message],
	];
}
List UsePhotoboothTicketRequest(LINEtypes.UsePhotoboothTicketRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.chatMid],
		[11, 2, param.photoboothSessionId],
	];
}
dynamic r80_EnumC34376p(dynamic param) {
	if (param is int) {
		return LINEtypes.r80_EnumC34376p.fromValue(param);
	}
	return param;
}
List VerifyAccountUsingHashedPwdRequest(LINEtypes.VerifyAccountUsingHashedPwdRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
		[12, 2, AccountIdentifier(param.accountIdentifier)],
		[11, 3, param.v1HashedPassword],
		[11, 4, param.clientHashedPassword],
	];
}
List VerifyAssertionRequest(LINEtypes.VerifyAssertionRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.sessionId],
		[11, 2, param.credentialId],
		[11, 3, param.assertionObject],
		[11, 4, param.clientDataJSON],
	];
}
List VerifyAttestationRequest(LINEtypes.VerifyAttestationRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.sessionId],
		[11, 2, param.attestationObject],
		[11, 3, param.clientDataJSON],
	];
}
List BirthdayGiftAssociationVerifyRequest(LINEtypes.BirthdayGiftAssociationVerifyRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.associationToken],
	];
}
dynamic T70_j1(dynamic param) {
	if (param is int) {
		return LINEtypes.T70_j1.fromValue(param);
	}
	return param;
}
List SocialLogin(LINEtypes.SocialLogin? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, T70_j1(param.type)],
		[11, 2, param.accessToken],
		[11, 3, param.countryCode],
	];
}
dynamic a80_EnumC16644b(dynamic param) {
	if (param is int) {
		return LINEtypes.a80_EnumC16644b.fromValue(param);
	}
	return param;
}
List EapLogin(LINEtypes.EapLogin? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, a80_EnumC16644b(param.type as LINEtypes.a80_EnumC16644b)],
		[11, 2, param.accessToken],
		[11, 3, param.countryCode],
	];
}
List VerifyEapLoginRequest(LINEtypes.VerifyEapLoginRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
		[12, 2, EapLogin(param.eapLogin)],
	];
}
List VerifyPhonePinCodeRequest(LINEtypes.VerifyPhonePinCodeRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
		[12, 2, UserPhoneNumber(param.userPhoneNumber)],
		[11, 3, param.pinCode],
	];
}
List VerifyPinCodeRequest(LINEtypes.VerifyPinCodeRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.pinCode],
	];
}
List VerifyQrCodeRequest(LINEtypes.VerifyQrCodeRequest? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
		[13, 2, [11, 11, param.metaData]],
	];
}
List acceptChatInvitationByTicket_args(LINEtypes.acceptChatInvitationByTicket_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, AcceptChatInvitationByTicketRequest(param.request)],
	];
}
List acceptChatInvitation_args(LINEtypes.acceptChatInvitation_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, AcceptChatInvitationRequest(param.request)],
	];
}
List SquareService_acceptSpeakers_args(LINEtypes.SquareService_acceptSpeakers_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, AcceptSpeakersRequest(param.request)],
	];
}
List SquareService_acceptToChangeRole_args(LINEtypes.SquareService_acceptToChangeRole_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, AcceptToChangeRoleRequest(param.request)],
	];
}
List SquareService_acceptToListen_args(LINEtypes.SquareService_acceptToListen_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, AcceptToListenRequest(param.request)],
	];
}
List SquareService_acceptToSpeak_args(LINEtypes.SquareService_acceptToSpeak_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, AcceptToSpeakRequest(param.request)],
	];
}
List SquareService_acquireLiveTalk_args(LINEtypes.SquareService_acquireLiveTalk_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, AcquireLiveTalkRequest(param.request)],
	];
}
List SquareService_cancelToSpeak_args(LINEtypes.SquareService_cancelToSpeak_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, CancelToSpeakRequest(param.request)],
	];
}
List SquareService_fetchLiveTalkEvents_args(LINEtypes.SquareService_fetchLiveTalkEvents_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, FetchLiveTalkEventsRequest(param.request)],
	];
}
List SquareService_findLiveTalkByInvitationTicket_args(LINEtypes.SquareService_findLiveTalkByInvitationTicket_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, FindLiveTalkByInvitationTicketRequest(param.request)],
	];
}
List SquareService_forceEndLiveTalk_args(LINEtypes.SquareService_forceEndLiveTalk_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ForceEndLiveTalkRequest(param.request)],
	];
}
List SquareService_getLiveTalkInfoForNonMember_args(LINEtypes.SquareService_getLiveTalkInfoForNonMember_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetLiveTalkInfoForNonMemberRequest(param.request)],
	];
}
List SquareService_getLiveTalkInvitationUrl_args(LINEtypes.SquareService_getLiveTalkInvitationUrl_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetLiveTalkInvitationUrlRequest(param.request)],
	];
}
List SquareService_getLiveTalkSpeakersForNonMember_args(LINEtypes.SquareService_getLiveTalkSpeakersForNonMember_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetLiveTalkSpeakersForNonMemberRequest(param.request)],
	];
}
List SquareService_getSquareInfoByChatMid_args(LINEtypes.SquareService_getSquareInfoByChatMid_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareInfoByChatMidRequest(param.request)],
	];
}
List SquareService_inviteToChangeRole_args(LINEtypes.SquareService_inviteToChangeRole_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, InviteToChangeRoleRequest(param.request)],
	];
}
List SquareService_inviteToListen_args(LINEtypes.SquareService_inviteToListen_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, InviteToListenRequest(param.request)],
	];
}
List SquareService_inviteToLiveTalk_args(LINEtypes.SquareService_inviteToLiveTalk_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, InviteToLiveTalkRequest(param.request)],
	];
}
List SquareService_inviteToSpeak_args(LINEtypes.SquareService_inviteToSpeak_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, InviteToSpeakRequest(param.request)],
	];
}
List SquareService_joinLiveTalk_args(LINEtypes.SquareService_joinLiveTalk_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, JoinLiveTalkRequest(param.request)],
	];
}
List SquareService_kickOutLiveTalkParticipants_args(LINEtypes.SquareService_kickOutLiveTalkParticipants_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, KickOutLiveTalkParticipantsRequest(param.request)],
	];
}
List SquareService_rejectSpeakers_args(LINEtypes.SquareService_rejectSpeakers_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, RejectSpeakersRequest(param.request)],
	];
}
List SquareService_rejectToSpeak_args(LINEtypes.SquareService_rejectToSpeak_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, RejectToSpeakRequest(param.request)],
	];
}
List SquareService_removeLiveTalkSubscription_args(LINEtypes.SquareService_removeLiveTalkSubscription_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, RemoveLiveTalkSubscriptionRequest(param.request)],
	];
}
List SquareService_reportLiveTalk_args(LINEtypes.SquareService_reportLiveTalk_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ReportLiveTalkRequest(param.request)],
	];
}
List SquareService_reportLiveTalkSpeaker_args(LINEtypes.SquareService_reportLiveTalkSpeaker_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ReportLiveTalkSpeakerRequest(param.request)],
	];
}
List SquareService_requestToListen_args(LINEtypes.SquareService_requestToListen_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, RequestToListenRequest(param.request)],
	];
}
List SquareService_requestToSpeak_args(LINEtypes.SquareService_requestToSpeak_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, RequestToSpeakRequest(param.request)],
	];
}
List SquareService_updateLiveTalkAttrs_args(LINEtypes.SquareService_updateLiveTalkAttrs_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, UpdateLiveTalkAttrsRequest(param.request)],
	];
}
List acquireCallRoute_args(LINEtypes.acquireCallRoute_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.to],
		[8, 3, Pb1_D4(param.callType)],
		[13, 4, [11, 11, param.fromEnvInfo]],
	];
}
List acquireEncryptedAccessToken_args(LINEtypes.acquireEncryptedAccessToken_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 2, Pb1_EnumC13222w4(param.featureType)],
	];
}
List acquireGroupCallRoute_args(LINEtypes.acquireGroupCallRoute_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.chatMid],
		[8, 3, Pb1_EnumC13237x5(param.mediaType)],
		[2, 4, param.isInitialHost],
		[15, 5, [11, param.capabilities]],
	];
}
List acquireOACallRoute_args(LINEtypes.acquireOACallRoute_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, AcquireOACallRouteRequest(param.request)],
	];
}
List acquirePaidCallRoute_args(LINEtypes.acquirePaidCallRoute_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 2, PaidCallType(param.paidCallType)],
		[11, 3, param.dialedNumber],
		[11, 4, param.language],
		[11, 5, param.networkCode],
		[2, 6, param.disableCallerId],
		[11, 7, param.referer],
		[11, 8, param.adSessionId],
	];
}
List activateSubscription_args(LINEtypes.activateSubscription_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ActivateSubscriptionRequest(param.request)],
	];
}
List adTypeOptOutClickEvent_args(LINEtypes.adTypeOptOutClickEvent_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, AdTypeOptOutClickEventRequest(param.request)],
	];
}
List addFriendByMid_args(LINEtypes.addFriendByMid_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, AddFriendByMidRequest(param.request)],
	];
}
List addItemToCollection_args(LINEtypes.addItemToCollection_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, AddItemToCollectionRequest(param.request)],
	];
}
List addOaFriend_args(LINEtypes.addOaFriend_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, NZ0_C12155c(param.request)],
	];
}
List addProductToSubscriptionSlot_args(LINEtypes.addProductToSubscriptionSlot_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, AddProductToSubscriptionSlotRequest(param.req)],
	];
}
List addThemeToSubscriptionSlot_args(LINEtypes.addThemeToSubscriptionSlot_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, AddThemeToSubscriptionSlotRequest(param.req)],
	];
}
List addToFollowBlacklist_args(LINEtypes.addToFollowBlacklist_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, AddToFollowBlacklistRequest(param.addToFollowBlacklistRequest)],
	];
}
List SquareService_agreeToTerms_args(LINEtypes.SquareService_agreeToTerms_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, AgreeToTermsRequest(param.request)],
	];
}
List SquareService_approveSquareMembers_args(LINEtypes.SquareService_approveSquareMembers_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ApproveSquareMembersRequest(param.request)],
	];
}
List SquareService_checkJoinCode_args(LINEtypes.SquareService_checkJoinCode_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, CheckJoinCodeRequest(param.request)],
	];
}
List SquareService_createSquareChatAnnouncement_args(LINEtypes.SquareService_createSquareChatAnnouncement_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[
			12,
			1,
			CreateSquareChatAnnouncementRequest(
				param.createSquareChatAnnouncementRequest,
			),
		],
	];
}
List SquareService_createSquareChat_args(LINEtypes.SquareService_createSquareChat_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, CreateSquareChatRequest(param.request)],
	];
}
List SquareService_createSquare_args(LINEtypes.SquareService_createSquare_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, CreateSquareRequest(param.request)],
	];
}
List SquareService_deleteSquareChatAnnouncement_args(LINEtypes.SquareService_deleteSquareChatAnnouncement_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[
			12,
			1,
			DeleteSquareChatAnnouncementRequest(
				param.deleteSquareChatAnnouncementRequest,
			),
		],
	];
}
List SquareService_deleteSquareChat_args(LINEtypes.SquareService_deleteSquareChat_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, DeleteSquareChatRequest(param.request)],
	];
}
List SquareService_deleteSquare_args(LINEtypes.SquareService_deleteSquare_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, DeleteSquareRequest(param.request)],
	];
}
List SquareService_destroyMessage_args(LINEtypes.SquareService_destroyMessage_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, DestroyMessageRequest(param.request)],
	];
}
List SquareService_destroyMessages_args(LINEtypes.SquareService_destroyMessages_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, DestroyMessagesRequest(param.request)],
	];
}
List SquareService_fetchMyEvents_args(LINEtypes.SquareService_fetchMyEvents_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, FetchMyEventsRequest(param.request)],
	];
}
List SquareService_fetchSquareChatEvents_args(LINEtypes.SquareService_fetchSquareChatEvents_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, FetchSquareChatEventsRequest(param.request)],
	];
}
List SquareService_findSquareByEmid_args(LINEtypes.SquareService_findSquareByEmid_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, FindSquareByEmidRequest(param.findSquareByEmidRequest)],
	];
}
List SquareService_findSquareByInvitationTicket_args(LINEtypes.SquareService_findSquareByInvitationTicket_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, FindSquareByInvitationTicketRequest(param.request)],
	];
}
List SquareService_findSquareByInvitationTicketV2_args(LINEtypes.SquareService_findSquareByInvitationTicketV2_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, FindSquareByInvitationTicketV2Request(param.request)],
	];
}
List SquareService_getGoogleAdOptions_args(LINEtypes.SquareService_getGoogleAdOptions_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetGoogleAdOptionsRequest(param.request)],
	];
}
List SquareService_getInvitationTicketUrl_args(LINEtypes.SquareService_getInvitationTicketUrl_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetInvitationTicketUrlRequest(param.request)],
	];
}
List SquareService_getJoinableSquareChats_args(LINEtypes.SquareService_getJoinableSquareChats_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetJoinableSquareChatsRequest(param.request)],
	];
}
List SquareService_getJoinedSquareChats_args(LINEtypes.SquareService_getJoinedSquareChats_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetJoinedSquareChatsRequest(param.request)],
	];
}
List SquareService_getJoinedSquares_args(LINEtypes.SquareService_getJoinedSquares_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetJoinedSquaresRequest(param.request)],
	];
}
List SquareService_getMessageReactions_args(LINEtypes.SquareService_getMessageReactions_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetMessageReactionsRequest(param.request)],
	];
}
List SquareService_getNoteStatus_args(LINEtypes.SquareService_getNoteStatus_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetNoteStatusRequest(param.request)],
	];
}
List SquareService_getPopularKeywords_args(LINEtypes.SquareService_getPopularKeywords_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetPopularKeywordsRequest(param.request)],
	];
}
List SquareService_getSquareAuthorities_args(LINEtypes.SquareService_getSquareAuthorities_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareAuthoritiesRequest(param.request)],
	];
}
List SquareService_getSquareAuthority_args(LINEtypes.SquareService_getSquareAuthority_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareAuthorityRequest(param.request)],
	];
}
List SquareService_getCategories_args(LINEtypes.SquareService_getCategories_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareCategoriesRequest(param.request)],
	];
}
List SquareService_getSquareChatAnnouncements_args(LINEtypes.SquareService_getSquareChatAnnouncements_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[
			12,
			1,
			GetSquareChatAnnouncementsRequest(
				param.getSquareChatAnnouncementsRequest,
			),
		],
	];
}
List SquareService_getSquareChatEmid_args(LINEtypes.SquareService_getSquareChatEmid_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareChatEmidRequest(param.request)],
	];
}
List SquareService_getSquareChatFeatureSet_args(LINEtypes.SquareService_getSquareChatFeatureSet_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareChatFeatureSetRequest(param.request)],
	];
}
List SquareService_getSquareChatMember_args(LINEtypes.SquareService_getSquareChatMember_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareChatMemberRequest(param.request)],
	];
}
List SquareService_getSquareChatMembers_args(LINEtypes.SquareService_getSquareChatMembers_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareChatMembersRequest(param.request)],
	];
}
List SquareService_getSquareChat_args(LINEtypes.SquareService_getSquareChat_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareChatRequest(param.request)],
	];
}
List SquareService_getSquareChatStatus_args(LINEtypes.SquareService_getSquareChatStatus_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareChatStatusRequest(param.request)],
	];
}
List SquareService_getSquareEmid_args(LINEtypes.SquareService_getSquareEmid_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareEmidRequest(param.request)],
	];
}
List SquareService_getSquareFeatureSet_args(LINEtypes.SquareService_getSquareFeatureSet_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareFeatureSetRequest(param.request)],
	];
}
List SquareService_getSquareMemberRelation_args(LINEtypes.SquareService_getSquareMemberRelation_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareMemberRelationRequest(param.request)],
	];
}
List SquareService_getSquareMemberRelations_args(LINEtypes.SquareService_getSquareMemberRelations_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareMemberRelationsRequest(param.request)],
	];
}
List SquareService_getSquareMember_args(LINEtypes.SquareService_getSquareMember_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareMemberRequest(param.request)],
	];
}
List SquareService_getSquareMembersBySquare_args(LINEtypes.SquareService_getSquareMembersBySquare_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareMembersBySquareRequest(param.request)],
	];
}
List SquareService_getSquareMembers_args(LINEtypes.SquareService_getSquareMembers_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareMembersRequest(param.request)],
	];
}
List SquareService_getSquare_args(LINEtypes.SquareService_getSquare_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareRequest(param.request)],
	];
}
List SquareService_getSquareStatus_args(LINEtypes.SquareService_getSquareStatus_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareStatusRequest(param.request)],
	];
}
List SquareService_getSquareThreadMid_args(LINEtypes.SquareService_getSquareThreadMid_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareThreadMidRequest(param.request)],
	];
}
List SquareService_getSquareThread_args(LINEtypes.SquareService_getSquareThread_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareThreadRequest(param.request)],
	];
}
List SquareService_getUserSettings_args(LINEtypes.SquareService_getUserSettings_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetUserSettingsRequest(param.request)],
	];
}
List SquareService_hideSquareMemberContents_args(LINEtypes.SquareService_hideSquareMemberContents_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, HideSquareMemberContentsRequest(param.request)],
	];
}
List SquareService_inviteIntoSquareChat_args(LINEtypes.SquareService_inviteIntoSquareChat_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, InviteIntoSquareChatRequest(param.request)],
	];
}
List SquareService_inviteToSquare_args(LINEtypes.SquareService_inviteToSquare_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, InviteToSquareRequest(param.request)],
	];
}
List SquareService_joinSquareChat_args(LINEtypes.SquareService_joinSquareChat_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, JoinSquareChatRequest(param.request)],
	];
}
List SquareService_joinSquare_args(LINEtypes.SquareService_joinSquare_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, JoinSquareRequest(param.request)],
	];
}
List SquareService_joinSquareThread_args(LINEtypes.SquareService_joinSquareThread_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, JoinSquareThreadRequest(param.request)],
	];
}
List SquareService_leaveSquareChat_args(LINEtypes.SquareService_leaveSquareChat_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, LeaveSquareChatRequest(param.request)],
	];
}
List SquareService_leaveSquare_args(LINEtypes.SquareService_leaveSquare_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, LeaveSquareRequest(param.request)],
	];
}
List SquareService_leaveSquareThread_args(LINEtypes.SquareService_leaveSquareThread_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, LeaveSquareThreadRequest(param.request)],
	];
}
List SquareService_manualRepair_args(LINEtypes.SquareService_manualRepair_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ManualRepairRequest(param.request)],
	];
}
List SquareService_markAsRead_args(LINEtypes.SquareService_markAsRead_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, MarkAsReadRequest(param.request)],
	];
}
List SquareService_markChatsAsRead_args(LINEtypes.SquareService_markChatsAsRead_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, MarkChatsAsReadRequest(param.request)],
	];
}
List SquareService_markThreadsAsRead_args(LINEtypes.SquareService_markThreadsAsRead_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, MarkThreadsAsReadRequest(param.request)],
	];
}
List SquareService_reactToMessage_args(LINEtypes.SquareService_reactToMessage_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ReactToMessageRequest(param.request)],
	];
}
List SquareService_refreshSubscriptions_args(LINEtypes.SquareService_refreshSubscriptions_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, RefreshSubscriptionsRequest(param.request)],
	];
}
List SquareService_rejectSquareMembers_args(LINEtypes.SquareService_rejectSquareMembers_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, RejectSquareMembersRequest(param.request)],
	];
}
List SquareService_removeSubscriptions_args(LINEtypes.SquareService_removeSubscriptions_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, RemoveSubscriptionsRequest(param.request)],
	];
}
List SquareService_reportMessageSummary_args(LINEtypes.SquareService_reportMessageSummary_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ReportMessageSummaryRequest(param.request)],
	];
}
List SquareService_reportSquareChat_args(LINEtypes.SquareService_reportSquareChat_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ReportSquareChatRequest(param.request)],
	];
}
List SquareService_reportSquareMember_args(LINEtypes.SquareService_reportSquareMember_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ReportSquareMemberRequest(param.request)],
	];
}
List SquareService_reportSquareMessage_args(LINEtypes.SquareService_reportSquareMessage_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ReportSquareMessageRequest(param.request)],
	];
}
List SquareService_reportSquare_args(LINEtypes.SquareService_reportSquare_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ReportSquareRequest(param.request)],
	];
}
List SquareService_searchSquareChatMembers_args(LINEtypes.SquareService_searchSquareChatMembers_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, SearchSquareChatMembersRequest(param.request)],
	];
}
List SquareService_searchSquareChatMentionables_args(LINEtypes.SquareService_searchSquareChatMentionables_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, SearchSquareChatMentionablesRequest(param.request)],
	];
}
List SquareService_searchSquareMembers_args(LINEtypes.SquareService_searchSquareMembers_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, SearchSquareMembersRequest(param.request)],
	];
}
List SquareService_searchSquares_args(LINEtypes.SquareService_searchSquares_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, SearchSquaresRequest(param.request)],
	];
}
List SquareService_sendMessage_args(LINEtypes.SquareService_sendMessage_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, SendMessageRequest(param.request)],
	];
}
List SquareService_sendSquareThreadMessage_args(LINEtypes.SquareService_sendSquareThreadMessage_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, SendSquareThreadMessageRequest(param.request)],
	];
}
List SquareService_syncSquareMembers_args(LINEtypes.SquareService_syncSquareMembers_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, SyncSquareMembersRequest(param.request)],
	];
}
List SquareService_unhideSquareMemberContents_args(LINEtypes.SquareService_unhideSquareMemberContents_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, UnhideSquareMemberContentsRequest(param.request)],
	];
}
List SquareService_unsendMessage_args(LINEtypes.SquareService_unsendMessage_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, UnsendMessageRequest(param.request)],
	];
}
List SquareService_updateSquareAuthority_args(LINEtypes.SquareService_updateSquareAuthority_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, UpdateSquareAuthorityRequest(param.request)],
	];
}
List SquareService_updateSquareChatMember_args(LINEtypes.SquareService_updateSquareChatMember_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, UpdateSquareChatMemberRequest(param.request)],
	];
}
List SquareService_updateSquareChat_args(LINEtypes.SquareService_updateSquareChat_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, UpdateSquareChatRequest(param.request)],
	];
}
List SquareService_updateSquareFeatureSet_args(LINEtypes.SquareService_updateSquareFeatureSet_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, UpdateSquareFeatureSetRequest(param.request)],
	];
}
List SquareService_updateSquareMemberRelation_args(LINEtypes.SquareService_updateSquareMemberRelation_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, UpdateSquareMemberRelationRequest(param.request)],
	];
}
List SquareService_updateSquareMember_args(LINEtypes.SquareService_updateSquareMember_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, UpdateSquareMemberRequest(param.request)],
	];
}
List SquareService_updateSquareMembers_args(LINEtypes.SquareService_updateSquareMembers_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, UpdateSquareMembersRequest(param.request)],
	];
}
List SquareService_updateSquare_args(LINEtypes.SquareService_updateSquare_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, UpdateSquareRequest(param.request)],
	];
}
List SquareService_updateUserSettings_args(LINEtypes.SquareService_updateUserSettings_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, UpdateUserSettingsRequest(param.request)],
	];
}
List approveChannelAndIssueChannelToken_args(LINEtypes.approveChannelAndIssueChannelToken_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.channelId],
	];
}
List authenticateUsingBankAccountEx_args(LINEtypes.authenticateUsingBankAccountEx_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, r80_EnumC34362b(param.type)],
		[11, 2, param.bankId],
		[11, 3, param.bankBranchId],
		[11, 4, param.realAccountNo],
		[8, 5, r80_EnumC34361a(param.accountProductCode)],
		[11, 6, param.authToken],
	];
}
List authenticateWithPaak_args(LINEtypes.authenticateWithPaak_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, AuthenticateWithPaakRequest(param.request)],
	];
}
List blockContact_args(LINEtypes.blockContact_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.id],
	];
}
List blockRecommendation_args(LINEtypes.blockRecommendation_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.targetMid],
	];
}
List bulkFollow_args(LINEtypes.bulkFollow_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, BulkFollowRequest(param.bulkFollowRequest)],
	];
}
List bulkGetSetting_args(LINEtypes.bulkGetSetting_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, BulkGetRequest(param.request)],
	];
}
List bulkSetSetting_args(LINEtypes.bulkSetSetting_args? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List buyMustbuyProduct_args(LINEtypes.buyMustbuyProduct_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, BuyMustbuyRequest(param.request)],
	];
}
List canCreateCombinationSticker_args(LINEtypes.canCreateCombinationSticker_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, CanCreateCombinationStickerRequest(param.request)],
	];
}
List canReceivePresent_args(LINEtypes.canReceivePresent_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.shopId],
		[11, 3, param.productId],
		[12, 4, Locale(param.locale)],
		[11, 5, param.recipientMid],
	];
}
List cancelChatInvitation_args(LINEtypes.cancelChatInvitation_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, CancelChatInvitationRequest(param.request)],
	];
}
List cancelPaakAuth_args(LINEtypes.cancelPaakAuth_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, CancelPaakAuthRequest(param.request)],
	];
}
List cancelPaakAuthentication_args(LINEtypes.cancelPaakAuthentication_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, CancelPaakAuthenticationRequest(param.request)],
	];
}
List cancelPinCode_args(LINEtypes.cancelPinCode_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, CancelPinCodeRequest(param.request)],
	];
}
List cancelReaction_args(LINEtypes.cancelReaction_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, CancelReactionRequest(param.cancelReactionRequest)],
	];
}
List changeSubscription_args(LINEtypes.changeSubscription_args? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List changeVerificationMethod_args(LINEtypes.changeVerificationMethod_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.sessionId],
		[8, 3, VerificationMethod(param.method)],
	];
}
List checkCanUnregisterEx_args(LINEtypes.checkCanUnregisterEx_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, r80_n0(param.type)],
	];
}
List checkEmailAssigned_args(LINEtypes.checkEmailAssigned_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
		[12, 2, AccountIdentifier(param.accountIdentifier)],
	];
}
List checkIfEncryptedE2EEKeyReceived_args(LINEtypes.checkIfEncryptedE2EEKeyReceived_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, CheckIfEncryptedE2EEKeyReceivedRequest(param.request)],
	];
}
List checkIfPasswordSetVerificationEmailVerified_args(LINEtypes.checkIfPasswordSetVerificationEmailVerified_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
	];
}
List checkIfPhonePinCodeMsgVerified_args(LINEtypes.checkIfPhonePinCodeMsgVerified_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, CheckIfPhonePinCodeMsgVerifiedRequest(param.request)],
	];
}
List checkOperationTimeEx_args(LINEtypes.checkOperationTimeEx_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, r80_EnumC34368h(param.type)],
		[11, 2, param.lpAccountNo],
		[8, 3, r80_EnumC34371k(param.channelType)],
	];
}
List checkUserAgeAfterApprovalWithDocomoV2_args(LINEtypes.checkUserAgeAfterApprovalWithDocomoV2_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, CheckUserAgeAfterApprovalWithDocomoV2Request(param.request)],
	];
}
List checkUserAgeWithDocomoV2_args(LINEtypes.checkUserAgeWithDocomoV2_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, CheckUserAgeWithDocomoV2Request(param.request)],
	];
}
List checkUserAge_args(LINEtypes.checkUserAge_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 2, CarrierCode(param.carrier)],
		[11, 3, param.sessionId],
		[11, 4, param.verifier],
		[8, 5, param.standardAge],
	];
}
List clearRingtone_args(LINEtypes.clearRingtone_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.oid],
	];
}
List confirmIdentifier_args(LINEtypes.confirmIdentifier_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.authSessionId],
		[12, 3, IdentityCredentialRequest(param.request)],
	];
}
List connectEapAccount_args(LINEtypes.connectEapAccount_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ConnectEapAccountRequest(param.request)],
	];
}
List createChatRoomAnnouncement_args(LINEtypes.createChatRoomAnnouncement_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.chatRoomMid],
		[8, 3, Pb1_X2(param.type)],
		[12, 4, ChatRoomAnnouncementContents(param.contents)],
	];
}
List createChat_args(LINEtypes.createChat_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, CreateChatRequest(param.request)],
	];
}
List createCollectionForUser_args(LINEtypes.createCollectionForUser_args? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List createCombinationSticker_args(LINEtypes.createCombinationSticker_args? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List createE2EEKeyBackupEnforced_args(LINEtypes.createE2EEKeyBackupEnforced_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, Pb1_C13263z3(param.request)],
	];
}
List createGroupCallUrl_args(LINEtypes.createGroupCallUrl_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, CreateGroupCallUrlRequest(param.request)],
	];
}
List createLifetimeKeyBackup_args(LINEtypes.createLifetimeKeyBackup_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, Pb1_E3(param.request)],
	];
}
List createMultiProfile_args(LINEtypes.createMultiProfile_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, CreateMultiProfileRequest(param.request)],
	];
}
List createRoomV2_args(LINEtypes.createRoomV2_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[15, 2, [11, param.contactIds]],
	];
}
List createSession_args(LINEtypes.createSession_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, h80_C25643c(param.request as LINEtypes.h80_C25643c)],
	];
}
List decryptFollowEMid_args(LINEtypes.decryptFollowEMid_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.eMid],
	];
}
List deleteE2EEKeyBackup_args(LINEtypes.deleteE2EEKeyBackup_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, Pb1_H3(param.request)],
	];
}
List deleteGroupCallUrl_args(LINEtypes.deleteGroupCallUrl_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, DeleteGroupCallUrlRequest(param.request)],
	];
}
List deleteMultiProfile_args(LINEtypes.deleteMultiProfile_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, DeleteMultiProfileRequest(param.request)],
	];
}
List deleteOtherFromChat_args(LINEtypes.deleteOtherFromChat_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, DeleteOtherFromChatRequest(param.request)],
	];
}
List deletePrimaryCredential_args(LINEtypes.deletePrimaryCredential_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, R70_c(param.request)],
	];
}
List deleteSafetyStatus_args(LINEtypes.deleteSafetyStatus_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, DeleteSafetyStatusRequest(param.req)],
	];
}
List deleteSelfFromChat_args(LINEtypes.deleteSelfFromChat_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, DeleteSelfFromChatRequest(param.request)],
	];
}
List determineMediaMessageFlow_args(LINEtypes.determineMediaMessageFlow_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, DetermineMediaMessageFlowRequest(param.request)],
	];
}
List disconnectEapAccount_args(LINEtypes.disconnectEapAccount_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, DisconnectEapAccountRequest(param.request)],
	];
}
List editItemsInCollection_args(LINEtypes.editItemsInCollection_args? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List enablePointForOneTimeKey_args(LINEtypes.enablePointForOneTimeKey_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[2, 1, param.usePoint],
	];
}
List establishE2EESession_args(LINEtypes.establishE2EESession_args? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List existPinCode_args(LINEtypes.existPinCode_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, S70_b(param.request)],
	];
}
List fetchOperations_args(LINEtypes.fetchOperations_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, FetchOperationsRequest(param.request)],
	];
}
List fetchPhonePinCodeMsg_args(LINEtypes.fetchPhonePinCodeMsg_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, FetchPhonePinCodeMsgRequest(param.request)],
	];
}
List findBuddyContactsByQuery_args(LINEtypes.findBuddyContactsByQuery_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.language],
		[11, 3, param.country],
		[11, 4, param.query],
		[8, 5, param.fromIndex],
		[8, 6, param.count],
		[8, 7, Pb1_F0(param.requestSource)],
	];
}
List findChatByTicket_args(LINEtypes.findChatByTicket_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, FindChatByTicketRequest(param.request)],
	];
}
List findContactByUserTicket_args(LINEtypes.findContactByUserTicket_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.ticketIdWithTag],
	];
}
List findContactByUserid_args(LINEtypes.findContactByUserid_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.searchId],
	];
}
List findContactsByPhone_args(LINEtypes.findContactsByPhone_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[14, 2, [11, param.phones]],
	];
}
List finishUpdateVerification_args(LINEtypes.finishUpdateVerification_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.sessionId],
	];
}
List follow_args(LINEtypes.follow_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, FollowRequest(param.followRequest)],
	];
}
List generateUserTicket_args(LINEtypes.generateUserTicket_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[10, 3, param.expirationTime],
		[8, 4, param.maxUseCount],
	];
}
List getAccessToken_args(LINEtypes.getAccessToken_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetAccessTokenRequest(param.request)],
	];
}
List getAccountBalanceAsync_args(LINEtypes.getAccountBalanceAsync_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.requestToken],
		[11, 2, param.accountId],
	];
}
List getAcctVerifMethod_args(LINEtypes.getAcctVerifMethod_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
		[12, 2, AccountIdentifier(param.accountIdentifier)],
	];
}
List getAllChatMids_args(LINEtypes.getAllChatMids_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetAllChatMidsRequest(param.request)],
		[8, 2, Pb1_V7(param.syncReason)],
	];
}
List getAllContactIds_args(LINEtypes.getAllContactIds_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Pb1_V7(param.syncReason)],
	];
}
List getAllowedRegistrationMethod_args(LINEtypes.getAllowedRegistrationMethod_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
		[11, 2, param.countryCode],
	];
}
List getApprovedChannels_args(LINEtypes.getApprovedChannels_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[10, 2, param.lastSynced],
		[11, 3, param.locale],
	];
}
List getAssertionChallenge_args(LINEtypes.getAssertionChallenge_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, m80_l(param.request)],
	];
}
List getAttestationChallenge_args(LINEtypes.getAttestationChallenge_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, m80_n(param.request)],
	];
}
List getAuthRSAKey_args(LINEtypes.getAuthRSAKey_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.authSessionId],
		[8, 3, IdentityProvider(param.identityProvider)],
	];
}
List getAuthorsLatestProducts_args(LINEtypes.getAuthorsLatestProducts_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, LatestProductsByAuthorRequest(param.latestProductsByAuthorRequest)],
	];
}
List getAutoSuggestionShowcase_args(LINEtypes.getAutoSuggestionShowcase_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, AutoSuggestionShowcaseRequest(param.autoSuggestionShowcaseRequest)],
	];
}
List getBalanceSummaryV2_args(LINEtypes.getBalanceSummaryV2_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, NZ0_C12208u(param.request)],
	];
}
List getBalanceSummaryV4WithPayV3_args(LINEtypes.getBalanceSummaryV4WithPayV3_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, NZ0_C12214w(param.request)],
	];
}
List getBalance_args(LINEtypes.getBalance_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ZQ0_b(param.request)],
	];
}
List getBankBranches_args(LINEtypes.getBankBranches_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.financialCorpId],
		[11, 2, param.query],
		[8, 3, param.startNum],
		[8, 4, param.count],
	];
}
List getBanners_args(LINEtypes.getBanners_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, BannerRequest(param.request)],
	];
}
List getBirthdayEffect_args(LINEtypes.getBirthdayEffect_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, Eh_C8933a(param.req)],
	];
}
List getBleDevice_args(LINEtypes.getBleDevice_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetBleDeviceRequest(param.request)],
	];
}
List getBlockedContactIds_args(LINEtypes.getBlockedContactIds_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Pb1_V7(param.syncReason)],
	];
}
List getBlockedRecommendationIds_args(LINEtypes.getBlockedRecommendationIds_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Pb1_V7(param.syncReason)],
	];
}
List getBrowsingHistory_args(LINEtypes.getBrowsingHistory_args? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List getBuddyChatBarV2_args(LINEtypes.getBuddyChatBarV2_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetBuddyChatBarRequest(param.request)],
	];
}
List getBuddyDetailWithPersonal_args(LINEtypes.getBuddyDetailWithPersonal_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.buddyMid],
		[14, 2, [
			8,
			param.attributeSet != null ? param.attributeSet.map((e) => Pb1_D0(e)).toList() : [],
		]],
	];
}
List getBuddyDetail_args(LINEtypes.getBuddyDetail_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 4, param.buddyMid],
	];
}
List getBuddyLive_args(LINEtypes.getBuddyLive_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetBuddyLiveRequest(param.request)],
	];
}
List getBuddyOnAir_args(LINEtypes.getBuddyOnAir_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 4, param.buddyMid],
	];
}
List getBuddyStatusBarV2_args(LINEtypes.getBuddyStatusBarV2_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetBuddyStatusBarV2Request(param.request)],
	];
}
List getCallStatus_args(LINEtypes.getCallStatus_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetCallStatusRequest(param.request)],
	];
}
List getCampaign_args(LINEtypes.getCampaign_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetCampaignRequest(param.request)],
	];
}
List getChallengeForPaakAuth_args(LINEtypes.getChallengeForPaakAuth_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetChallengeForPaakAuthRequest(param.request)],
	];
}
List getChallengeForPrimaryReg_args(LINEtypes.getChallengeForPrimaryReg_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetChallengeForPrimaryRegRequest(param.request)],
	];
}
List getChannelContext_args(LINEtypes.getChannelContext_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetChannelContextRequest(param.request)],
	];
}
List getChannelInfo_args(LINEtypes.getChannelInfo_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.channelId],
		[11, 3, param.locale],
	];
}
List getChannelNotificationSettings_args(LINEtypes.getChannelNotificationSettings_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.locale],
	];
}
List getChatEffectMetaList_args(LINEtypes.getChatEffectMetaList_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[14, 1, [8, param.categories != null ? param.categories.map((e) => Pb1_Q2(e)).toList() : []]],
	];
}
List getChatRoomAnnouncementsBulk_args(LINEtypes.getChatRoomAnnouncementsBulk_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[15, 2, [11, param.chatRoomMids]],
		[8, 3, Pb1_V7(param.syncReason)],
	];
}
List getChatRoomAnnouncements_args(LINEtypes.getChatRoomAnnouncements_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.chatRoomMid],
	];
}
List getChatRoomBGMs_args(LINEtypes.getChatRoomBGMs_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[14, 2, [11, param.chatRoomMids]],
		[8, 3, Pb1_V7(param.syncReason)],
	];
}
List getChatapp_args(LINEtypes.getChatapp_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetChatappRequest(param.request)],
	];
}
List getChats_args(LINEtypes.getChats_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetChatsRequest(param.request)],
		[8, 2, Pb1_V7(param.syncReason)],
	];
}
List getCoinProducts_args(LINEtypes.getCoinProducts_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetCoinProductsRequest(param.request)],
	];
}
List getCoinPurchaseHistory_args(LINEtypes.getCoinPurchaseHistory_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetCoinHistoryRequest(param.request)],
	];
}
List getCoinUseAndRefundHistory_args(LINEtypes.getCoinUseAndRefundHistory_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetCoinHistoryRequest(param.request)],
	];
}
List getCommonDomains_args(LINEtypes.getCommonDomains_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[10, 1, param.lastSynced],
	];
}
List getConfigurations_args(LINEtypes.getConfigurations_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[10, 2, param.revision],
		[11, 3, param.regionOfUsim],
		[11, 4, param.regionOfTelephone],
		[11, 5, param.regionOfLocale],
		[11, 6, param.carrier],
		[8, 7, Pb1_V7(param.syncReason)],
	];
}
List getContactCalendarEvents_args(LINEtypes.getContactCalendarEvents_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetContactCalendarEventsRequest(param.request)],
	];
}
List getContactsV3_args(LINEtypes.getContactsV3_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetContactsV3Request(param.request)],
	];
}
List getCountries_args(LINEtypes.getCountries_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 2, Pb1_EnumC13221w3(param.countryGroup)],
	];
}
List getCountryInfo_args(LINEtypes.getCountryInfo_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
		[12, 11, SimCard(param.simCard)],
	];
}
List getDataRetention_args(LINEtypes.getDataRetention_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, fN0_C24473e(param.req)],
	];
}
List getDestinationUrl_args(LINEtypes.getDestinationUrl_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, DestinationLIFFRequest(param.request)],
	];
}
List getDisasterCases_args(LINEtypes.getDisasterCases_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, vh_C37633d(param.req)],
	];
}
List getE2EEGroupSharedKey_args(LINEtypes.getE2EEGroupSharedKey_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 2, param.keyVersion],
		[11, 3, param.chatMid],
		[8, 4, param.groupKeyId],
	];
}
List getE2EEKeyBackupCertificates_args(LINEtypes.getE2EEKeyBackupCertificates_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, Pb1_W4(param.request)],
	];
}
List getE2EEKeyBackupInfo_args(LINEtypes.getE2EEKeyBackupInfo_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, Pb1_Y4(param.request)],
	];
}
List getE2EEPublicKey_args(LINEtypes.getE2EEPublicKey_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.mid],
		[8, 3, param.keyVersion],
		[8, 4, param.keyId],
	];
}
List getExchangeKey_args(LINEtypes.getExchangeKey_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetExchangeKeyRequest(param.request)],
	];
}
List getExtendedProfile_args(LINEtypes.getExtendedProfile_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Pb1_V7(param.syncReason)],
	];
}
List getFollowBlacklist_args(LINEtypes.getFollowBlacklist_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, GetFollowBlacklistRequest(param.getFollowBlacklistRequest)],
	];
}
List getFollowers_args(LINEtypes.getFollowers_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, GetFollowersRequest(param.getFollowersRequest)],
	];
}
List getFollowings_args(LINEtypes.getFollowings_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, GetFollowingsRequest(param.getFollowingsRequest)],
	];
}
List getFontMetas_args(LINEtypes.getFontMetas_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetFontMetasRequest(param.request)],
	];
}
List getFriendDetails_args(LINEtypes.getFriendDetails_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetFriendDetailsRequest(param.request)],
	];
}
List getFriendRequests_args(LINEtypes.getFriendRequests_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Pb1_F4(param.direction)],
		[10, 2, param.lastSeenSeqId],
	];
}
List getGnbBadgeStatus_args(LINEtypes.getGnbBadgeStatus_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetGnbBadgeStatusRequest(param.request)],
	];
}
List getGroupCallUrlInfo_args(LINEtypes.getGroupCallUrlInfo_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, GetGroupCallUrlInfoRequest(param.request)],
	];
}
List getGroupCallUrls_args(LINEtypes.getGroupCallUrls_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, Pb1_C13042j5(param.request)],
	];
}
List getGroupCall_args(LINEtypes.getGroupCall_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.chatMid],
	];
}
List getHomeFlexContent_args(LINEtypes.getHomeFlexContent_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetHomeFlexContentRequest(param.request)],
	];
}
List getHomeServiceList_args(LINEtypes.getHomeServiceList_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, Eg_C8928b(param.request)],
	];
}
List getHomeServices_args(LINEtypes.getHomeServices_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetHomeServicesRequest(param.request)],
	];
}
List getIncentiveStatus_args(LINEtypes.getIncentiveStatus_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, fN0_C24471c(param.req)],
	];
}
List getInstantNews_args(LINEtypes.getInstantNews_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.region],
		[12, 2, Location(param.location)],
	];
}
List getJoinedMembershipByBotMid_args(LINEtypes.getJoinedMembershipByBotMid_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetJoinedMembershipByBotMidRequest(param.request)],
	];
}
List getJoinedMembership_args(LINEtypes.getJoinedMembership_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetJoinedMembershipRequest(param.request)],
	];
}
List getKeyBackupCertificatesV2_args(LINEtypes.getKeyBackupCertificatesV2_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, Pb1_C13070l5(param.request)],
	];
}
List getLFLSuggestion_args(LINEtypes.getLFLSuggestion_args? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List getLastE2EEGroupSharedKey_args(LINEtypes.getLastE2EEGroupSharedKey_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 2, param.keyVersion],
		[11, 3, param.chatMid],
	];
}
List getLastE2EEPublicKeys_args(LINEtypes.getLastE2EEPublicKeys_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.chatMid],
	];
}
List getLiffViewWithoutUserContext_args(LINEtypes.getLiffViewWithoutUserContext_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, LiffViewWithoutUserContextRequest(param.request)],
	];
}
List getLineCardIssueForm_args(LINEtypes.getLineCardIssueForm_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, r80_EnumC34372l(param.resolutionType)],
	];
}
List getLoginActorContext_args(LINEtypes.getLoginActorContext_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetLoginActorContextRequest(param.request)],
	];
}
List getMappedProfileIds_args(LINEtypes.getMappedProfileIds_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetMappedProfileIdsRequest(param.request)],
	];
}
List getMaskedEmail_args(LINEtypes.getMaskedEmail_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
		[12, 2, AccountIdentifier(param.accountIdentifier)],
	];
}
List getMessageBoxes_args(LINEtypes.getMessageBoxes_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, MessageBoxListRequest(param.messageBoxListRequest)],
		[8, 3, Pb1_V7(param.syncReason)],
	];
}
List getMessageReadRange_args(LINEtypes.getMessageReadRange_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[15, 2, [11, param.chatIds]],
		[8, 3, Pb1_V7(param.syncReason)],
	];
}
List getModuleLayoutV4_args(LINEtypes.getModuleLayoutV4_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetModuleLayoutV4Request(param.request)],
	];
}
List getModuleWithStatus_args(LINEtypes.getModuleWithStatus_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, NZ0_G(param.request)],
	];
}
List getModule_args(LINEtypes.getModule_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, NZ0_E(param.request)],
	];
}
List getModulesV2_args(LINEtypes.getModulesV2_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetModulesRequestV2(param.request)],
	];
}
List getModulesV3_args(LINEtypes.getModulesV3_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetModulesRequestV3(param.request)],
	];
}
List getModulesV4WithStatus_args(LINEtypes.getModulesV4WithStatus_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetModulesV4WithStatusRequest(param.request)],
	];
}
List getMusicSubscriptionStatus_args(LINEtypes.getMusicSubscriptionStatus_args? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List getMyAssetInformationV2_args(LINEtypes.getMyAssetInformationV2_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetMyAssetInformationV2Request(param.request)],
	];
}
List getMyChatapps_args(LINEtypes.getMyChatapps_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetMyChatappsRequest(param.request)],
	];
}
List getMyDashboard_args(LINEtypes.getMyDashboard_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetMyDashboardRequest(param.request)],
	];
}
List getNewlyReleasedBuddyIds_args(LINEtypes.getNewlyReleasedBuddyIds_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 3, param.country],
	];
}
List getNotificationSettings_args(LINEtypes.getNotificationSettings_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetNotificationSettingsRequest(param.request)],
	];
}
List getOwnedProductSummaries_args(LINEtypes.getOwnedProductSummaries_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.shopId],
		[8, 3, param.offset],
		[8, 4, param.limit],
		[12, 5, Locale(param.locale)],
	];
}
List getPasswordHashingParameter_args(LINEtypes.getPasswordHashingParameter_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetPasswordHashingParametersRequest(param.request)],
	];
}
List getPasswordHashingParametersForPwdReg_args(LINEtypes.getPasswordHashingParametersForPwdReg_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetPasswordHashingParametersForPwdRegRequest(param.request)],
	];
}
List getPasswordHashingParametersForPwdVerif_args(LINEtypes.getPasswordHashingParametersForPwdVerif_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetPasswordHashingParametersForPwdVerifRequest(param.request)],
	];
}
List getPaymentUrlByKey_args(LINEtypes.getPaymentUrlByKey_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.key],
	];
}
List getPhoneVerifMethodForRegistration_args(LINEtypes.getPhoneVerifMethodForRegistration_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetPhoneVerifMethodForRegistrationRequest(param.request)],
	];
}
List getPhoneVerifMethodV2_args(LINEtypes.getPhoneVerifMethodV2_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetPhoneVerifMethodV2Request(param.request)],
	];
}
List getPhotoboothBalance_args(LINEtypes.getPhotoboothBalance_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, Pb1_C13126p5(param.request)],
	];
}
List getPredefinedScenarioSets_args(LINEtypes.getPredefinedScenarioSets_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetPredefinedScenarioSetsRequest(param.request)],
	];
}
List getPrefetchableBanners_args(LINEtypes.getPrefetchableBanners_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, BannerRequest(param.request)],
	];
}
List getPremiumStatusForUpgrade_args(LINEtypes.getPremiumStatusForUpgrade_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, fN0_C24475g(param.req)],
	];
}
List getPremiumStatus_args(LINEtypes.getPremiumStatus_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, fN0_C24476h(param.req)],
	];
}
List getPreviousMessagesV2WithRequest_args(LINEtypes.getPreviousMessagesV2WithRequest_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, GetPreviousMessagesV2Request(param.request)],
		[8, 3, Pb1_V7(param.syncReason)],
	];
}
List getProductByVersion_args(LINEtypes.getProductByVersion_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.shopId],
		[11, 3, param.productId],
		[10, 4, param.productVersion],
		[12, 5, Locale(param.locale)],
	];
}
List getProductLatestVersionForUser_args(LINEtypes.getProductLatestVersionForUser_args? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List getProductSummariesInSubscriptionSlots_args(LINEtypes.getProductSummariesInSubscriptionSlots_args? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List getProductV2_args(LINEtypes.getProductV2_args? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List getProductValidationScheme_args(LINEtypes.getProductValidationScheme_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.shopId],
		[11, 3, param.productId],
		[10, 4, param.productVersion],
	];
}
List getProductsByAuthor_args(LINEtypes.getProductsByAuthor_args? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List getProfile_args(LINEtypes.getProfile_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Pb1_V7(param.syncReason)],
	];
}
List getPromotedBuddyContacts_args(LINEtypes.getPromotedBuddyContacts_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.language],
		[11, 3, param.country],
	];
}
List getPublishedMemberships_args(LINEtypes.getPublishedMemberships_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetPublishedMembershipsRequest(param.request)],
	];
}
List getPurchaseEnabledStatus_args(LINEtypes.getPurchaseEnabledStatus_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, PurchaseEnabledRequest(param.request)],
	];
}
List getPurchasedProducts_args(LINEtypes.getPurchasedProducts_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.shopId],
		[8, 3, param.offset],
		[8, 4, param.limit],
		[12, 5, Locale(param.locale)],
	];
}
List getQuickMenu_args(LINEtypes.getQuickMenu_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, NZ0_S(param.request)],
	];
}
List getReceivedPresents_args(LINEtypes.getReceivedPresents_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.shopId],
		[8, 3, param.offset],
		[8, 4, param.limit],
		[12, 5, Locale(param.locale)],
	];
}
List getRecentFriendRequests_args(LINEtypes.getRecentFriendRequests_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Pb1_V7(param.syncReason)],
	];
}
List getRecommendationDetails_args(LINEtypes.getRecommendationDetails_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetRecommendationDetailsRequest(param.request)],
	];
}
List getRecommendationIds_args(LINEtypes.getRecommendationIds_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Pb1_V7(param.syncReason)],
	];
}
List getRecommendationList_args(LINEtypes.getRecommendationList_args? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List getRepairElements_args(LINEtypes.getRepairElements_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetRepairElementsRequest(param.request)],
	];
}
List getResourceFile_args(LINEtypes.getResourceFile_args? param) {
	if (param == null) {
		return [];
	}
	return [];
}
List getResponseStatus_args(LINEtypes.getResponseStatus_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetResponseStatusRequest(param.request)],
	];
}
List getReturnUrlWithRequestTokenForAutoLogin_args(LINEtypes.getReturnUrlWithRequestTokenForAutoLogin_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, WebLoginRequest(param.webLoginRequest)],
	];
}
List getReturnUrlWithRequestTokenForMultiLiffLogin_args(LINEtypes.getReturnUrlWithRequestTokenForMultiLiffLogin_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, LiffWebLoginRequest(param.request)],
	];
}
List getRoomsV2_args(LINEtypes.getRoomsV2_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[15, 2, [11, param.roomIds]],
	];
}
List getSCC_args(LINEtypes.getSCC_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSCCRequest(param.request)],
	];
}
List getSeasonalEffects_args(LINEtypes.getSeasonalEffects_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, Eh_C8935c(param.req)],
	];
}
List getSecondAuthMethod_args(LINEtypes.getSecondAuthMethod_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
	];
}
List getSentPresents_args(LINEtypes.getSentPresents_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.shopId],
		[8, 3, param.offset],
		[8, 4, param.limit],
		[12, 5, Locale(param.locale)],
	];
}
List getServiceShortcutMenu_args(LINEtypes.getServiceShortcutMenu_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, NZ0_U(param.request)],
	];
}
List getSessionContentBeforeMigCompletion_args(LINEtypes.getSessionContentBeforeMigCompletion_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
	];
}
List getSettingsAttributes2_args(LINEtypes.getSettingsAttributes2_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[14, 2, [
			8,
			param.attributesToRetrieve != null ? param.attributesToRetrieve.map((e) => SettingsAttributeEx(e)).toList() : [],
		]],
	];
}
List getSettings_args(LINEtypes.getSettings_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Pb1_V7(param.syncReason)],
	];
}
List getSmartChannelRecommendations_args(LINEtypes.getSmartChannelRecommendations_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSmartChannelRecommendationsRequest(param.request)],
	];
}
List getSquareBot_args(LINEtypes.getSquareBot_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetSquareBotRequest(param.req)],
	];
}
List getStudentInformation_args(LINEtypes.getStudentInformation_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, Ob1_C12606a0(param.req)],
	];
}
List getSubscriptionPlans_args(LINEtypes.getSubscriptionPlans_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, GetSubscriptionPlansRequest(param.req)],
	];
}
List getSubscriptionSlotHistory_args(LINEtypes.getSubscriptionSlotHistory_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, Ob1_C12618e0(param.req)],
	];
}
List getSubscriptionStatus_args(LINEtypes.getSubscriptionStatus_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, GetSubscriptionStatusRequest(param.req)],
	];
}
List getSuggestDictionarySetting_args(LINEtypes.getSuggestDictionarySetting_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, Ob1_C12630i0(param.req)],
	];
}
List getSuggestResourcesV2_args(LINEtypes.getSuggestResourcesV2_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, GetSuggestResourcesV2Request(param.req)],
	];
}
List getTaiwanBankBalance_args(LINEtypes.getTaiwanBankBalance_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetTaiwanBankBalanceRequest(param.request)],
	];
}
List getTargetProfiles_args(LINEtypes.getTargetProfiles_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetTargetProfilesRequest(param.request)],
	];
}
List getTargetingPopup_args(LINEtypes.getTargetingPopup_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, NZ0_C12150a0(param.request)],
	];
}
List getThaiBankBalance_args(LINEtypes.getThaiBankBalance_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetThaiBankBalanceRequest(param.request)],
	];
}
List getTotalCoinBalance_args(LINEtypes.getTotalCoinBalance_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetTotalCoinBalanceRequest(param.request)],
	];
}
List getUpdatedChannelIds_args(LINEtypes.getUpdatedChannelIds_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[15, 1, [
			12,
			param.channelIds != null ? param.channelIds.map((e) => ChannelIdWithLastUpdated(e)).toList() : [],
		]],
	];
}
List getUserCollections_args(LINEtypes.getUserCollections_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetUserCollectionsRequest(param.request)],
	];
}
List getUserProfile_args(LINEtypes.getUserProfile_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
		[12, 2, AccountIdentifier(param.accountIdentifier)],
	];
}
List getUserVector_args(LINEtypes.getUserVector_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetUserVectorRequest(param.request)],
	];
}
List getUsersMappedByProfile_args(LINEtypes.getUsersMappedByProfile_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, GetUsersMappedByProfileRequest(param.request)],
	];
}
List getWebLoginDisallowedUrlForMultiLiffLogin_args(LINEtypes.getWebLoginDisallowedUrlForMultiLiffLogin_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, LiffWebLoginRequest(param.request)],
	];
}
List getWebLoginDisallowedUrl_args(LINEtypes.getWebLoginDisallowedUrl_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, WebLoginRequest(param.webLoginRequest)],
	];
}
List inviteFriends_args(LINEtypes.inviteFriends_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, InviteFriendsRequest(param.request)],
	];
}
List inviteIntoChat_args(LINEtypes.inviteIntoChat_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, InviteIntoChatRequest(param.request)],
	];
}
List inviteIntoGroupCall_args(LINEtypes.inviteIntoGroupCall_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.chatMid],
		[15, 3, [11, param.memberMids]],
		[8, 4, Pb1_EnumC13237x5(param.mediaType)],
	];
}
List inviteIntoRoom_args(LINEtypes.inviteIntoRoom_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.roomId],
		[15, 3, [11, param.contactIds]],
	];
}
List isProductForCollections_args(LINEtypes.isProductForCollections_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, IsProductForCollectionsRequest(param.request)],
	];
}
List isStickerAvailableForCombinationSticker_args(LINEtypes.isStickerAvailableForCombinationSticker_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, IsStickerAvailableForCombinationStickerRequest(param.request)],
	];
}
List isUseridAvailable_args(LINEtypes.isUseridAvailable_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.searchId],
	];
}
List issueChannelToken_args(LINEtypes.issueChannelToken_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.channelId],
	];
}
List issueLiffView_args(LINEtypes.issueLiffView_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, LiffViewRequest(param.request)],
	];
}
List issueRequestTokenWithAuthScheme_args(LINEtypes.issueRequestTokenWithAuthScheme_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.channelId],
		[11, 2, param.otpId],
		[15, 3, [11, param.authScheme]],
		[11, 4, param.returnUrl],
	];
}
List issueSubLiffView_args(LINEtypes.issueSubLiffView_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, LiffViewRequest(param.request)],
	];
}
List issueTokenForAccountMigrationSettings_args(LINEtypes.issueTokenForAccountMigrationSettings_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[2, 2, param.enforce],
	];
}
List issueToken_args(LINEtypes.issueToken_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, IssueBirthdayGiftTokenRequest(param.request)],
	];
}
List issueV3TokenForPrimary_args(LINEtypes.issueV3TokenForPrimary_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, IssueV3TokenForPrimaryRequest(param.request)],
	];
}
List issueWebAuthDetailsForSecondAuth_args(LINEtypes.issueWebAuthDetailsForSecondAuth_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
	];
}
List joinChatByCallUrl_args(LINEtypes.joinChatByCallUrl_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, JoinChatByCallUrlRequest(param.request)],
	];
}
List kickoutFromGroupCall_args(LINEtypes.kickoutFromGroupCall_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, KickoutFromGroupCallRequest(param.kickoutFromGroupCallRequest)],
	];
}
List leaveRoom_args(LINEtypes.leaveRoom_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.roomId],
	];
}
List linkDevice_args(LINEtypes.linkDevice_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, DeviceLinkRequest(param.request)],
	];
}
List lookupAvailableEap_args(LINEtypes.lookupAvailableEap_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, LookupAvailableEapRequest(param.request)],
	];
}
List lookupPaidCall_args(LINEtypes.lookupPaidCall_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.dialedNumber],
		[11, 3, param.language],
		[11, 4, param.referer],
	];
}
List mapProfileToUsers_args(LINEtypes.mapProfileToUsers_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, MapProfileToUsersRequest(param.request)],
	];
}
List migratePrimaryUsingEapAccountWithTokenV3_args(LINEtypes.migratePrimaryUsingEapAccountWithTokenV3_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
	];
}
List migratePrimaryUsingPhoneWithTokenV3_args(LINEtypes.migratePrimaryUsingPhoneWithTokenV3_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
	];
}
List migratePrimaryUsingQrCode_args(LINEtypes.migratePrimaryUsingQrCode_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, MigratePrimaryUsingQrCodeRequest(param.request)],
	];
}
List negotiateE2EEPublicKey_args(LINEtypes.negotiateE2EEPublicKey_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.mid],
	];
}
List notifyChatAdEntry_args(LINEtypes.notifyChatAdEntry_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, NotifyChatAdEntryRequest(param.request)],
	];
}
List notifyDeviceConnection_args(LINEtypes.notifyDeviceConnection_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, NotifyDeviceConnectionRequest(param.request)],
	];
}
List notifyDeviceDisconnection_args(LINEtypes.notifyDeviceDisconnection_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, NotifyDeviceDisconnectionRequest(param.request)],
	];
}
List notifyInstalled_args(LINEtypes.notifyInstalled_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.udidHash],
		[11, 3, param.applicationTypeWithExtensions],
	];
}
List notifyOATalkroomEvents_args(LINEtypes.notifyOATalkroomEvents_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, NotifyOATalkroomEventsRequest(param.request)],
	];
}
List notifyProductEvent_args(LINEtypes.notifyProductEvent_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.shopId],
		[11, 3, param.productId],
		[10, 4, param.productVersion],
		[10, 5, param.productEvent],
	];
}
List notifyRegistrationComplete_args(LINEtypes.notifyRegistrationComplete_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.udidHash],
		[11, 3, param.applicationTypeWithExtensions],
	];
}
List notifyScenarioExecuted_args(LINEtypes.notifyScenarioExecuted_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, NotifyScenarioExecutedRequest(param.request)],
	];
}
List notifyUpdated_args(LINEtypes.notifyUpdated_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[10, 2, param.lastRev],
		[12, 3, DeviceInfo(param.deviceInfo)],
		[11, 4, param.udidHash],
		[11, 5, param.oldUdidHash],
	];
}
List openAuthSession_args(LINEtypes.openAuthSession_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, AuthSessionRequest(param.request)],
	];
}
List openSession_args(LINEtypes.openSession_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, OpenSessionRequest(param.request)],
	];
}
List permitLogin_args(LINEtypes.permitLogin_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, PermitLoginRequest(param.request)],
	];
}
List placePurchaseOrderForFreeProduct_args(LINEtypes.placePurchaseOrderForFreeProduct_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, PurchaseOrder(param.purchaseOrder)],
	];
}
List placePurchaseOrderWithLineCoin_args(LINEtypes.placePurchaseOrderWithLineCoin_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, PurchaseOrder(param.purchaseOrder)],
	];
}
List postPopupButtonEvents_args(LINEtypes.postPopupButtonEvents_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.buttonId],
		[13, 2, [11, 2, param.checkboxes]],
	];
}
List purchaseSubscription_args(LINEtypes.purchaseSubscription_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, PurchaseSubscriptionRequest(param.req)],
	];
}
List putE2eeKey_args(LINEtypes.putE2eeKey_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, PutE2eeKeyRequest(param.request)],
	];
}
List react_args(LINEtypes.react_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ReactRequest(param.reactRequest)],
	];
}
List refresh_args(LINEtypes.refresh_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, RefreshAccessTokenRequest(param.request)],
	];
}
List registerBarcodeAsync_args(LINEtypes.registerBarcodeAsync_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.requestToken],
		[11, 2, param.barcodeRequestId],
		[11, 3, param.barcode],
		[12, 4, RSAEncryptedPassword(param.password)],
	];
}
List registerCampaignReward_args(LINEtypes.registerCampaignReward_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, RegisterCampaignRewardRequest(param.request)],
	];
}
List registerE2EEGroupKey_args(LINEtypes.registerE2EEGroupKey_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 2, param.keyVersion],
		[11, 3, param.chatMid],
		[15, 4, [11, param.members]],
		[15, 5, [8, param.keyIds]],
		[15, 6, [11, param.encryptedSharedKeys]],
	];
}
List registerE2EEPublicKeyV2_args(LINEtypes.registerE2EEPublicKeyV2_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, Pb1_W6(param.request)],
	];
}
List registerE2EEPublicKey_args(LINEtypes.registerE2EEPublicKey_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[12, 2, Pb1_C13097n4(param.publicKey)],
	];
}
List registerPrimaryCredential_args(LINEtypes.registerPrimaryCredential_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, RegisterPrimaryCredentialRequest(param.request)],
	];
}
List registerPrimaryUsingEapAccount_args(LINEtypes.registerPrimaryUsingEapAccount_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
	];
}
List registerPrimaryUsingPhoneWithTokenV3_args(LINEtypes.registerPrimaryUsingPhoneWithTokenV3_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.authSessionId],
	];
}
List registerUserid_args(LINEtypes.registerUserid_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.searchId],
	];
}
List reissueChatTicket_args(LINEtypes.reissueChatTicket_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ReissueChatTicketRequest(param.request)],
	];
}
List rejectChatInvitation_args(LINEtypes.rejectChatInvitation_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, RejectChatInvitationRequest(param.request)],
	];
}
List removeChatRoomAnnouncement_args(LINEtypes.removeChatRoomAnnouncement_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.chatRoomMid],
		[10, 3, param.announcementSeq],
	];
}
List removeFollower_args(LINEtypes.removeFollower_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, RemoveFollowerRequest(param.removeFollowerRequest)],
	];
}
List removeFriendRequest_args(LINEtypes.removeFriendRequest_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Pb1_F4(param.direction)],
		[11, 2, param.midOrEMid],
	];
}
List removeFromFollowBlacklist_args(LINEtypes.removeFromFollowBlacklist_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[
			12,
			2,
			RemoveFromFollowBlacklistRequest(param.removeFromFollowBlacklistRequest),
		],
	];
}
List removeIdentifier_args(LINEtypes.removeIdentifier_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.authSessionId],
		[12, 3, IdentityCredentialRequest(param.request)],
	];
}
List removeItemFromCollection_args(LINEtypes.removeItemFromCollection_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, RemoveItemFromCollectionRequest(param.request)],
	];
}
List removeLinePayAccount_args(LINEtypes.removeLinePayAccount_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.accountId],
	];
}
List removeProductFromSubscriptionSlot_args(LINEtypes.removeProductFromSubscriptionSlot_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, RemoveProductFromSubscriptionSlotRequest(param.req)],
	];
}
List reportAbuseEx_args(LINEtypes.reportAbuseEx_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, ReportAbuseExRequest(param.request)],
	];
}
List reportDeviceState_args(LINEtypes.reportDeviceState_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[13, 2, [8, 2, param.booleanState]],
		[13, 3, [8, 11, param.stringState]],
	];
}
List reportLocation_args(LINEtypes.reportLocation_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, Geolocation(param.location)],
		[8, 2, Pb1_EnumC12917a6(param.trigger)],
		[12, 3, ClientNetworkStatus(param.networkStatus)],
		[10, 4, param.measuredAt],
		[10, 6, param.clientCurrentTimestamp],
		[12, 7, LocationDebugInfo(param.debugInfo)],
	];
}
List reportNetworkStatus_args(LINEtypes.reportNetworkStatus_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, Pb1_EnumC12917a6(param.trigger)],
		[12, 2, ClientNetworkStatus(param.networkStatus)],
		[10, 3, param.measuredAt],
		[10, 4, param.scanCompletionTimestamp],
	];
}
List reportProfile_args(LINEtypes.reportProfile_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[10, 2, param.syncOpRevision],
		[12, 3, Profile(param.profile)],
	];
}
List reportPushRecvReports_args(LINEtypes.reportPushRecvReports_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[15, 2, [
			12,
			param.pushRecvReports != null ? param.pushRecvReports.map((e) => PushRecvReport(e)).toList() : [],
		]],
	];
}
List reportRefreshedAccessToken_args(LINEtypes.reportRefreshedAccessToken_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ReportRefreshedAccessTokenRequest(param.request)],
	];
}
List reportSettings_args(LINEtypes.reportSettings_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[10, 2, param.syncOpRevision],
		[12, 3, Settings(param.settings)],
	];
}
List requestCleanupUserProvidedData_args(LINEtypes.requestCleanupUserProvidedData_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[14, 1, [8, param.dataTypes != null ? param.dataTypes.map((e) => Pb1_od(e)).toList() : []]],
	];
}
List requestToSendPasswordSetVerificationEmail_args(LINEtypes.requestToSendPasswordSetVerificationEmail_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
		[11, 2, param.email],
		[12, 3, AccountIdentifier(param.accountIdentifier)],
	];
}
List requestToSendPhonePinCode_args(LINEtypes.requestToSendPhonePinCode_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ReqToSendPhonePinCodeRequest(param.request)],
	];
}
List requestTradeNumber_args(LINEtypes.requestTradeNumber_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.requestToken],
		[8, 2, r80_g0(param.requestType)],
		[11, 3, param.amount],
		[11, 4, param.name],
	];
}
List resendIdentifierConfirmation_args(LINEtypes.resendIdentifierConfirmation_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.authSessionId],
		[12, 3, IdentityCredentialRequest(param.request)],
	];
}
List resendPinCode_args(LINEtypes.resendPinCode_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.sessionId],
	];
}
List reserveCoinPurchase_args(LINEtypes.reserveCoinPurchase_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, CoinPurchaseReservation(param.request)],
	];
}
List reserveSubscriptionPurchase_args(LINEtypes.reserveSubscriptionPurchase_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ReserveSubscriptionPurchaseRequest(param.request)],
	];
}
List reserve_args(LINEtypes.reserve_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ReserveRequest(param.request)],
	];
}
List restoreE2EEKeyBackup_args(LINEtypes.restoreE2EEKeyBackup_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, Pb1_C13155r7(param.request)],
	];
}
List retrieveRequestTokenWithDocomoV2_args(LINEtypes.retrieveRequestTokenWithDocomoV2_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, Pb1_C13183t7(param.request)],
	];
}
List retrieveRequestToken_args(LINEtypes.retrieveRequestToken_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 2, CarrierCode(param.carrier)],
	];
}
List revokeTokens_args(LINEtypes.revokeTokens_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, RevokeTokensRequest(param.request)],
	];
}
List saveStudentInformation_args(LINEtypes.saveStudentInformation_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, SaveStudentInformationRequest(param.req)],
	];
}
List sendChatChecked_args(LINEtypes.sendChatChecked_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.seq],
		[11, 2, param.chatMid],
		[11, 3, param.lastMessageId],
		[3, 4, param.sessionId],
	];
}
List sendChatRemoved_args(LINEtypes.sendChatRemoved_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.seq],
		[11, 2, param.chatMid],
		[11, 3, param.lastMessageId],
		[3, 4, param.sessionId],
	];
}
List sendEncryptedE2EEKey_args(LINEtypes.sendEncryptedE2EEKey_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, SendEncryptedE2EEKeyRequest(param.request)],
	];
}
List sendMessage_args(LINEtypes.sendMessage_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.seq],
		[12, 2, Message(param.message)],
	];
}
List sendPostback_args(LINEtypes.sendPostback_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, SendPostbackRequest(param.request)],
	];
}
List setChatHiddenStatus_args(LINEtypes.setChatHiddenStatus_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, SetChatHiddenStatusRequest(param.setChatHiddenStatusRequest)],
	];
}
List setHashedPassword_args(LINEtypes.setHashedPassword_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, SetHashedPasswordRequest(param.request)],
	];
}
List setIdentifier_args(LINEtypes.setIdentifier_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.authSessionId],
		[12, 3, IdentityCredentialRequest(param.request)],
	];
}
List setNotificationsEnabled_args(LINEtypes.setNotificationsEnabled_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[8, 2, MIDType(param.type)],
		[11, 3, param.target],
		[2, 4, param.enablement],
	];
}
List setPassword_args(LINEtypes.setPassword_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, SetPasswordRequest(param.request)],
	];
}
List shouldShowWelcomeStickerBanner_args(LINEtypes.shouldShowWelcomeStickerBanner_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, Ob1_C12660s1(param.request)],
	];
}
List startPhotobooth_args(LINEtypes.startPhotobooth_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, StartPhotoboothRequest(param.request)],
	];
}
List startUpdateVerification_args(LINEtypes.startUpdateVerification_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.region],
		[8, 3, CarrierCode(param.carrier)],
		[11, 4, param.phone],
		[11, 5, param.udidHash],
		[12, 6, DeviceInfo(param.deviceInfo)],
		[11, 7, param.networkCode],
		[11, 8, param.locale],
		[12, 9, SIMInfo(param.simInfo)],
	];
}
List stopBundleSubscription_args(LINEtypes.stopBundleSubscription_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, StopBundleSubscriptionRequest(param.request)],
	];
}
List storeShareTargetPickerResult_args(LINEtypes.storeShareTargetPickerResult_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ShareTargetPickerResultRequest(param.request)],
	];
}
List storeSubWindowResult_args(LINEtypes.storeSubWindowResult_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, SubWindowResultRequest(param.request)],
	];
}
List syncContacts_args(LINEtypes.syncContacts_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[15, 2, [
			12,
			param.localContacts != null ? param.localContacts.map((e) => ContactModification(e)).toList() : [],
		]],
	];
}
List sync_args(LINEtypes.sync_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, SyncRequest(param.request)],
	];
}
List tryFriendRequest_args(LINEtypes.tryFriendRequest_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.midOrEMid],
		[8, 2, Pb1_G4(param.method)],
		[11, 3, param.friendRequestParams],
	];
}
List unblockContact_args(LINEtypes.unblockContact_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.id],
		[11, 3, param.reference],
	];
}
List unblockRecommendation_args(LINEtypes.unblockRecommendation_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.targetMid],
	];
}
List unfollow_args(LINEtypes.unfollow_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, UnfollowRequest(param.unfollowRequest)],
	];
}
List unlinkDevice_args(LINEtypes.unlinkDevice_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, DeviceUnlinkRequest(param.request)],
	];
}
List unsendMessage_args(LINEtypes.unsendMessage_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.seq],
		[11, 2, param.messageId],
	];
}
List updateAndGetNearby_args(LINEtypes.updateAndGetNearby_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[4, 2, param.latitude],
		[4, 3, param.longitude],
		[12, 4, GeolocationAccuracy(param.accuracy)],
		[12, 5, ClientNetworkStatus(param.networkStatus)],
		[4, 6, param.altitudeMeters],
		[4, 7, param.velocityMetersPerSecond],
		[4, 8, param.bearingDegrees],
		[10, 9, param.measuredAtTimestamp],
		[10, 10, param.clientCurrentTimestamp],
	];
}
List updateChannelNotificationSetting_args(LINEtypes.updateChannelNotificationSetting_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[15, 1, [
			12,
			param.setting != null ? param.setting.map((e) => ChannelNotificationSetting(e)).toList() : [],
		]],
	];
}
List updateChannelSettings_args(LINEtypes.updateChannelSettings_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, ChannelSettings(param.channelSettings)],
	];
}
List updateChatRoomBGM_args(LINEtypes.updateChatRoomBGM_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.chatRoomMid],
		[11, 3, param.chatRoomBGMInfo],
	];
}
List updateChat_args(LINEtypes.updateChat_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, UpdateChatRequest(param.request)],
	];
}
List updateContactSetting_args(LINEtypes.updateContactSetting_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[11, 2, param.mid],
		[8, 3, ContactSetting(param.flag)],
		[11, 4, param.value],
	];
}
List updateExtendedProfileAttribute_args(LINEtypes.updateExtendedProfileAttribute_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],

		[12, 3, ExtendedProfile(param.extendedProfile)],
	];
}
List updateGroupCallUrl_args(LINEtypes.updateGroupCallUrl_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, UpdateGroupCallUrlRequest(param.request)],
	];
}
List updateIdentifier_args(LINEtypes.updateIdentifier_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.authSessionId],
		[12, 3, IdentityCredentialRequest(param.request)],
	];
}
List updateNotificationToken_args(LINEtypes.updateNotificationToken_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.token],
		[8, 3, NotificationType(param.type)],
	];
}
List updatePassword_args(LINEtypes.updatePassword_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, UpdatePasswordRequest(param.request)],
	];
}
List updateProfileAttributes_args(LINEtypes.updateProfileAttributes_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[12, 2, UpdateProfileAttributesRequest(param.request)],
	];
}
List updateSafetyStatus_args(LINEtypes.updateSafetyStatus_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, UpdateSafetyStatusRequest(param.req)],
	];
}
List updateSettingsAttributes2_args(LINEtypes.updateSettingsAttributes2_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[8, 1, param.reqSeq],
		[12, 3, Settings(param.settings)],
		[14, 4, [
			8,
			param.attributesToUpdate != null ? param.attributesToUpdate.map((e) => SettingsAttributeEx(e)).toList() : [],
		]],
	];
}
List updateUserGeneralSettings_args(LINEtypes.updateUserGeneralSettings_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[13, 1, [8, 11, param.settings]],
	];
}
List usePhotoboothTicket_args(LINEtypes.usePhotoboothTicket_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, UsePhotoboothTicketRequest(param.request)],
	];
}
List validateEligibleFriends_args(LINEtypes.validateEligibleFriends_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[15, 1, [11, param.friends]],
		[8, 2, r80_EnumC34376p(param.type)],
	];
}
List validateProduct_args(LINEtypes.validateProduct_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.shopId],
		[11, 3, param.productId],
		[10, 4, param.productVersion],
	];
}
List validateProfile_args(LINEtypes.validateProfile_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
		[11, 2, param.displayName],
	];
}
List verifyAccountUsingHashedPwd_args(LINEtypes.verifyAccountUsingHashedPwd_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, VerifyAccountUsingHashedPwdRequest(param.request)],
	];
}
List verifyAssertion_args(LINEtypes.verifyAssertion_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, VerifyAssertionRequest(param.request)],
	];
}
List verifyAttestation_args(LINEtypes.verifyAttestation_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, VerifyAttestationRequest(param.request)],
	];
}
List verifyBirthdayGiftAssociationToken_args(LINEtypes.verifyBirthdayGiftAssociationToken_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 2, BirthdayGiftAssociationVerifyRequest(param.req)],
	];
}
List verifyEapAccountForRegistration_args(LINEtypes.verifyEapAccountForRegistration_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
		[12, 2, Device(param.device)],
		[12, 3, SocialLogin(param.socialLogin)],
	];
}
List verifyEapLogin_args(LINEtypes.verifyEapLogin_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, VerifyEapLoginRequest(param.request)],
	];
}
List verifyPhoneNumber_args(LINEtypes.verifyPhoneNumber_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.sessionId],
		[11, 3, param.pinCode],
		[11, 4, param.udidHash],
		[11, 5, param.migrationPincodeSessionId],
		[11, 6, param.oldUdidHash],
	];
}
List verifyPhonePinCode_args(LINEtypes.verifyPhonePinCode_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, VerifyPhonePinCodeRequest(param.request)],
	];
}
List verifyPinCode_args(LINEtypes.verifyPinCode_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, VerifyPinCodeRequest(param.request)],
	];
}
List verifyQrCode_args(LINEtypes.verifyQrCode_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[12, 1, VerifyQrCodeRequest(param.request)],
	];
}
List verifyQrcode_args(LINEtypes.verifyQrcode_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 2, param.verifier],
		[11, 3, param.pinCode],
	];
}
List verifySocialLogin_args(LINEtypes.verifySocialLogin_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[11, 1, param.authSessionId],
		[12, 2, Device(param.device)],
		[12, 3, SocialLogin(param.socialLogin)],
	];
}
List wakeUpLongPolling_args(LINEtypes.wakeUpLongPolling_args? param) {
	if (param == null) {
		return [];
	}
	return [
		[10, 2, param.clientRevision],
	];
}