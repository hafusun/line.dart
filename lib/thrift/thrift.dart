import 'rename/parser.dart';
import 'readwrite/read.dart' show readThrift, readThriftStruct;
import 'readwrite/write.dart' show writeThrift;

class Thrift extends ThriftRenameParser {
  Thrift() : super();

  dynamic readThrift(dynamic args) {
    return Function.apply(readThrift, args);
  }

  dynamic readThriftStruct(dynamic args) {
    return Function.apply(readThriftStruct, args);
  }

  dynamic writeThrift(dynamic args) {
    return Function.apply(writeThrift, args);
  }
}
