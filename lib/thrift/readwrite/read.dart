import 'dart:convert';
import 'dart:typed_data';

import 'package:fbthrift/fbthrift.dart';
import 'package:linedart/thrift/transport/t_framed_transport.dart' as TFramedTransport;

dynamic readStruct(dynamic input) {
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
  String str;
  try {
    str = utf8.decode(Uint8List.fromList(bin));
  } catch(e) {
    return true;
  }
  if (str.contains('\\u')) {
    return true;
  }
  Uint8List bin2 = Uint8List.fromList(utf8.encode(str));
  return base64.encode(Uint8List.fromList(utf8.encode(str))) != base64.encode(bin2);
}

dynamic bigInt(Uint8List bin) {
  String str = bin.map((e) => e.toRadixString(16).padLeft(2, '0')).join();
  BigInt bigValue = BigInt.parse(str, radix: 16);

  if (bigValue > BigInt.from(0x7FFFFFFFFFFFFFFF)) {
    return bigValue;
  }

  return bigValue.toInt();
}

dynamic readValue(dynamic input, int ftype) {
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
      return Uint8List.fromList(bin);
    } else {
      return utf8.decode(Uint8List.fromList(List.from(bin)));
    }
  } else if (ftype == TType.LIST) {
    List returnData = [];
    TList ListBegin = input.readListBegin();
    int size = ListBegin.length;
    int etype = ListBegin.elementType;
    for (int i = 0; i < size; i++) {
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
    for (int i = 0; i < size; i++) {
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
    for (int i = 0;i < size; i++) {
      returnData.add(readValue(input, etype));
    }
    input.readSetEnd();
    return returnData;
  } else if (ftype == TType.BOOL) {
    return input.readBool();
  } else if (ftype == TType.DOUBLE) {
    return input.readDouble();
  } else {
    skip(input, ftype);
    return;
  }
}

dynamic _readThrift(Uint8List data, dynamic protocol) {
  TFramedTransport.TFramedTransport bufTrans = TFramedTransport.TFramedTransport(data, null);
  dynamic proto;
  if (protocol == TCompactProtocol) {
    proto = TCompactProtocol(bufTrans as TTransport);
  } else if (protocol == TBinaryProtocol) {
    proto = TBinaryProtocol(bufTrans as TTransport);
  }
  TMessage msgInfo = proto.readMessageBegin();
  dynamic tdata = readStruct(proto);
  proto.readMessageEnd();
  return {'data': tdata, '_info': parseTMessage(msgInfo)};
}

Map readThrift(data, protocol) {
  return _readThrift(data, protocol);
}

dynamic readThriftStruct(Uint8List data, dynamic protocol) {
  TFramedTransport.TFramedTransport bufTrans = TFramedTransport.TFramedTransport(data, null);
  dynamic proto;
  if (protocol == null || protocol == TCompactProtocol) {
    proto = TCompactProtocol(bufTrans as TTransport);
  } else if (protocol == TBinaryProtocol) {
    proto = TBinaryProtocol(bufTrans as TTransport);
  }
  return readStruct(proto);
}

Map parseTMessage(TMessage message) {
  return { 'fname': message.name, 'mtype': message.type, 'rseqid': message.seqid };
}

skip(dynamic iprot, int ftype) async {
  switch (ftype) {
    case TType.BOOL:
      await iprot.readBool();
      break;
    case TType.BYTE:
      await iprot.readByte();
      break;
    case TType.I16:
      await iprot.readI16();
      break;
    case TType.I32:
      await iprot.readI32();
      break;
    case TType.I64:
      await iprot.readI64();
      break;
    case TType.DOUBLE:
      await iprot.readDouble();
      break;
    case TType.STRING:
      await iprot.readString();
      break;
    case TType.STRUCT:
      final struct = await iprot.readStructBegin();
      while (true) {
        final field = await iprot.readFieldBegin();
        if (field.type == TType.STOP) break;
        await skip(iprot, field.type);
        await iprot.readFieldEnd();
      }
      await iprot.readStructEnd();
      break;
    case TType.MAP:
      final mapMeta = await iprot.readMapBegin();
      for (int i = 0; i < mapMeta.size; i++) {
        await skip(iprot, mapMeta.keyType);
        await skip(iprot, mapMeta.valueType);
      }
      await iprot.readMapEnd();
      break;
    case TType.SET:
    case TType.LIST:
      final listMeta = await iprot.readListBegin();
      for (int i = 0; i < listMeta.size; i++) {
        await skip(iprot, listMeta.elementType);
      }
      await iprot.readListEnd();
      break;
    default:
      throw Exception("Unknown type: $ftype");
  }
}
