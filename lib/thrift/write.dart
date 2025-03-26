import 'dart:convert';
import 'dart:typed_data';
import 'package:fbthrift/fbthrift.dart';
import 'types.dart';
import 't_buffered_transport.dart';
import 'package:fixnum/fixnum.dart';

Uint8List writeThrift(List<List> value, String name, protocol) {
  final builder = BytesBuilder();
  var buftra = TBufferedTransport((inBuf) {
    builder.add(inBuf);
  });
  dynamic myprot;
  if (protocol == TCompactProtocol) {
    myprot = TCompactProtocol(buftra as TTransport);
  } else if (protocol == TBinaryProtocol) {
    myprot = TBinaryProtocol(buftra as TTransport);
  }
  _writeStruct(myprot, value);
  buftra.flush();
  Uint8List myBuf = builder.toBytes();
  if (myBuf.length == 1 && myBuf[0] == 0) {
    myBuf = Uint8List.fromList([]);
  }
  Uint8List writedBinary = Uint8List.fromList([
    ...genHeader[protocol]!(name),
    ...myBuf,
    0,
  ]);
  return writedBinary;
}

Uint8List writeStruct(List<List> value, dynamic protocol) {
  final builder = BytesBuilder();
  TBufferedTransport buftra = TBufferedTransport(
    (inBuf) => builder.add(inBuf),
  );
  dynamic myprot = protocol(buftra);
  _writeStruct(myprot, value);
  Uint8List myBuf = builder.toBytes();
  if (myBuf.length == 1 && myBuf[0] == 0) {
    myBuf = Uint8List.fromList([]);
  }
  return myBuf;
}

void _writeStruct(dynamic output, List value) {
  if (value.isEmpty) return;

  output.writeStructBegin(TStruct(''));

  for (var e in value) {
    if (e == null) {
      return;
    }
    writeValue(output, e[0], e[1], e[2]);
  }

  output.writeFieldStop();
  output.writeStructEnd();
}

void writeValue(dynamic output, int ftype, int fid, val) {
  if (val == null) {
    return;
  }

  switch(ftype) {
    case TType.STRING:
      if (val is Uint8List) {
        output.writeFieldBegin(TField('', TType.STRING, fid));
        output.writeBinary(val, val.length);
        output.writeFieldEnd();
      } else {
        if (val is! String) {
          throw ArgumentError('ftype=$ftype: value is not string');
        }
        output.writeFieldBegin(TField('', TType.STRING, fid));
        output.writeBinary(Uint8List.fromList(val.codeUnits));
        output.writeFieldEnd();
      }
      break;
    case TType.DOUBLE:
      if (val is! int) {
        throw ArgumentError('ftype=$ftype: value is not number');
      }
      output.writeFieldBegin(TField('', TType.DOUBLE, fid));
      output.writeDouble(val.toDouble());
      output.writeFieldEnd();
      break;
    case TType.I64:
      if (val is BigInt) {
          output.writeFieldBegin(TField('', TType.I64, fid));
          output.writeI64(Int64(val.toInt()).toInt());
          output.writeFieldEnd();
      } else if (val is! int) {
        throw ArgumentError('ftype=$ftype: value is not number');
      } else {
        output.writeFieldBegin(TField('', TType.I64, fid));
        output.writeI64(val);
        output.writeFieldEnd();
      }
      break;
    case TType.I32:
      if (val is! int) {
        throw ArgumentError('ftype=$ftype: value is not number');
      }
      output.writeFieldBegin(TField('', TType.I32, fid));
      output.writeI32(Int32(val.toInt()).toInt());
      output.writeFieldEnd();
      break;
    case TType.BOOL:
      if (val is! bool && val is! int) {
        throw ArgumentError('ftype=$ftype: value is not boolean');
      }
      output.writeFieldBegin(TField('', TType.BOOL, fid));
      output.writeBool(bool.parse(val.toString()));
      output.writeFieldEnd();
      break;
    case TType.STRUCT:
      if (val is! List) {
        throw ArgumentError('ftypr=$ftype: value is not struct');
      }
      if (val.isEmpty) {
        return;
      }
      output.writeFieldBegin(TField('', TType.STRUCT, fid));
      _writeStruct(output, val);
      output.writeFieldEnd();
      break;
    case TType.MAP:
      val = val as List<dynamic>;
      if (!val[2]) {
        return;
      }
      output.writeFieldBegin(TField('', TType.MAP, fid));
      output.writeMapBegin(TMap(val[0], val[1], (val[2]).length));
      for (dynamic kiter in val[2]) {
        if ((val[2]).containsKey(kiter)) {
          dynamic viter = val[2][kiter];
          writeValue_(output, val[0], kiter);
          writeValue_(output, val[1], viter);
        }
      }
      output.writeMapEnd();
      output.writeFieldEnd();
      break;
    case TType.LIST:
      val = val as List;
      if (!val[1]) {
        return;
      }
      output.writeFieldBegin(TField('', TType.LIST, fid));
      output.writeListBegin(TList(val[0], (val[1]).length));
      for (dynamic iter in val[1] as dynamic) {
        if ((val[1]).containsKey(iter)) {
          writeValue_(output, val[0], val[1][iter]);
        }
      }
      output.writeListEnd();
      output.writeFieldEnd();
      break;
    case TType.SET:
      val = val as List;
      if (!val[1]) {
        return;
      }
      output.writeFieldBegin(TField('', TType.SET, fid));
      output.writeSetBegin(TSet(val[0], (val[1]).length));
      for (dynamic iter in val[1]) {
        if ((val[1]).containsKey(iter)) {
          writeValue_(output, val[0], val[1][iter]);
        }
      }
      output.writeSetEnd();
      output.writeFieldEnd();
      break;
    default:
      break;
  }
}

void writeValue_(TCompactProtocol output, int ftype, val) {
  if (val == null) {
    return;
  }
  switch (ftype) {
    case TType.STRING:
      if (val is Uint8List) {
        output.writeBinary(val);
      } else {
        if (val is! String) {
          throw ArgumentError('ftype=$ftype: value is not string');
        }
        output.writeString(val.toString());
      }
      break;
    case TType.DOUBLE:
      if (val is! int) {
        throw ArgumentError('ftype=$ftype: value is not number');
      }
      output.writeDouble(val.toDouble());
      break;
    case TType.I64:
      if (val is! int) {
        throw ArgumentError('ftype=$ftype: value is not number');
      }
      output.writeI64(Int64(val.toInt()).toInt());
      break;
    case TType.I32:
      if (val is! int) {
        throw ArgumentError('ftype=$ftype: value is not number');
      }
      output.writeI32(Int32(val.toInt()).toInt());
      break;
    case TType.BOOL:
      if (val is! bool) {
        throw ArgumentError('ftype=$ftype: value is not boolean');
      }
      output.writeBool(val);
      break;
    case TType.STRUCT:
      if (val is! List) {
        throw ArgumentError('ftype=$ftype: value is not struct');
      }
      _writeStruct(output, val as List<List>);
  }
}