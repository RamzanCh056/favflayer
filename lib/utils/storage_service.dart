import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageItem {
  StorageItem(this.key, this.value);

  final String key;
  final String value;
}

class StorageService {
  final _secureStorage = const FlutterSecureStorage();
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  IOSOptions _getIOSOptions() => const IOSOptions(synchronizable: true);
  Future<void> writeSecureData(StorageItem newItem) async {
    await _secureStorage.write(
      key: newItem.key,
      value: newItem.value,
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOptions(),
    );
  }

  Future<String?> readSecureData(String key) async {
    var readData = await _secureStorage.read(
      key: key,
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOptions(),
    );
    return readData;
  }

  Future<void> deleteSecureData(item) async {
    await _secureStorage.delete(
      key: item,
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOptions(),
    );
  }

  Future<bool> containsKeyInSecureData(String key) async {
    var containsKey = await _secureStorage.containsKey(
        key: key, aOptions: _getAndroidOptions());
    return containsKey;
  }
}
