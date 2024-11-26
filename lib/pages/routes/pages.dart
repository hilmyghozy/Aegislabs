import 'package:aegislabs/pages/routes/observers.dart';
import 'package:aegislabs/pages/ui/Cart/binding.dart';
import 'package:aegislabs/pages/ui/Cart/page.dart';
import 'package:aegislabs/pages/ui/Checkout/binding.dart';
import 'package:aegislabs/pages/ui/Checkout/page.dart';
import 'package:aegislabs/pages/ui/Home/binding.dart';
import 'package:aegislabs/pages/ui/Home/page.dart';
import 'package:aegislabs/pages/ui/Login/binding.dart';
import 'package:aegislabs/pages/ui/Login/page.dart';
import 'package:aegislabs/pages/ui/ProductDetail/binding.dart';
import 'package:aegislabs/pages/ui/ProductDetail/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static const MAIN = '/main';
  static const PRODUCT_DETAIL = '/productDetail';
  static const CART = '/cart';
  static const LOGIN = '/auth/login';
  static const CHECKOUT = '/checkout';
  static const MESSAGE_DIALOG = '/profile/myinformation';
}

class AppPages {
  static const INITIAL = AppRoutes.MAIN;
  static final RouteObserver<Route> observer = RouteObservers();

  static List<String> history = [];
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.MAIN,
      page: () => HomePage(),
      binding: HomeBinding(),
      // middlewares: [AuthMiddleware(priority: 1)],
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.CART,
      page: () => CartPage(),
      binding: CartBinding(),
    ),
    GetPage(
      name: AppRoutes.PRODUCT_DETAIL,
      page: () => ProductDetailPage(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.CHECKOUT,
      page: () => CheckoutPage(),
      binding: CheckoutBinding(),
    ),
  ];
}
