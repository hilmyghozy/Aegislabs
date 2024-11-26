import 'package:flutter/material.dart';

mixin class Constant {
  double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  getVDevider(double value) {
    return SizedBox(height: value);
  }

  getHDevider(double value) {
    return SizedBox(width: value);
  }
}
