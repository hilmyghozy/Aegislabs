import 'package:flutter/material.dart';

class AppPadding {
  static const page = 8.0;
  static const page2 = 16.0;
  static const page3 = 24.0;
}

class PagePadding extends StatelessWidget {
  const PagePadding(
      {required this.child,
      super.key,
      this.horizontal = true,
      this.vertical = false,
      this.scale = 1.0,
      this.padding = AppPadding.page2});

  final Widget child;
  final bool horizontal;
  final bool vertical;
  final double padding;
  final double scale;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal ? padding * scale : 0,
          vertical: vertical ? padding * scale - 3 : 0,
        ),
        child: child,
      ),
    );
  }
}
