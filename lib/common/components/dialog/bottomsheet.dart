import 'dart:io';
import 'package:aegislabs/common/app/VColor.dart';
import 'package:aegislabs/common/components/page.dart';
import 'package:aegislabs/common/components/spacer.dart';
import 'package:aegislabs/pages/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomBottomSheet {
  var size = MediaQuery.of(Get.context!).size;
  var themeData = Theme.of(Get.context!);

  show(
    BuildContext context, {
    required Widget child,
    ScrollPhysics? physics,
    bool isDismissible = true,
    String? routeName,
    bool removePaddingBottom = false,
    bool removePaddingTop = false,
    String? title = '',
    Function()? actionButton,
  }) {
    if (!kIsWeb && Platform.isIOS) {
      showCupertinoModalBottomSheet(
        context: context,
        useRootNavigator: routeName != null,
        isDismissible: isDismissible,
        settings: routeName != null ? RouteSettings(name: routeName) : null,
        barrierColor: Colors.black54,
        enableDrag: true,
        builder: (context) => Material(
          child: Container(
            color: VColor.black1616,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: physics ?? const ClampingScrollPhysics(),
                controller: ModalScrollController.of(context),
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!removePaddingTop) const CustomSpacer(scale: 2),
                      child,
                      if (!removePaddingBottom) const CustomSpacer(scale: 2),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      showMaterialModalBottomSheet(
        context: context,
        useRootNavigator: routeName != null,
        isDismissible: isDismissible,
        settings: routeName != null ? RouteSettings(name: routeName) : null,
        barrierColor: Colors.black54,
        enableDrag: true,
        builder: (context) => Material(
          child: Container(
            color: VColor.black1616,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: physics ?? const ClampingScrollPhysics(),
                controller: ModalScrollController.of(context),
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!removePaddingTop) const CustomSpacer(scale: 2),
                      child,
                      if (!removePaddingBottom) const CustomSpacer(scale: 2),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  showMessageDialog(
      {String? title,
      required String message,
      Color? messageColor,
      Color? okColor,
      bool showCancel = false,
      String? image,
      String? cancelText,
      bool isDismissible = true,
      String? okText,
      required Function(bool button) onButtonClick}) {
    var route = Get.currentRoute;
    if (AppPages.history.last != AppRoutes.MESSAGE_DIALOG) {
      Get.bottomSheet(
          SafeArea(
            bottom: false,
            child: Wrap(
              children: [
                if (image != null && Platform.isAndroid)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          themeData.colorScheme.surface,
                          themeData.colorScheme.surface,
                          themeData.colorScheme.surface,
                        ],
                      ),
                    ),
                    child: Image.asset(
                      image,
                    ),
                  ),
                Container(
                  decoration: BoxDecoration(
                    color: themeData.colorScheme.surface,
                    borderRadius: image != null && Platform.isAndroid
                        ? null
                        : const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                  ),
                  child: PagePadding(
                    child: Column(
                      children: [
                        const CustomSpacer.vertical(scale: 2),
                        if (title != null)
                          Column(
                            children: [
                              const CustomSpacer.vertical(scale: 1),
                              Text(
                                title,
                                style: Get.context!.textTheme.titleMedium,
                              ),
                            ],
                          ),
                        const CustomSpacer.vertical(scale: 3),
                        PagePadding(
                          child: Center(
                            child: Text(
                              message,
                              textAlign: TextAlign.center,
                              maxLines: 5,
                              style:
                                  Get.context!.textTheme.bodyMedium?.copyWith(
                                fontSize: 13,
                                color: messageColor ??
                                    themeData.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        const CustomSpacer.vertical(scale: 4),
                        SafeArea(
                          child: Container(
                            color: themeData.colorScheme.surface,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (showCancel)
                                  Expanded(
                                    child: SizedBox(
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                          onButtonClick.call(false);
                                        },
                                        clipBehavior: Clip.hardEdge,
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          backgroundColor: themeData
                                              .colorScheme.tertiaryContainer,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          (cancelText ?? 'Cancel')
                                              .toUpperCase(),
                                          textAlign: TextAlign.center,
                                          maxLines: 5,
                                          style: Get
                                              .context!.textTheme.bodyMedium
                                              ?.copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: themeData.colorScheme
                                                .onTertiaryContainer,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                  height: 55,
                                  width: showCancel
                                      ? MediaQuery.of(Get.context!).size.width *
                                          0.037
                                      : 0,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                        onButtonClick.call(true);
                                      },
                                      clipBehavior: Clip.hardEdge,
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        backgroundColor:
                                            themeData.colorScheme.primary,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        (okText ?? 'Confirm').toUpperCase(),
                                        textAlign: TextAlign.center,
                                        maxLines: 5,
                                        style: Get.context!.textTheme.bodyMedium
                                            ?.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              themeData.colorScheme.onPrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const CustomSpacer.vertical(scale: 2),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          isDismissible: isDismissible,
          useRootNavigator: true,
          settings: const RouteSettings(name: AppRoutes.MESSAGE_DIALOG));
    }
  }

  void showList(
      {required Widget child,
      required String title,
      Color? bgColor,
      ScrollPhysics? physics}) {
    showBarModalBottomSheet(
      context: Get.context!,
      useRootNavigator: true,
      barrierColor: Colors.black54,
      backgroundColor: bgColor ?? themeData.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => Material(
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: const SizedBox(),
            middle: Text(
              title,
              style: Get.context!.textTheme.titleMedium,
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: physics ?? const ClampingScrollPhysics(),
              controller: ModalScrollController.of(context),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomSpacer.vertical(scale: 1),
                    child,
                    const CustomSpacer.vertical(scale: 2),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  baseBottomSheet({required Widget child}) {
    return Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomSpacer.vertical(scale: 1),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: themeData.colorScheme.secondaryContainer,
            ),
            width: 48,
            height: 8,
          ),
          child
        ],
      ),
      backgroundColor: themeData.scaffoldBackgroundColor,
      elevation: 0,
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: true,
      ignoreSafeArea: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      clipBehavior: Clip.hardEdge,
    );
  }

  // CountryPicker({required CountryPickerObject selected}) {
  //   return Get.bottomSheet(
  //     SafeArea(child: CountryPickerPage(selected)),
  //     backgroundColor: themeData.scaffoldBackgroundColor,
  //     elevation: 0,
  //     enableDrag: false,
  //     isDismissible: true,
  //     isScrollControlled: true,
  //     ignoreSafeArea: false,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(0),
  //     ),
  //     clipBehavior: Clip.hardEdge,
  //   );
  // }
}
