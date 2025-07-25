import './base.dart';

class MemoryStorage extends BaseStorage {
  final Map? extendData;

  MemoryStorage({this.extendData});

  Map data = {};

  @override
  Future<void> set(dynamic key, dynamic value) async {
    data[key] = value;
  }

  @override
  Future<dynamic> get(dynamic key) async {
    return data[key];
  }

  @override
  Future<void> delete(dynamic key) async {
    data.remove(key);
  }

  @override
  Future<void> clear() async {
    data = {};
  }

  Future<Map> getAll() async {
    return data;
  }

  @override
  Future<void> migrate(BaseStorage storage) async {
    Map kv = await getAll();
    for (dynamic key in kv.keys) {
      if (kv.containsKey(key)) {
        dynamic value = kv[key];
        await storage.set(key, value);
      }
    }
  }
}