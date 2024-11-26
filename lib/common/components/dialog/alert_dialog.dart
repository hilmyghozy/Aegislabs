import 'dart:io';

import 'package:aegislabs/common/components/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    required this.message,
    required this.confirmText,
    required this.isDestructive,
    super.key,
  });

  final String message;
  final String confirmText;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return !kIsWeb && Platform.isIOS
        ? _IosAlertDialog(
            message: message,
            confirmText: confirmText,
            isDestructive: isDestructive,
          )
        : _AndroidAlertDialog(
            message: message,
            confirmText: confirmText,
            isDestructive: isDestructive,
          );
  }
}

class _AndroidAlertDialog extends StatelessWidget {
  const _AndroidAlertDialog({
    required this.message,
    required this.confirmText,
    required this.isDestructive,
  });

  final String message;
  final String confirmText;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomSpacer(
            scale: 3,
          ),
          Text(message),
        ],
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: isDestructive
                ? context.theme.colorScheme.error
                : context.theme.colorScheme.onSurface,
          ),
          onPressed: () => Get.back(result: true),
          child: Text(confirmText, style: context.textTheme.titleSmall),
        ),
      ],
    );
  }
}

class _IosAlertDialog extends StatelessWidget {
  const _IosAlertDialog({
    required this.message,
    required this.confirmText,
    required this.isDestructive,
  });

  final String message;
  final String confirmText;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    const OutlinedBorder buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    );

    return CupertinoAlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomSpacer(
            scale: 2,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
          ),
          const CustomSpacer(),
        ],
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: isDestructive
                ? context.theme.colorScheme.error
                : context.theme.colorScheme.onSurface,
            shape: buttonShape,
          ),
          onPressed: () => Get.back(result: true),
          child: Text(confirmText, style: context.textTheme.titleSmall),
        ),
      ],
    );
  }
}
