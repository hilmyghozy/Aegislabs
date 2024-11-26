import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

enum SnackbarType { error, success, general, warning }

extension Context on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  Size get screenSize => MediaQuery.sizeOf(this);

  TextTheme get primaryTextTheme => Theme.of(this).primaryTextTheme;

  InputDecorationTheme get inputDecorationTheme =>
      Theme.of(this).inputDecorationTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Brightness get brightness => MediaQuery.of(this).platformBrightness;

  bool get isDarkMode => brightness == Brightness.dark;

  void closeKeyboard() => FocusScope.of(this).unfocus();

  void back() => Navigator.of(this).pop();

  void showSnackBarMessage(
    String? message, {
    SnackbarType type = SnackbarType.general,
  }) {
    final theme = Theme.of(this);
    final Color? foregroundColor;
    final Color? backgroundColor;

    switch (type) {
      case SnackbarType.error:
        {
          foregroundColor = theme.colorScheme.onError;
          backgroundColor = theme.colorScheme.error;
          break;
        }
      case SnackbarType.success:
        {
          foregroundColor = Colors.white;
          backgroundColor = Colors.green[700];
          break;
        }
      case SnackbarType.warning:
        {
          foregroundColor = Colors.white;
          backgroundColor = Colors.amber[700];
          break;
        }
      case SnackbarType.general:
        {
          foregroundColor = Colors.white;
          backgroundColor = Colors.grey[800];
        }
    }
    if (message != null) {
      Flushbar(
        messageText: Text(
          message,
          textAlign: TextAlign.center,
          style: textTheme.bodySmall
              ?.copyWith(color: foregroundColor, fontWeight: FontWeight.w600),
        ),
        margin: const EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        duration: const Duration(seconds: 3),
        flushbarStyle: FlushbarStyle.FLOATING,
        flushbarPosition: FlushbarPosition.TOP,
        messageColor: foregroundColor,
        backgroundColor: backgroundColor ?? Colors.grey[800]!,
      ).show(this);
    }
  }
}
