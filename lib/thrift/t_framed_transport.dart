import 'dart:typed_data';
import 'package:fbthrift/fbthrift.dart';

class TFramedTransport extends TTransport {
  late Uint8List inBuf;
  List<Uint8List> outBuffers = [];
  int outCount = 0;
  int readPos = 0;
  Function? onFlush;
  int? _seqid;

  TFramedTransport(Uint8List buffer, this.onFlush) {
    inBuf = buffer.isEmpty ? Uint8List(0) : buffer;
  }

  static Function receiver(Function callback, int seqid) {
    Uint8List residual = Uint8List(0);

    return (List<int> data) {
      residual = Uint8List.fromList([...residual, ...data]);

      while (residual.isNotEmpty) {
        if (residual.length < 4) {
          return; // Not enough bytes to continue, save and resume on next packet
        }

        int frameSize = _readI32(residual, 0);
        if (residual.length < 4 + frameSize) {
          return; // Not enough bytes to continue, save and resume on next packet
        }

        Uint8List frame = residual.sublist(4, 4 + frameSize);
        residual = residual.sublist(4 + frameSize);

        callback(TFramedTransport(frame, callback), seqid);
      }
    };
  }

  static int _readI32(Uint8List data, int offset) {
    return (data[offset] << 24) |
        (data[offset + 1] << 16) |
        (data[offset + 2] << 8) |
        data[offset + 3];
  }

  @override
  bool get isOpen => true;

  @override
  Future<void> open() async {}

  @override
  Future<void> close() async {
    outBuffers.clear();
    outCount = 0;
  }

  void ensureAvailable(int len) {
    if (readPos + len > inBuf.length) {
      throw InputBufferUnderrunError();
    }
  }

  @override
  int read(Int8List buffer, int offset, int length) {
    ensureAvailable(length);
    buffer.setRange(offset, offset + length, inBuf, readPos);
    readPos += length;
    return length;
  }

  @override
  void write(Int8List buffer, int offset, int length) {
    outBuffers.add(Uint8List.fromList(buffer.sublist(offset, offset + length)));
    outCount += length;
  }

  static void _writeI32(Uint8List data, int offset, int value) {
    data[offset] = (value >> 24) & 0xFF;
    data[offset + 1] = (value >> 16) & 0xFF;
    data[offset + 2] = (value >> 8) & 0xFF;
    data[offset + 3] = value & 0xFF;
  }

  @override
  Future<void> flush([bool? withHeaders]) async {
    int? seqid = _seqid;
    _seqid = null;

    Uint8List out = Uint8List(outCount);
    int pos = 0;
    for (var buf in outBuffers) {
      out.setRange(pos, pos + buf.length, buf);
      pos += buf.length;
    }
    if (onFlush != null && withHeaders != null) {
    if (onFlush != null) {
      Uint8List msg = Uint8List(out.length + 4);
      _writeI32(msg, 0, out.length);
      msg.setRange(4, msg.length, out);

      onFlush!(msg, seqid);
    }

    outBuffers.clear();
    outCount = 0;
  }

  void ensureAvailable(int len) {
    if (readPos + len > inBuf.length) {
      throw InputBufferUnderrunError();
    }
  }
}
}
class InputBufferUnderrunError extends Error {}
