import 'package:linedart/thrift/line_types.dart' as LINETypes;

import 'package:pointycastle/export.dart';
import 'package:convert/convert.dart';
import 'dart:convert';
import 'dart:typed_data';

Map<String, String> getRSACrypto(String message, LINETypes.RSAKey json) {
  final modulus = BigInt.parse(json.nvalue, radix: 16);
  final exponent = BigInt.parse(json.evalue, radix: 16);
  final keyname = json.keynm;

  final publicKey = RSAPublicKey(modulus, exponent);

  final encryptor = PKCS1Encoding(RSAEngine())
    ..init(true, PublicKeyParameter<RSAPublicKey>(publicKey));

  final inputBytes = Uint8List.fromList(utf8.encode(message));
  final encrypted = _processInBlocks(encryptor, inputBytes);

  final credentials = hex.encode(encrypted);

  return {
    'keyname': keyname,
    'credentials': credentials,
    'message': message,
  };
}


Uint8List _processInBlocks(AsymmetricBlockCipher engine, Uint8List input) {
  final numBlocks = (input.length / engine.inputBlockSize).ceil();
  final output = <int>[];

  for (int i = 0; i < numBlocks; i++) {
    int start = i * engine.inputBlockSize;
    int end = start + engine.inputBlockSize;
    if (end > input.length) end = input.length;

    final block = input.sublist(start, end);
    final processed = engine.process(block);
    output.addAll(processed);
  }

  return Uint8List.fromList(output);
}