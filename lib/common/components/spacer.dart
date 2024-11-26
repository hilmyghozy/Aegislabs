import 'package:aegislabs/common/components/page.dart';
import 'package:flutter/material.dart';

enum CustomSpacerType { vertical, horizontal }

class CustomSpacer extends StatelessWidget {
  const CustomSpacer(
      {this.scale = 1, super.key, this.type = CustomSpacerType.vertical});

  const CustomSpacer.vertical(
      {super.key, this.scale = 1, this.type = CustomSpacerType.vertical});

  const CustomSpacer.horizontal(
      {super.key, this.scale = 1, this.type = CustomSpacerType.horizontal});

  final double scale;
  final CustomSpacerType type;

  @override
  Widget build(BuildContext context) {
    if (type == CustomSpacerType.vertical) {
      return SizedBox(height: AppPadding.page * scale);
    } else {
      return SizedBox(width: AppPadding.page * scale);
    }
  }
}
