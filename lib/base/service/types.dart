import '../core/core.dart';

abstract class BaseService {
  late BaseClient client;
  late int protocolType;
  late String requestPath;
  late  String errorName;
}