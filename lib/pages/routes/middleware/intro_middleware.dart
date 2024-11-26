// import 'package:aegislabs/common/provider/config_provider.dart';
// import 'package:aegislabs/pages/routes/pages.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class IntroMiddleware extends GetMiddleware {
//   @override
//   int? priority = 0;

//   IntroMiddleware({required this.priority});

//   @override
//   RouteSettings? redirect(String? route) {
//     ConfigProvider.to.checkOnboardingState();
//     if (ConfigProvider.to.skipOnboarding == false) {
//       // return const RouteSettings(name: AppRoutes.ONBOARDING);
//       return null;
//     } else {
//       return null;
//     }
//   }

//   @override
//   GetPage? onPageCalled(GetPage? page) {
//     return page;
//   }
// }
