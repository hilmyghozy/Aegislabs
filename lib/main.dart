import 'dart:async';
import 'package:flutter/services.dart';
import 'package:aegislabs/common/app/VColor.dart';
import 'package:aegislabs/common/app/style.dart';
import 'package:aegislabs/common/utils/localization/localizable.dart';
import 'package:aegislabs/core/logger/logger_types.dart';
import 'package:aegislabs/main_initialization.dart';
import 'package:aegislabs/pages/routes/pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarBrightness: Brightness.dark,
  ));

  await MainInitialization.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.language});
  final Locale? language;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      translations: Localizable(),
      locale: language,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 500),
      initialRoute: AppRoutes.MAIN,
      getPages: AppPages.routes,
      navigatorObservers: [AppPages.observer],
      logWriterCallback: SysLogger().sys,
      builder: (context, child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
    );
  }
}
