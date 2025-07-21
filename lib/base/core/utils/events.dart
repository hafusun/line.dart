import "../../../thrift/line_types.dart" as LINETypes;

typedef LogType = String;

class LogTypes {
  static const login = "login";
  static const request = "request";
  static const response = "response";
}

class Log {
  final LogType type;
  final dynamic data;

  Log({required this.type, required this.data});
}

typedef Pincall = void Function(String pincode);
typedef Qrcall = void Function(String loginUrl);
typedef ProfileCallback = void Function(LINETypes.Profile user);
typedef StringCallback = void Function(String value);
typedef LogCallback = void Function(Log data);

class ClientEvents {
  Pincall? pincall;
  Qrcall? qrcall;
  ProfileCallback? ready;
  ProfileCallback? end;
  StringCallback? updateAuthtoken;
  ProfileCallback? updateProfile;
  StringCallback? updateCert;
  StringCallback? updateQrcert;
  LogCallback? log;

  ClientEvents({
    this.pincall,
    this.qrcall,
    this.ready,
    this.end,
    this.updateAuthtoken,
    this.updateProfile,
    this.updateCert,
    this.updateQrcert,
    this.log,
  });
}
