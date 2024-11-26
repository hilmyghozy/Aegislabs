import 'dart:math';

import 'package:aegislabs/common/base_controller.dart';
import 'package:aegislabs/common/extension/context.dart';
import 'package:aegislabs/core/repository/auth_repository.dart';
import 'package:aegislabs/pages/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final AuthRepository authRepo = Get.find();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    username.text = 'mor_2314';
    password.text = '83r5^_';
  }

  void login() async {
    try {
      setLoading(true);
      final result = await authRepo.login(payload: {
        "username": username.text,
        "password": password.text,
      });
      result.fold((l) {
        setLoading(false);
        Get.context!
            .showSnackBarMessage(l.errorMessage, type: SnackbarType.error);
      }, (r) {
        Get.context!
            .showSnackBarMessage("Login Success", type: SnackbarType.success);
        Get.offAllNamed(AppRoutes.MAIN);
        setLoading(false);
      });
    } catch (e) {
      setLoading(false);
      loggy.error("login >> $e");
    }
  }
}
