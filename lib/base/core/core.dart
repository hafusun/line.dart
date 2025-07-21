import "utils/devices.dart";
import "typed-event-emitter/emitter.dart";
import "utils/events.dart";
import "utils/error.dart";
import '../../thrift/thrift.dart';
import '../storage/base.dart';
import '../../thrift/line_types.dart' as LINETypes;
import '../e2ee/e2ee.dart';

class BaseClient extends TypedEventEmitter {
  String? authToken;
  Device device;
  Thrift thrift;
  BaseStorage storage;
  E2EE e2ee;

  LINETypes.Profile? profile;
  DeviceDetails deviceDetails;

  String endpoint;

  BaseClient({
    this.authToken,
    required this.device,
    required this.thrift,
    required this.storage,
    required this.e2ee,
    this.profile,
    required this.deviceDetails,
    required this.endpoint,
  });
}