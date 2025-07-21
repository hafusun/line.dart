import './base.dart';

class MemoryStorage extends BaseStorage {
  final Map? extendData;

  MemoryStorage({this.extendData});

  Map data = {};

  @override
  Future<void> set(dynamic key, dynamic value) async {
    this.data[key] = value;
  }

  @override
  Future<dynamic> get(dynamic key) async {
    return this.data[key];
  }

  @override
  Future<void> delete(dynamic key) async {
    this.data.remove(key);
  }

  @override
  Future<void> clear() async {
    this.data = {};
  }

  Future<Map> getAll() async {
    return this.data;
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