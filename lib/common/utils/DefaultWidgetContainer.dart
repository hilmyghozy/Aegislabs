import 'package:aegislabs/common/app/VColor.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Scaffold DefaultWidgetContainer(
    context, PreferredSizeWidget? appBar, Widget widget,
    {bool safeArea = false,
    bool noAppBar = false,
    Color? color = VColor.mainBlack,
    Color? color2 = VColor.mainBlack,
    Widget? bottom}) {
  return Scaffold(
    appBar: noAppBar ? null : appBar,
    bottomNavigationBar: bottom,
    body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: !safeArea
            ? Container(
                color: color,
                child: widget,
              )
            : Container(
                color: color,
                child: SafeArea(
                  child: Container(
                    color: color,
                    child: widget,
                  ),
                ),
              )),
  );
}
