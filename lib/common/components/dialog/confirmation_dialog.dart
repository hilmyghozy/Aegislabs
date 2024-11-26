import 'dart:io';

import 'package:aegislabs/common/components/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    required this.title,
    required this.message,
    required this.confirmText,
    required this.isDestructive,
    super.key,
  });

  final String title;
  final String message;
  final String confirmText;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return !kIsWeb && Platform.isIOS
        ? _IosConfirmationDialog(
            title: title,
            message: message,
            confirmText: confirmText,
            isDestructive: isDestructive,
          )
        : _AndroidConfirmationDialog(
            title: title,
            message: message,
            confirmText: confirmText,
            isDestructive: isDestructive,
          );
  }
}

class _AndroidConfirmationDialog extends StatelessWidget {
  const _AndroidConfirmationDialog({
    required this.title,
    required this.message,
    required this.confirmText,
    required this.isDestructive,
  });

  final String title;
  final String message;
  final String confirmText;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomSpacer(
            scale: 3,
          ),
          Text(message),
          const CustomSpacer(),
        ],
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: context.theme.colorScheme.onSurface,
          ),
          onPressed: () => Get.back(),
          child: Text('Cancel', style: context.textTheme.titleSmall),
        ),
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

class _IosConfirmationDialog extends StatelessWidget {
  const _IosConfirmationDialog({
    required this.title,
    required this.message,
    required this.confirmText,
    required this.isDestructive,
  });

  final String title;
  final String message;
  final String confirmText;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    const OutlinedBorder buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    );

    return CupertinoAlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomSpacer(
            scale: 3,
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
            foregroundColor: context.theme.colorScheme.onSurface,
            shape: buttonShape,
          ),
          onPressed: () => Get.back(),
          child: Text('Cancel', style: context.textTheme.titleSmall),
        ),
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
