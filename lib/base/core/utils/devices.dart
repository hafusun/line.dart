typedef Device = String;

enum Devices {
  DESKTOPWIN("DESKTOPWIN"),
  DESKTOPMAC("DESKTOPMAC"),
  ANDROID("ANDROID"),
  IOS("IOS"),
  IOSIPAD("IOSIPAD"),
  WATCHOS("WATCHOS"),
  WEAROS("WEAROS"),
  ;

  const Devices(this.device);

  final String device;
}

class DeviceDetails {
  final Device device;
  final String appVersion;
  final String systemName;
  final String systemVersion;

  DeviceDetails({
    required this.device,
    required this.appVersion,
    required this.systemName,
    required this.systemVersion,
  });

  factory DeviceDetails.fromJson(Map json) {
    return DeviceDetails(
      device: json["device"],
      appVersion: json["appVersion"],
      systemName: json["systemName"],
      systemVersion: json["systemVersion"],
    );
  }
}

bool isV3Support(Device device) {
  return ["DESKTOPWIN", "DESKTOPMAC"].contains(device);
}

DeviceDetails? getDeviceDetails(Device device, String? version) {
  String appVersion;
  String systemName;
  String systemVersion = "12.1.4";

  switch(device) {
    case "DESKTOPWIN":
      appVersion = version ?? "9.2.0.3403";
      systemName = "WINDOWS";
      systemVersion = "10.0.0-NT-x64";
      break;
    case "DESKTOPMAC":
      appVersion = version ?? "9.2.0.3402";
      systemName = "MAC";
      break;
    case "ADROID":
      appVersion = version ?? "13.4.1";
      systemName = "Android OS";
      break;
    case "IOS":
      appVersion = version ?? "13.3.0";
      systemName = "iOS";
      break;
    case "IOSIPAD":
      appVersion = version ?? "13.3.0";
      systemName = "iOS";
      break;
    case "WATCHOS":
      appVersion = version ?? "13.3.0";
      systemName = "Watch OS";
      break;
    case "WEAROS":
      appVersion = version ?? "13.4.1";
      systemName = "Wear OS";
      break;
    default:
      return null;
  }

  return DeviceDetails.fromJson({ "device": device, "appVersion": appVersion, "systemName": systemName, "systemVersion": systemVersion });
}