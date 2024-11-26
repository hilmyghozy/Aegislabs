import 'package:aegislabs/common/provider/config_provider.dart';
import 'package:aegislabs/common/provider/location_provider.dart';
import 'package:aegislabs/common/provider/permission_provider.dart';
import 'package:aegislabs/common/provider/storage_provider.dart';
import 'package:aegislabs/core/repository/auth_repository.dart';
import 'package:aegislabs/core/repository/product_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loggy/loggy.dart';

class MainInitialization {
  static Future init() async {
    await _initProviderAndService();
    _initLogger();
  }

  static Future<void> _initProviderAndService() async {
    //System Provider
    StorageProvider storage = await Get.putAsync<StorageProvider>(
        () => StorageProvider().init(),
        permanent: true);
    Get.put<ConfigProvider>(ConfigProvider(storage: storage), permanent: true);
    PermissionProvider permissionProvider =
        await Get.putAsync<PermissionProvider>(
            () => PermissionProvider().init(),
            permanent: true);

    // bind Repository Controller
    // Get.put<SettingsRepository>(SettingsRepository(), permanent: true);
    Get.put<AuthRepository>(AuthRepository(), permanent: true);
    Get.put<ProductRepository>(ProductRepository(), permanent: true);
    // Get.put<OutletRepository>(OutletRepository(), permanent: true);
    // Get.put<VoucherRepository>(VoucherRepository(), permanent: true);
  }
}

void _initLogger() {
  Loggy.initLoggy(
    logOptions: const LogOptions(
      LogLevel.all,
      stackTraceLevel: LogLevel.warning,
    ),
    logPrinter: const PrettyDeveloperPrinter(),
  );
}
