import 'dart:convert';
import 'dart:typed_data';

import 'package:fbthrift/fbthrift.dart';
import 't_framed_transport.dart' as _TFramedTransport;

dynamic readStruct(TCompactProtocol input) {
  Map returnData = {};
  input.readStructBegin();
  while (true) {
    TField begin = input.readFieldBegin();
    int ftype = begin.type;
    int fid = begin.id;
    if (ftype == TType.STOP) {
      break;
    }
    returnData[fid] = readValue(input, ftype);
    input.readFieldEnd();
  }
  input.readStructEnd();
  return returnData;
}

bool isBinary(dynamic bin) {
  String str = utf8.decode(bin);
  if (str.contains('\\u')) {
    return true;
  }
  Uint8List bin2 = Uint8List.fromList(utf8.encode(str));
  return base64.encode(bin) != base64.encode(bin2);
}

dynamic bigInt(Uint8List bin) {
  String str = bin.map((e) => e.toRadixString(16).padLeft(2, '0')).join();
  BigInt bigValue = BigInt.parse(str, radix: 16);

  if (bigValue > BigInt.from(0x7FFFFFFFFFFFFFFF)) {
    return bigValue;
  }

  return bigValue.toInt();
}

dynamic readValue(TCompactProtocol input, int ftype) {
  if (ftype == TType.STRUCT) {
    return readStruct(input);
  } else if (ftype == TType.I32) {
    return input.readI32();
  } else if (ftype == TType.I64) {
    int value = input.readI64();
    final bytes = ByteData(8)..setInt64(0, value, Endian.big);
    return bytes.buffer.asUint8List();
  } else if (ftype == TType.STRING) {
    dynamic bin = input.readBinary();
    if (isBinary(bin)) {
      return bin;
    } else {
      return bin.toString();
    }
  } else if (ftype == TType.LIST) {
    List returnData = [];
    TList ListBegin = input.readListBegin();
    int size = ListBegin.length;
    int etype = ListBegin.elementType;
    for (int _i = 0; _i < size; _i++) {
      returnData.add(readValue(input, etype));
    }
    input.readListEnd();
    return returnData;
  } else if (ftype == TType.MAP) {
    Map returnData = {};
    TMap MapBegin = input.readMapBegin();
    int size = MapBegin.length;
    int ktype = MapBegin.keyType;
    int vtype = MapBegin.valueType;
    for (int _i = 0; _i < size; _i++) {
      dynamic key = readValue(input, ktype);
      dynamic val = readValue(input, vtype);
      returnData[key] = val;
    }
    input.readMapEnd();
    return returnData;
  } else if (ftype == TType.SET) {
    List returnData = [];
    TSet SetBegin = input.readSetBegin();
    int size = SetBegin.length;
    int etype = SetBegin.elementType;
    for (int _i = 0;_i < size; _i++) {
      returnData.add(readValue(input, etype));
    }
    input.readSetEnd();
    return returnData;
  } else if (ftype == TType.BOOL) {
    return input.readBool();
  } else if (ftype == TType.DOUBLE) {
    return input.readDouble();
  } else {
    return;
  }
}

dynamic _readThrift(Uint8List data, dynamic protocol) {
  _TFramedTransport.TFramedTransport bufTrans = _TFramedTransport.TFramedTransport(data, null);
  dynamic proto;
  if (protocol == TCompactProtocol) {
    proto = TCompactProtocol(bufTrans as TTransport);
  } else if (protocol == TBinaryProtocol) {
    proto = TBinaryProtocol(bufTrans as TTransport);
  }
  TMessage msg_info = proto.readMessageBegin();
  dynamic tdata = readStruct(proto);
  proto.readMessageEnd();
  return {'data': tdata, '_info': msg_info};
}

Map readThrift(data, protocol) {
  return _readThrift(data, protocol);
}

dynamic readThriftStruct(Uint8List data, dynamic protocol) {
  _TFramedTransport.TFramedTransport bufTrans = _TFramedTransport.TFramedTransport(data, null);
  dynamic proto;
  if (protocol == TCompactProtocol) {
    proto = TCompactProtocol(bufTrans as TTransport);
  } else if (protocol == TBinaryProtocol) {
    proto = TBinaryProtocol(bufTrans as TTransport);
  }
  return readStruct(proto);
}