import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aegislabs/common/components/widget/VWidget.dart';
import 'package:aegislabs/gen/assets.gen.dart';

class ModalTitle extends StatelessWidget {
  final String title;
  const ModalTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        VText(
          title,
          fontSize: 24,
          isBold: true,
        ),
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Assets.icons.close.svg(width: 8, height: 8).paddingAll(10),
        )
      ],
    ).marginOnly(
      top: 15,
      bottom: 15,
    );
  }
}
