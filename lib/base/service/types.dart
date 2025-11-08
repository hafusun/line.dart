import 'package:linedart/base/core/core.dart';

abstract class BaseService {
  late final BaseClient client;
  late final int protocolType;
  late final String requestPath;
  late final  String errorName;
}