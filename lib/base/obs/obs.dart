import 'dart:convert';
import 'dart:typed_data';
import 'package:fbthrift/fbthrift.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' hide BaseClient;

import 'package:linedart/thrift/readwrite/write.dart';
import 'package:linedart/thrift/line_types.dart' as LINETypes;
import 'package:linedart/base/core/utils/error.dart';
import 'package:linedart/base/core/core.dart';

class ObsMetaData {
  late String status;
  late String name;
  late String mime;
  late String type;
  late String hash;
  late String cksum;
  late dynamic size;
  late int ctimeMillis;
  late ImageDetails? imageDetails;
  late VideoMp4Details? videoMp4Details;
  late AudioM4aDetails? audioM4aDetails;
  late String svc;
  late int offset;
  late String ctime;
  late String oid;
  late String userid;
  late String sid;

  ObsMetaData(this.status, this.name, this.mime, this.type, this.hash, this.cksum, this.size, this.ctimeMillis, this.imageDetails, this.videoMp4Details, this.audioM4aDetails, this.svc, this.offset, this.ctime, this.oid, this.userid, this.sid);

}

class ImageDetails {
  final String format;
  final int height;
  final int width;
  final String signature;

  ImageDetails(this.format, this.height, this.width, this.signature);

}

class VideoMp4Details {
  final int size;
  final int durationMillis;
  final int height;
  final int width;
  final String format;
  final String status;

  VideoMp4Details(this.size, this.durationMillis, this.height, this.width, this.format, this.status);

}

class AudioM4aDetails {
  final int size;
  final int durationMillis;
  final String format;
  final String status;

  AudioM4aDetails(this.size, this.durationMillis, this.format, this.status);

}

class LineObs {
  BaseClient client;
  String prefix = "https://obs.line-apps.com/";
  LineObs(this.client);

  String getMessageDataUrl(String messageId, { bool isPreview = false, bool square = false }) {
    return "${prefix}r/${square ? "g2" : "talk"}/m/$messageId${isPreview ? "/preview" : ""}";
  }

  String getMessageMetadataUrl(String messageId, { bool square = false }) {
    return "${prefix}r/${square ? "g2" : "talk"}/m/$messageId/object_info.obs";
  }

  Future<Map> downloadMessage(String messageId, { bool isPreview = false, bool square = false }) async {
    if (client.authToken == null) {
      throw InternalError("Not setup yet", "Please call 'login()' first");
    }
    Response r = await client.fetch(
      getMessageDataUrl(messageId, isPreview: isPreview, square: square ),
      headers: {
        "accept": "application/json, text/plain, */*",
        "x-line-application": client.request.systemType,
        "x-line-access": client.authToken!
        }
    );
    Map fileInfo = await getMessageObsMetadata(messageId, isSquare: square);
    Uint8List blob = r.bodyBytes;
    String filename = fileInfo["name"];
    return { "fileName": filename, "blob": blob };
  }

  Future<Map> getMessageObsMetadata(String messageId, { bool isSquare = false}) async {
    if (client.authToken == null) {
      throw InternalError("Not setup yet", "Please call 'login()' first");
    }
    Response r = await client.fetch(
      getMessageMetadataUrl(messageId, square: isSquare),
      headers: {
        "accept": "application/json, text/plain, */*",
        "x-line-application" : client.request.systemType,
        "x-Line-access": client.authToken!,
        }
    );
    Map data = Map.from(jsonDecode(r.body));
    return data;
  }

  Future<Map> uploadObjTalk(String to, String type, Uint8List data, [String? oid, String? filename]) async {
    if (client.authToken == null) {
      throw InternalError("Not setup yet", "Please call 'login()' first");
    }
    Map param = {
      "oid": oid ?? "reqSeq",
      "reqseq": oid != null ? null : client.getReqseq("talk").toString(),
      "tomid": oid != null ? null : to,
      "ver": "2.0",
      "name" : "linejs.$type",
      "type": null,
      "cat": null,
      "duration": null
    };
    if (type == "image") {
      param["cat"] = "original";
    } else if (type == "gif") {
      param["cat"] = "original";
      param["type"] = "image";
    } else if (type == "audio" || type == "video") {
      param["duration"] = "1700";
    }
    String toType = to[0] == "m" || to[0] == "t" ? "g2" : "talk";
    return await uploadObjectForService(
      data: data,
      oType: type,
      obsPath: "$toType/m/${oid ?? "reqseq"}",
      filename: param["name"],
      params: param,
    );
  }

  Future<Map> uploadObjectForService({ required Uint8List data, String? oType, String? obsPath, Map? params, String? filename, Map<String, String>? addHeaders }) async {
    String obsPathFinal = "/r/$obsPath";
    oType = (oType ?? "image").toLowerCase();
    filename ??= Uuid().v4();
    params ??= {};
    Map baseParam = {
      "type": oType,
      "ver": "2.0",
      "name": filename,
    };

    params.addAll(baseParam);
    if (data.isEmpty || data.isEmpty) {
      throw InternalError("ObsError", "No data to send.");
    }
    Map<String, String> headers = client.request.getHeader("POST");
    headers["Content-Type"] = "application/octet-stream";
    headers["X-Obs-Params"] = base64.encode(utf8.encode(jsonEncode(params)));
    if (addHeaders != null) {
      headers.addAll(addHeaders);
    }
    Response response = await client.fetch(
      prefix + obsPathFinal,
      method: "POST",
      headers: headers,
      body: data,
    );
    String objId = response.headers.containsKey("x-obs-oid") ? response.headers["x-obs-oid"]! : "";
    String objHash = response.headers.containsKey("x-obs-hash") ? response.headers["x-obs-hash"]! : "";
    return { "objId": objId, "objHash": objHash, "headers": response.headers };
  }

