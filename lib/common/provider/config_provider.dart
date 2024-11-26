import 'dart:io';

import 'package:aegislabs/common/provider/storage_provider.dart';
import 'package:aegislabs/core/logger/logger_types.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ConfigProvider extends GetxController with ProviderLogger {
  static ConfigProvider get to => Get.find();

  ConfigProvider({required this.storage});

  StorageProvider storage;

  bool skipOnboarding = false;
  bool isLoggedIn = false;

  PackageInfo? _platform;
  AndroidDeviceInfo? androidInfo;
  IosDeviceInfo? iosInfo;
  AppUpdateInfo? _updateInfo;

  String get appName => _platform?.appName ?? '-';
  String appId = "";
  String idTenant = "";
  RxString version = "".obs;

  // var _authStatus = Rx<AuthStatus>(AuthStatus.UNAUTHENTICATED);
  // AuthStatus get authStatus => _authStatus.value;

  @override
  void onInit() async {
    await checkOnboardingState();
    await getPlatform();
    super.onInit();
  }

  Future<void> getPlatform() async {
    _platform = await PackageInfo.fromPlatform();
    appId = _platform?.packageName ?? "";
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
    }
    if (Platform.isIOS) {
      iosInfo = await deviceInfo.iosInfo;
    }
    version.value = _platform?.version ?? "";
  }

  Future<void> checkOnboardingState() async {
    skipOnboarding = storage.getBool(STORAGE_ONBOARDING);
    return;
  }

  Future<void> checkAuthState() async {
    isLoggedIn = storage.getString(STORAGE_TOKEN).isNotEmpty;
    return;
  }

  Future<void> setOnboardingState() async {
    storage.setBool(STORAGE_ONBOARDING, true);
    await checkOnboardingState();
    return;
  }

  Future<bool> isAndroidT() async {
    if (Platform.isAndroid) {
      var deviceInfo = DeviceInfoPlugin();
      androidInfo = await deviceInfo.androidInfo;
      var isT = (androidInfo?.version.sdkInt ?? 0) >= 33;
      return isT;
    }
    return false;
  }

  // void setAuthStatus(AuthStatus status) {
  //   storage.setString(STORAGE_AUTH, status.toString());
  //   _authStatus.value = status;
  // }

  // AuthStatus findStatus(String status) {
  //   var authStatus = AuthStatus.values.firstWhere(
  //       (element) => element.toString() == status,
  //       orElse: () => AuthStatus.UNAUTHENTICATED);
  //   return authStatus;
  // }

  // bool checkAuthStatus() {
  //   var status = storage.getString(STORAGE_AUTH);
  //   _authStatus.value = findStatus(status);

  //   if (_authStatus.value == AuthStatus.PIN_VALIDATED) {
  //     setAuthStatus(AuthStatus.PIN_WAITING);
  //   }
  //   if (_authStatus.value == AuthStatus.PIN_CREATING ||
  //       _authStatus.value == AuthStatus.REGISTRATION_FORM ||
  //       _authStatus.value == AuthStatus.PIN_LOGIN ||
  //       _authStatus.value == AuthStatus.WAITING_OTP) {
  //     setAuthStatus(AuthStatus.UNAUTHENTICATED);
  //   }
  //   return _authStatus.value == AuthStatus.AUTHENTICATED;
  // }
}
