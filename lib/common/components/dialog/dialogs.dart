import 'package:aegislabs/common/components/dialog/alert_dialog.dart';
import 'package:aegislabs/common/components/dialog/confirmation_dialog.dart';
import 'package:aegislabs/common/extension/context.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

sealed class Dialogs {
  const Dialogs._();

  static Future<bool> showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmText,
    bool isDestructive = false,
  }) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => ConfirmationDialog(
            title: title,
            message: message,
            confirmText: confirmText,
            isDestructive: isDestructive,
          ),
        ) ??
        false;
  }

  static Future<bool> showAlertDialog(
    BuildContext context, {
    required String message,
    required String confirmText,
    bool isDestructive = false,
  }) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => CustomAlertDialog(
            message: message,
            confirmText: confirmText,
            isDestructive: isDestructive,
          ),
        ) ??
        false;
  }
}

showToast({SnackbarType type = SnackbarType.general, required String message}) {
  Get.context!.showSnackBarMessage(type: type, message);
}
