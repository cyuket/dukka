import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

abstract class LocalDataStorage {
  Future<String?> getEmail();
  Future<void> saveEmail(String token);
  Future<String?> getPassword();
  Future<void> savePassword(String token);
  Future<void> clear();
}

@LazySingleton(as: LocalDataStorage)
class LocalDataStorageImpl implements LocalDataStorage {
  LocalDataStorageImpl(this.storage);

  final FlutterSecureStorage storage;
  @override
  Future<void> clear() async {
    await storage.deleteAll();
  }

  @override
  Future<String?> getEmail() {
    return storage.read(key: email);
  }

  @override
  Future<String?> getPassword() {
    return storage.read(key: password);
  }

  @override
  Future<void> saveEmail(String token) {
    return storage.write(key: email, value: token);
  }

  @override
  Future<void> savePassword(String token) {
    return storage.write(key: password, value: token);
  }
}

const String email = 'email';
const String password = 'password';
