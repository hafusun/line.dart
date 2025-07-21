class Storage {
  final String Key;
  final dynamic value;

  Storage(this.Key, this.value);

}

abstract class BaseStorage {
  Future<void> set(String key, dynamic value);

  Future<dynamic> get(String key);

  Future<void> delete(String key);

  Future<void> clear();

  Future<void> migrate(BaseStorage storage);
}
