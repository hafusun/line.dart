import 'dart:typed_data';
import 'rename/parser.dart';
import './readwrite/write.dart' as Write;
import './readwrite/read.dart' as Read;

class Thrift extends ThriftRenameParser {
  Thrift() : super();

  dynamic readThrift(List args) {
    return Function.apply(Read.readThrift, args);
  }

  dynamic readThriftStruct(Uint8List data, [dynamic protocol]) {
    return Function.apply(Read.readThriftStruct, [data, protocol]);
  }

  dynamic writeThrift(List args) {
    return Function.apply(Write.writeThrift, args);
  }
}
