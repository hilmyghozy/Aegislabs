import 'package:aegislabs/common/app/VColor.dart';
import 'package:aegislabs/common/base_controller.dart';
import 'package:aegislabs/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../core/logger/logger_types.dart';
import 'utils/Constant.dart';
import 'utils/Helpers.dart';

abstract class BaseView<T> extends GetView<T> with Constant, Helpers, UiLogger {
  BaseView({super.key});

  @override
  T get ctrl => GetInstance().find<T>(tag: tag)!;

  var themeData = Theme.of(Get.context!);
  var textTheme = Theme.of(Get.context!).textTheme;
  var colorScheme = Theme.of(Get.context!).colorScheme;
  var size = MediaQuery.of(Get.context!).size;
  var isDark = Get.context!.isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        buildView(context),
        if (controller is BaseController)
          Obx(() {
            return (controller as BaseController).isLoading == true
                ? SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Container(
                      color: themeData.colorScheme.onSurface.withOpacity(0.6),
                      child: AnimatedAlign(
                        duration: const Duration(milliseconds: 200),
                        alignment: (controller as BaseController).isLoading
                            ? Alignment.center
                            : Alignment.bottomCenter,
                        child: SizedBox.square(
                            dimension: size.width * 0.25,
                            child: Card(
                              margin: EdgeInsets.zero,
                              surfaceTintColor: themeData.colorScheme.surface,
                              color: themeData.colorScheme.surface,
                              clipBehavior: Clip.hardEdge,
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              child: SizedBox.square(
                                dimension: size.width * 0.20,
                                child: Lottie.asset(
                                  Assets.lottie.loadingAnimation.path,
                                ),
                              ),
                            )),
                      ),
                    ),
                  )
                : const SizedBox.square(
                    dimension: 0,
                  );
          })
      ],
    );
  }

  Widget buildView(BuildContext context) {
    return Container();
  }
}
