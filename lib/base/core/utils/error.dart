class InternalError implements Exception {
  final String type;
  final String message;
  final Map<String, dynamic> data;

  InternalError(
    this.type,
    this.message, [
    Map<String, dynamic>? data,
  ]) : data = data ?? {};

  @override
  String toString() => '$type: $message';
}
