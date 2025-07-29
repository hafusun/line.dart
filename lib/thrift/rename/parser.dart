import 'dart:convert';
import 'dart:typed_data';

import '../readwrite/declares.dart';

Map TYPE = {
  "STOP": 0,
  "VOID": 1,
  "BOOL": 2,
  "BYTE": 3,
  "I08": 3,
  "DOUBLE": 4,
  "I16": 6,
  "I32": 8,
  "I64": 10,
  "STRING": 11,
  "UTF7": 11,
  "STRUCT": 12,
  "MAP": 13,
  "SET": 14,
  "LIST": 15,
  "UTF8": 16,
  "UTF16": 17
};

String getType(dynamic obj) {
  if (obj!.type == "BaseType") {
    return TYPE[obj.baseType.toUpperCase()];
  } else if (obj!.type == "Identifier") {
    return obj.name;
  } else {
    return "";
  }
}

bool isStruct(dynamic obj) {
  return obj != null && obj is List;
}

class ThriftRenameParser {
  Map def = {};

  dynamic _name2fid(String structName, String, name) {
    dynamic struct = def[structName];
    if (struct != null && struct is List) {
      final result = struct.indexWhere((e) => e["name"] == name);
      if (result == -1) {
        return { "name": name, "fid": -1 };
      } else {
        return struct[result];
      }
    } else {
      return { "name": name, "fid": -1 };
    }
  }

  dynamic _fid2name(String structName, dynamic fid) {
    dynamic struct = def[structName];
    if (struct != null && struct is List) {
      final result = struct.indexWhere((e) => e["fid"] == fid);
      if (result == -1) {
        return { "name": fid, "fid": fid };
      } else {
        return struct[result];
      }
    } else {
      return { "name": fid, "fid": fid };
    }
  }

  dynamic rename_thrift(String structName, dynamic object) {
    dynamic newObject = {};
    if (object is! Map && object is! List) return object;
    if (object is Map) {
      for (dynamic fid in object.keys) {
        dynamic value = object[fid];
        dynamic finfo = _fid2name(structName, fid);
        if (value == null) {
          continue;
        }
        if (finfo["struct"] != null && finfo["struct"] is String && (value is Map || value is List)) {
          if (isStruct(def[finfo["struct"]])) {
            newObject[finfo["name"]] = rename_thrift(finfo["struct"], value);
          } else if (def[finfo["struct"]] != null) {
            newObject[finfo["name"]] = (def[finfo["struct"]] as dynamic)[value] ?? value;
          } else {
            newObject[finfo["name"]] = value;
          }
        } else if (finfo["list"] != null && finfo["list"] is String && value is List) {
            newObject[finfo["name"]] = [];
            for (int i = 0; i < value.length; i++) {
              newObject[finfo["name"]].add(rename_thrift(finfo["list"], value[i]));
            }
        } else if (finfo["map"] != null && finfo["map"] is String && value is Map) {
          newObject[finfo["name"]] = {};
          value.forEach((k, v) {
            newObject[finfo["name"]][k] = rename_thrift(finfo["map"], v);
          });
        } else if (finfo["set"] != null && finfo["set"] is String && (value is Map || value is List)) {
          newObject[finfo["name"]] = [];
          value.forEach((e, i) => {
            newObject[finfo["name"]][i] = rename_thrift(finfo["set"], e)
          });
        } else {
          newObject[finfo["name"]] = value;
        }
      }
    } else if (object is List) {
        for (int fid = 0; fid < object.length; fid++) {
          dynamic value = object[fid];
          dynamic finfo = _fid2name(structName, fid);
          if (value == null) {
            continue;
          }
          if (finfo["struct"] != null && finfo["struct"] is String && (value is Map || value is List)) {
            if (isStruct(def[finfo["struct"]])) {
              newObject[finfo["name"]] = rename_thrift(finfo["struct"], value);
            } else if (def[finfo["struct"]] != null) {
              newObject[finfo["name"]] = (def[finfo["struct"]] as dynamic)[value] ?? value;
            } else {
              newObject[finfo["name"]] = value;
            }
          } else if (finfo["list"] != null && finfo["list"] is String && value is List && value is! Uint8List) {
              newObject[finfo["name"]] = [];
              for (int i = 0; i < value.length; i++) {
                newObject[finfo["name"]].add(rename_thrift(finfo["list"], value[i]));
              }
          } else if (finfo["map"] != null && finfo["map"] is String && value is Map) {
            newObject[finfo["name"]] = {};
            value.forEach((k, v) {
              newObject[finfo["name"]][k] = rename_thrift(finfo["map"], v);
            });
          } else if (finfo["set"] != null && finfo["set"] is String && (value is Map || value is List)) {
            newObject[finfo["name"]] = [];
            value.forEach((e, i) => {
              newObject[finfo["name"]][i] = rename_thrift(finfo["set"], e)
            });
          }  else {
            newObject[finfo["fid"]] = value;
          }
        }
      }
    return newObject;
  }

  Map rename_data(Map data, {bool square = false}) {
    dynamic name = data["_info"]["fname"];
    String structName = "${(square ? "SquareService_" : "") + name}_result";
    data["data"] = rename_thrift(structName, data["data"]);
    return data;
  }
}