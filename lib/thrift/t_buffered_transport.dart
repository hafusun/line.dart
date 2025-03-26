import 'dart:typed_data';
import 'package:fbthrift/fbthrift.dart';

class TBufferedTransport extends TTransport {
  static const int defaultReadBufferSize = 1024;
  static const int writeBufferSize = 512;
  late Uint8List inBuf;
  int readCursor = 0;
  int writeCursor = 0;
  List<Uint8List> outBuffers = [];
  int outCount = 0;
  final Function onFlush;

  TBufferedTransport(this.onFlush) {
    inBuf = Uint8List(defaultReadBufferSize);
  }

  @override
  Future<void> close() async {
    outBuffers.clear();
  }

  @override
  Future<void> flush([bool oneway = false]) async {
    if (outCount < 1) {
      return;
    }
    final msg = Uint8List(outCount);
    int pos = 0;
    for (var buf in outBuffers) {
      msg.setRange(pos, pos + buf.length, buf);
      pos += buf.length;
    }

    onFlush(msg);

    outBuffers.clear();
    outCount = 0;
  }

  @override
  bool get isOpen => true;

  @override
  Future<void> open() async {
  }

  @override
  int read(Int8List buffer, int offset, int length) {
    if (readCursor + length > writeCursor) {
      throw Exception('InputBufferUnderrunError');
    }

    buffer.setRange(offset, offset + length, inBuf, readCursor);
    readCursor += length;
    return length;
  }

  @override
  void write(Int8List buffer, int offset, int length) {
    final slice = Uint8List.fromList(buffer.sublist(offset, offset + length));
    outBuffers.add(slice);
    outCount += slice.length;
  }
}
