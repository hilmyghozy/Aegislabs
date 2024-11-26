import 'package:aegislabs/core/logger/logger_types.dart';
import 'package:get/get.dart';
import 'package:get_secure_storage/get_secure_storage.dart';

const String STORAGE_ONBOARDING = 'onboarding';
const String STORAGE_TOKEN = 'token';
const String STORAGE_USER = 'user';
const String STORAGE_REGISTER = 'register';
const String STORAGE_LOCATION_PERMISSION = 'locationPermission';
const String STORAGE_AUTH = 'auth_status';

class StorageProvider extends GetxService with ProviderLogger {
  static StorageProvider get to => Get.find();
  late final GetSecureStorage _box;

  Future<StorageProvider> init() async {
    String passwd = 'DADICoffee';
    await GetSecureStorage.init(password: passwd);
    _box = GetSecureStorage(password: passwd);
    return this;
  }

  Future<bool> setString(String key, String value) async {
    try {
      await _box.write(key, value);
      return true;
    } catch (error) {
      loggy.error(error);
      return false;
    }
  }

  Future<bool> setInt(String key, int value) async {
    try {
      await _box.write(key, value);
      return true;
    } catch (error) {
      loggy.error(error);
      return false;
    }
  }

  Future<bool> setBool(String key, bool value) async {
    try {
      await _box.write(key, value);
      return true;
    } catch (error) {
      loggy.error(error);
      return false;
    }
  }

  Future<bool> setList(String key, List<String> value) async {
    try {
      await _box.write(key, value);
      return true;
    } catch (error) {
      loggy.error(error);
      return false;
    }
  }

  String getString(String key) {
    return _box.read(key) ?? '';
  }

  int getInt(String key) {
    return _box.read(key) ?? 000000;
  }

  bool getBool(String key) {
    return _box.read(key) ?? false;
  }

  List<String> getList(String key) {
    return _box.read(key) ?? [];
  }

  Future<bool> remove(String key) async {
    try {
      await _box.remove(key);
      return true;
    } catch (error) {
      return false;
    }
  }
}
