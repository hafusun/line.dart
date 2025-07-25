import '../../service/types.dart';
import '../../core/core.dart';
import '../../../thrift/line_types.dart' as LINETypes;
import '../../../thrift/readwrite/struct.dart' as LINEStructs;

class RelationService extends BaseService {
  @override
  BaseClient client;
  @override
  int protocolType = 4;
  @override
  String requestPath = "/RE4";
  @override
  String errorName = "RelationServiceError";

  RelationService(this.client, [this.protocolType = 4, this.requestPath = "/RE4", this.errorName = "RelationServiceError"]);

  Future<dynamic> getTargetProfiles(Map param) async {
    return await client.request.request(
      LINEStructs.getTargetProfiles_args(LINETypes.getTargetProfiles_args.fromJson(param)),
      "getTargetProfiles",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getRecommendationDetails(Map param) async {
    return await client.request.request(
      LINEStructs.getRecommendationDetails_args(LINETypes.getRecommendationDetails_args.fromJson(param)),
      "getRecommendationDetails",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getContactCalenderEvents(Map param) async {
    return await client.request.request(
      LINEStructs.getContactCalendarEvents_args(LINETypes.getContactCalendarEvents_args.fromJson(param)),
      "getContactCalenderEvents",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getContactsV3(List<String> mids, [bool? checkUserstatusStrictly]) async {
    return await client.request.request(
      LINEStructs.getContactsV3_args(LINETypes.getContactsV3_args.fromJson({ "targetUsers": mids.map((m) => { "targetUserMid": m }).toList(), "syncReason": "AUTO_REPAIR", "checkUserStatusStrictly": checkUserstatusStrictly ?? false })),
      "getContactsV3",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> getFriendDetails(Map param) async {
    return await client.request.request(
      LINEStructs.getFriendDetails_args(LINETypes.getFriendDetails_args.fromJson(param)),
      "getFriendDetails",
      protocolType,
      true,
      requestPath
    );
  }

  Future<dynamic> addFriendByMid(String mid, [String? reference, int trackingMetaType = 5, String? trackingMetaHint]) async {
    return await client.request.request(
      [
        [8, 1, await client.getReqseq()],
        [11, 2, mid],
        [12, 3, [
          [11, 1, reference],
          [12, 2, [[12, trackingMetaType, [[
            11, 1, trackingMetaHint
          ]]]]]
        ]]
      ],
      "addFriendByMid",
      protocolType,
      true,
      requestPath
    );
  }
}