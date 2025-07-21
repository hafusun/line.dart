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
      final result = struct.indexWhere((e) => e.name == name);
      if (result == -1) {
        return { "name": name, "fid": -1 };
      } else {
        return struct[result];
      }
    } else {
      return { "name": name, "fid": -1 };
    }
  }

  dynamic _fid2name(String structName, String fid) {
    dynamic struct = def[structName];
    if (struct != null && struct is List) {
      final result = struct.firstWhere((e) => e.fid == fid);
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
    for (const fid in object) {
      dynamic value = object[fid];
      dynamic finfo = this._fid2name(structName, fid);
      if (value == null) {
        continue;
      }
      if (finfo.struct != null && finfo.struct is String && (value is Map || value is List)) {
        if (isStruct(this.def[finfo.struct])) {
          newObject[finfo.name] = this.rename_thrift(finfo.struct, value);
        } else if (this.def[finfo.struct] != null) {
          newObject[finfo.name] = (this.def[finfo.struct] as dynamic)[value] ?? value;
        } else {
          newObject[finfo.name] = value;
        }
      } else if (finfo.list != null && finfo.list is String && (value is Map || value is List)) {
          newObject[finfo.name] = [];
          value.forEach((e, i) => {
            newObject[finfo.name][i] = this.rename_thrift(finfo.list, e)
          });
      } else if (finfo.map != null && finfo.map is String && (value is Map || value is List)) {
        newObject[finfo.name] = {};
        for (const key in value) {
          dynamic e = value[key];
          newObject[finfo.name][key] = this.rename_thrift(finfo.map, e);
        }
      } else if (finfo.set != null && finfo.set is String && (value is Map || value is List)) {
        newObject[finfo.name] = [];
        value.forEach((e, i) => {
          newObject[finfo.name][i] = this.rename_thrift(finfo.set, e)
        });
      } else {
        newObject[finfo.name] = value;
      }
    }
    return newObject;
  }

  ParsedThrift rename_data(ParsedThrift data, {bool square = false}) {
    dynamic name = data.info_.name;
    String struct_name = (square ? "SquareService_" : "") + name + "_result";
    data.data = this.rename_thrift(struct_name, data.data);
    return data;
  }
}