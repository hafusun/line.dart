import './mime.dart';
import '../../thrift/line_types.dart' as LINETypes;
import '../../thrift/readwrite/struct.dart';
import '../core/utils/error.dart';
import '../core/core.dart';

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
    return this.prefix + "r/" + (square ? "g2" : "talk") + "/m/" + messageId + (isPreview ? "/preview" : "");
  }

  String getMessageMetadataUrl(String messageId, { bool square = false }) {
    return this.prefix + "r/" + (square ? "g2" : "talk") + "/m/" + messageId + "/object_info.obs";
  }
}