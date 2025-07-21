import 'dart:typed_data';
import 'package:fbthrift/fbthrift.dart';

Map<dynamic, List<int> Function(String)> genHeader = {
  TBinaryProtocol: (String name) {
    List<int> result = [
      0x80,
      1,
      0,
      1,
      0,
      0,
      0,
      name.length,
    ];
    result.addAll(Uint8List.fromList(name.codeUnits));
    result.addAll([0, 0, 0, 0]);
    return result;
  },
  TCompactProtocol: (String name) {
    List<int> result = [0x82, 0x21, 0, name.length];
    result.addAll(Uint8List.fromList(name.codeUnits));
    return result;
  },
};

Map Protocols = {
  4: TCompactProtocol,
  3: TBinaryProtocol
};

class ParsedThrift {
  dynamic data;
  final TMessage info_;

  ParsedThrift({
    required this.data,
    required this.info_
  });
}