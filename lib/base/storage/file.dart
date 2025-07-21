import 'dart:convert';

import './base.dart';
import 'dart:io';

class FileStorage extends BaseStorage {
  final String path;
  final String? extendData;

  FileStorage(this.path, {this.extendData});

  @override
  Future<void> set(dynamic key, dynamic value) async {
    Map data = await this.getAll();
    data[key] = value;
    final file = File(path);
    await file.writeAsString(jsonEncode(data));
  }

  @override
  Future<dynamic> get(dynamic key) async {
    Map data = await this.getAll();
    return data[key];
  }

  @override
  Future<void> delete(dynamic key) async {
    Map data = await this.getAll();
    data.remove(key);
    final file = File(path);
    await file.writeAsString(jsonEncode(data));
  }

  @override
  Future<void> clear() async {
    final file = File(path);
    await file.writeAsString(jsonEncode({}));
  }

  Future<Map> getAll() async {
    final file = File(path);
    dynamic data = await file.readAsString();
    return jsonDecode(data ?? "{}");
  }

  @override
  Future<void> migrate(BaseStorage storage) async {
    Map kv = await this.getAll();
    for (dynamic key in kv.keys) {
      if (kv.containsKey(key)) {
        dynamic value = kv[key];
        await storage.set(key, value);
      }
    }
  }

}