import 'dart:io'; // ファイル操作のためにdart:ioをインポート
import 'package:fbthrift/fbthrift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linedart/thrift/readwrite/read.dart';
import 'package:linedart/thrift/readwrite/write.dart';

void main() {
  test('encode thrift', () async {
    // テスト結果を取得
    final result = writeThrift(
      [[12, 1, [[2, 1, true], [2, 2, true]]], [8, 2, 7]],
      "getAllChatMids",
      TCompactProtocol,
    );

    // ファイルに書き出し
    final file = File('output.bin');
    await file.writeAsBytes(result);

    final read = readThrift(await file.readAsBytes(), TCompactProtocol);
    final rfile = File('read.txt');
    await rfile.writeAsString('$read');
    print('${read['data']}');

    // デバッグ用にコンソールにも出力
    debugPrint(result.toString());
  });
}
