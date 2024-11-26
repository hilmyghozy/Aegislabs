import 'package:aegislabs/common/app/VColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aegislabs/gen/assets.gen.dart';

// ignore: non_constant_identifier_names
AppBar DefaultAppBar(
  context,
  String? title, {
  Widget? titleWidget,
  Widget? backWidget,
  dynamic action,
  VoidCallback? onBackPressed,
  bool showBackButton = true,
  bool showSearchBar = false,
  String? searchbarHint,
  bool roundedCorner = true,
  Function()? searchTap,
  TextEditingController? searchController,
  Function(String)? searchOnChange,
  Function()? searchSuffixAction,
  Color? backgroundColor = VColor.mainBlack,
  Color? titleColor = VColor.mainWhite,
  Color? backColor = VColor.mainWhite,
}) {
  return AppBar(
      centerTitle: true,
      titleSpacing: 0,
      surfaceTintColor: VColor.red,
      leading: backWidget ??
          (showBackButton
              ? IconButton(
                  icon: Assets.icons.arrowLeft.svg(),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : null),
      leadingWidth: backWidget != null ? 150 : null,
      iconTheme: const IconThemeData(
        color: VColor.secondaryBlack,
        size: 15,
        applyTextScaling: true,
      ),
      backgroundColor: backgroundColor,
      elevation: 0.0,
      title: titleWidget ??
          Container(
            padding: showBackButton
                ? const EdgeInsets.all(0)
                : const EdgeInsets.symmetric(horizontal: 16),
            child: showSearchBar
                ? InkWell(
                    onTap: searchTap,
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: VColor.secondaryBlack,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        autocorrect: false,
                        enabled: searchTap != null ? false : true,
                        controller: searchController,
                        onChanged: searchOnChange,
                        textAlignVertical: TextAlignVertical.top,
                        style: const TextStyle(
                            color: VColor.secondaryBlack, fontSize: 12),
                        cursorColor: VColor.secondaryBlack,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: VColor.secondaryBlack,
                            size: 20,
                          ),
                          prefixIconColor: VColor.mainWhite,
                          hintText: searchbarHint ?? 'lbl_search'.tr,
                          hintStyle: const TextStyle(
                            color: VColor.mainWhite,
                          ),
                        ),
                      ),
                    ),
                  )
                : Text(
                    title ?? "",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: titleColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),
      actions: [action ?? Container()]);
}
