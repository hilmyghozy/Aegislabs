import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aegislabs/common/app/VColor.dart';
import 'package:aegislabs/common/extension/context.dart';

class DraggableSheet extends StatefulWidget {
  final Widget Function(BuildContext, ScrollController) builder;

  const DraggableSheet({
    super.key,
    required this.builder,
  });

  @override
  State<DraggableSheet> createState() => _DraggableSheetState();
}

class _DraggableSheetState extends State<DraggableSheet> {
  final sheet = GlobalKey();
  final controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    controller.addListener(onChanged);
  }

  void onChanged() {
    final currentSize = controller.size;
    if (currentSize <= 0.05) {
      hide();
      Get.back();
    }
  }

  void collapse() => animateSheet(getSheet.snapSizes!.first);
  void anchor() => animateSheet(getSheet.snapSizes!.last);
  void expand() => animateSheet(getSheet.maxChildSize);
  void hide() => animateSheet(getSheet.minChildSize);

  void animateSheet(double size) {
    controller.animateTo(
      size,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  DraggableScrollableSheet get getSheet =>
      (sheet.currentWidget as DraggableScrollableSheet);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DraggableScrollableSheet(
          key: sheet,
          initialChildSize: 0.70,
          maxChildSize: 0.93,
          minChildSize: 0,
          expand: false,
          snap: true,
          snapAnimationDuration: const Duration(milliseconds: 100),
          snapSizes: [0.70],
          controller: controller,
          builder: widget.builder,
        );
      },
    );
  }

  SliverToBoxAdapter topButtonIndicator() {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Wrap(
              children: <Widget>[
                Container(
                  width: 50,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  height: 5,
                  decoration: const BoxDecoration(
                    color: VColor.secondaryWhite,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