  Future<Uint8List> downloadObjectForService({required String obsPath, required String oid, Map<String, String>? addHeaders}) async {
    if (obsPath.contains("{oid}")) {
      obsPath = obsPath.replaceAll("{oid}", oid);
    } else {
      obsPath = "$obsPath/$oid";
    }
    Map<String, String> headers = client.request.getHeader("GET");
    headers.addAll(addHeaders ?? {});
    String obsPathFinal = "r/$obsPath";
    Response response = await client.fetch(
      prefix + obsPathFinal,
      method: "GET",
      headers: headers,
    );
    return response.bodyBytes;
  }

  Future<Map> uploadMediaByE2EE(Uint8List data, String oType, String to, [String? filename]) async {
    Map typeSet = {
      "image": ["emi", 1],
      "video": ["emv", 2],
      "audio": ["ema", 3],
      "file": ["emf", 14],
      "gif": ["emi", 1],
    };

    String serviceName = "talk";
    List typeSetData = typeSet[oType];
    String obsNamespace = typeSetData[0];
    int contentType = typeSetData[1];
    Map params = { "type": "file" };

    if (oType == "gif") {
      params["cat"] = "original";
    }
    if (to[0] != "u" && to[0] != "c") {
      throw InternalError("ObsError", "Invalid mid, $to");
    }
    Map e2eeMaterial = await client.e2ee.encryptByKeyMaterial(data);
    String keyMaterial = e2eeMaterial["keyMaterial"];
    Uint8List encryptedData = e2eeMaterial["encryptedData"];
    String tempId = "reqid-${Uuid().v4()}";
    Uint8List edata = encryptedData;
    Map uploadResponse = await uploadObjectForService(
      data: edata,
      oType: "file",
      obsPath: "$serviceName/$obsNamespace/$tempId",
      params: params,
    );
    String objId = uploadResponse["objId"];
    if (oType == "image" || oType == "gif" || oType == "video") {
      Map uploadResponse = await uploadObjectForService(
        data: edata,
        oType: "file",
        obsPath: "$serviceName/$obsNamespace/$tempId " "__ud-preview",
        params: params,
      );
      String objId2 = uploadResponse["objId"];
      Map headers = uploadResponse["headers"];
      if (objId == objId2) {
        throw InternalError("ObsError", "objId not match, $headers");
      }
    }

    List chunks = await client.e2ee.encryptE2EEMessage(
      to,
      { "keyMaterial": keyMaterial, "fileName": (filename ?? "linejs.$oType") },
      contentType: LINETypes.ContentType.fromValue(contentType),
    );

    Map contentMetadata = {
        "SID": obsNamespace,
        "OID": objId,
        "FILE_SIZE": edata.length.toString(),
        "e2eeVersion": "2",
      };

      contentMetadata.addAll((oType == "image" || oType == "gif" || oType == "video")
        ? {
          "MEDIA_CONTENT_INFO": jsonEncode({
            "category": "original",
            "fileSize": edata.length,
            "extension": "linejs.$oType",
            "animated": oType == "gif",
          })
        } : {},
      );

    return await client.talk.sendMessage({
      "to": to,
      "chunks": chunks,
      "contentType": LINETypes.ContentType.fromValue(contentType),
      "contentMetadata": contentMetadata,
    });
  }

  Future<dynamic> downloadMediaByE2EE(LINETypes.Message message) async {
    if (message.to[0] != "u" && message.to[0] != "c") {
      throw InternalError("ObsError", "Invalid mid, ${message.to}");
    }
    String id = message.id!;
    Map contentMetadata = message.contentMetadata;
    List chunks = message.chunks!;
    if (chunks.isEmpty) {
      return null;
    }
    Map<dynamic, dynamic>? decryptedData = await client.e2ee.decryptE2EEDataMessage(message);
    dynamic keyMaterial = decryptedData!["keyMaterial"];
    String fileName = decryptedData["fileName"];

    String talkMeta = base64.encode(
      utf8.encode(
        jsonEncode({
          "message": base64.encode(
            writeStruct(
              [[11, 4, id], [15, 27, [12, []]]],
              TBinaryProtocol
            )
          )
        })
      )
    );
    Uint8List data = await downloadObjectForService(
      oid: contentMetadata["OID"]!,
      obsPath: "talk/${contentMetadata["SID"]!}",
      addHeaders: { "X-Talk-Meta" : talkMeta },
    );
    Uint8List blob = await client.e2ee.decryptByKeyMaterial(
      data,
      keyMaterial,
    );

    return { "filename": fileName, "blob": blob };
  }
}