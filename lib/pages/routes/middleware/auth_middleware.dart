import 'package:aegislabs/common/provider/config_provider.dart';
import 'package:aegislabs/pages/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? priority = 0;

  AuthMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
//     // var autStatus = ConfigProvider.to.authStatus;

//     // switch (autStatus) {
//     //   case AuthStatus.AUTHENTICATING:
//     //     return null;
//     //   case AuthStatus.UNAUTHENTICATED:
//     //     return null;
//     //   case AuthStatus.WAITING_OTP:
//     //     return const RouteSettings(name: AppRoutes.VERIFY_CODE);
//     //   case AuthStatus.AUTHENTICATED:
//     //   case AuthStatus.PIN_WAITING:
//     //     return const RouteSettings(name: AppRoutes.CREATE_PIN);
//     //   case AuthStatus.PIN_CREATING:
//     //     return const RouteSettings(name: AppRoutes.CREATE_PIN);
//     //   case AuthStatus.REGISTRATION_FORM:
//     //     return const RouteSettings(name: AppRoutes.REGISTER);
//     //   case AuthStatus.PIN_LOGIN:
//     //     return const RouteSettings(name: AppRoutes.LOGIN_PIN);
//     //   case AuthStatus.PIN_FORGOT:
//     //   case AuthStatus.PIN_CHANGE:
//     //     return RouteSettings(name: AppRoutes.CREATE_PIN);
//     //   default:
//     //     return null;
//     // }

    ConfigProvider.to.checkAuthState();
    if (ConfigProvider.to.isLoggedIn == false) {
      return const RouteSettings(name: AppRoutes.LOGIN);
    } else {
      return null;
    }
  }

//   @override
//   GetPage? onPageCalled(GetPage? page) {
//     return page;
//   }
}
