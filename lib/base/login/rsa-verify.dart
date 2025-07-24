import '../../../thrift/line_types.dart' as LINETypes;

import 'package:pointycastle/export.dart';
import 'dart:convert';
import 'dart:typed_data';

Map<String, String> getRSACrypto(String message, LINETypes.RSAKey json) {
  final modulus = BigInt.parse(json.nvalue, radix: 16);
  final exponent = BigInt.parse(json.evalue, radix: 16);

  final publicKey = RSAPublicKey(modulus, exponent);

  final encryptor = RSAEngine()
    ..init(true, PublicKeyParameter<RSAPublicKey>(publicKey));

  final inputBytes = Uint8List.fromList(utf8.encode(message));

  final encrypted = encryptor.process(inputBytes);

  final credentials = encrypted.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

  return {
    'keyname': json.keynm,
    'credentials': credentials,
    'message': message,
  };
}
