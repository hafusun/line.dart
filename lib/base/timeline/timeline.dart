import "dart:convert";
import "package:http/http.dart" hide BaseClient;
import "../core/utils/error.dart";

import '../../thrift/line_types.dart' as LINETypes;
import "../core/core.dart";

class Timeline {
  BaseClient client;
  String? timelineToken;
  Map timelineHeaders = {};

  Timeline(this.client);

  Future<void> initTimelineToken() async {
    if (timelineToken != null) {
      return;
    }
    timelineToken = LINETypes.ChannelToken.fromJson(await client.channel.approveChannelAndIssueChannelToken({ "channelId": "1341209850" })).channelAccessToken;
    timelineHeaders = {
      "x-line-bdbtemplateversion": "v1",
      "x-lsr": "JP",
      "user-agent": client.request.userAgent,
      "x-line-channeltoken": timelineToken,
      "accept-encoding": "gzip",
      "x-line-global-config": "discover.enable=true; follow.enable=true; reboot.phrase=scenario",
      "x-line-mid": client.profile!.mid,
      "x-line-access": client.authToken,
      "content-type": "application/json; charset=UTF-8",
      "x-line-application": client.request.systemType,
      "x-lal": "ja_JP",
      "x-lpv": "1"
    };
  }

  Future<Map> createPost(String homeId, String? text, [String? sharedPostId, String textSizeMode = "NORMAL", String backgroundColor = "#FFFFFF", String textAnimation = "NONE", String readPermissionType = "ALL", List<String?> readPermissionGids = const [], int? holdingTime, List<String> stickerIds = const [], List<String> stickerPackageIds = const [], List<int> locationLatitudes = const [], List<int> locationLongitudes = const [], List<String> locationNames = const [], List<String> mediaObjectIds = const [], List<String> mediaObjectTypes = const [], String sourceType = "TIMELINE"]) async {
    await initTimelineToken();
    if (homeId[0] == "u") {
      throw InternalError("Timeline Error", "Not support oto");
    }
    String params = Uri(queryParameters: { "homeId": homeId, "sourceType": sourceType }).query;
    dynamic postInfo = {
      "readPermission": {
        "type": readPermissionType,
        "gids": readPermissionGids
      }
    };
    List<Map> stickers= [];
    List<Map> locations = [];
    List<Map> medias = [];
    for (int i = 0; i < stickerIds.length; i++) {
      stickers.add({
        "id": stickerIds[i],
        "packageId": stickerPackageIds[i],
        "packageVersion": 1,
        "hasAnimation": true,
        "hasSound": true,
        "stickerResourceType": "ANIMATION"
      });
    }
    for (int i = 0; i < locationLatitudes.length; i++) {
      locations.add({
        "latitude": locationLatitudes[i],
        "longitude": locationLongitudes[i],
        "name": locationNames[i]
        });
    }
    for (int i = 0; i < mediaObjectIds.length; i++) {
      medias.add({
        "objectId": mediaObjectIds[i],
        "type": mediaObjectTypes[i],
        "obsFace": "[]"
        });
    }

    dynamic contents = {
      "contentsStyle": {
        "textStyle": {
          "textSizeMode": textSizeMode,
          "backgroungColor": backgroundColor,
          "textAnimation": textAnimation
        },
        "mediaStyle": {
          "displayType": "GRID_1_A"
        },
      },
      "stickers": stickers,
      "locations": locations,
      "media": medias
    };
    if (holdingTime != null) {
      postInfo["holdingTime"] = holdingTime;
    }
    if (text != null) {
      contents["text"] = text;
    }
    if (sharedPostId != null) {
      contents["sharedPostId"] = sharedPostId;
    }
    Map data = { "postInfo": postInfo, "contents": contents };
    Map headers = { "x-lhm": "POST" };
    headers.addAll(timelineHeaders);
    Response res =  await client.fetch(
      "https://${client.request.endpoint}/${ homeId[0]  == "s" ? "sn" : "mh"}/api/v57/post/create.json?$params",
      headers: headers as Map<String, String>,
      body: jsonEncode(data),
      method: "POST"
    );
    return await jsonDecode(res.body);
  }

  Future<Map> deletePost(String homeId, String postId) async {
    await initTimelineToken();
    Map headers = { "x-lhm": "GET" };
    headers.addAll(timelineHeaders);
    String params = Uri(queryParameters: { "homeId": homeId, "postId": postId }).query;
    Response res = await client.fetch(
      "https://${client.request.endpoint}/${homeId[0] == "s" ? "sn" : "mh"}/api/v57/post/delete.json?$params",
      headers: headers as Map<String, String>,
      method: "POST"
    );
    return jsonDecode(res.body);
  }

  Future<Map> getPost(String homeId, String postId) async {
    await initTimelineToken();
    Map headers = { "x-lhm": "GET" };
    headers.addAll(timelineHeaders);
    String params = Uri(queryParameters: { "homeId": homeId, "postId": postId }).query;
    Response res = await client.fetch(
      "https://${client.request.endpoint}/${homeId[0] == "s" ? "sn" : "mh"}/api/v57/post/get.json?$params",
      headers: headers as Map<String, String>
    );
    return jsonDecode(res.body);
  }

  Future<Map> listPost(String homeId, [String? postId, int? updatedTime, String sourceType = "TALKROOM"]) async {
    await initTimelineToken();
    Map headers = { "x-lhm": "GET" };
    headers.addAll(timelineHeaders);
    Map<String, dynamic> data = {
      "homeId": homeId,
      "sourceType": sourceType,
      "likeLimit": "0",
      "commentLimit": "0"
    };
    if (postId != null) {
      data["postId"] = postId;
    }
    if (updatedTime != null) {
      data["updatedTime"] = updatedTime;
    }
    String params = Uri(queryParameters: data).query;
    Response res = await client.fetch(
      "https://${client.request.endpoint}/${homeId[0] == "s" ? "sn" : "mh"}/api/v57/post/list.json?$params",
      headers: headers as Map<String, String>
    );
    return jsonDecode(res.body);
  }

  Future<Map> sharePost(String postId, String chatMid, String homeId) async {
    await initTimelineToken();
    Map headers = { "x-lhm": "POST" };
    headers.addAll(timelineHeaders);
    Response res = await client.fetch(
      "https://${client.request.endpoint}/${homeId[0] == "s" ? "sn" : "mh"}/api/v57/post/sendPostToTalk.json?",
      headers: headers as Map<String, String>,
      body: jsonEncode({ "postId": postId, "receiveMids": [chatMid] })
    );
    return jsonDecode(res.body);
  }
}