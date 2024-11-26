import 'package:aegislabs/common/app/VColor.dart';
import 'package:aegislabs/common/cuppertino/CustomColorSelectionHandle.dart';
import 'package:aegislabs/common/utils/Constant.dart';
import 'package:aegislabs/common/utils/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aegislabs/gen/assets.gen.dart';

class VText extends StatelessWidget {
  final dynamic title;
  final double fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? align;
  final bool money;
  final bool number;
  final bool isItalic;
  final bool isBold;
  final bool isHeadline;
  final bool isUnderline;
  final TextDecoration? decoration;
  final int? maxLines;
  final Color color;
  final bool footer;
  final double? spacing;
  final double? leading;

  const VText(this.title,
      {super.key,
      this.fontSize = 14,
      this.fontWeight,
      this.overflow,
      this.money = false,
      this.number = false,
      this.decoration,
      this.maxLines,
      this.align,
      this.isBold = false,
      this.isItalic = false,
      this.isHeadline = false,
      this.isUnderline = false,
      this.color = VColor.mainWhite,
      this.footer = false,
      this.spacing,
      this.leading});

  @override
  Widget build(BuildContext context) {
    final helpers = Helpers();
    return Text(
      money ? helpers.price(title) : title.toString(),
      style: GoogleFonts.inter(
          color: footer ? VColor.mainWhite : color,
          fontSize: fontSize,
          fontWeight: isBold ? FontWeight.bold : fontWeight,
          decoration: isUnderline ? TextDecoration.underline : decoration,
          decorationColor: isUnderline ? color : null,
          decorationThickness: 1,
          height: leading,
          letterSpacing: spacing,
          fontStyle: isItalic ? FontStyle.italic : FontStyle.normal),
      overflow: overflow ?? TextOverflow.clip,
      textAlign: align ?? TextAlign.start,
      maxLines: maxLines,
    );
  }
}

class VTextButton extends StatelessWidget with Constant {
  const VTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.bgColor = VColor.accent,
    this.padding,
    this.fontSize,
    this.fontWeight,
    this.textColor,
    this.borderRadius,
    this.size,
    this.cancelBtn = false,
    this.margin,
    this.spacing = 0,
    this.disabled = false,
    this.iconNextButton = false,
    this.threeIconNextButton = false,
    this.isOutline,
    this.iconNext,
    this.iconNextHeight,
    this.prefixIcon,
  });

  final Function()? onPressed;
  final dynamic text;
  final Color? bgColor, textColor;
  final EdgeInsets? padding, margin;
  final double? fontSize, borderRadius;
  final FontWeight? fontWeight;
  final Size? size;
  final bool? cancelBtn;
  final double? spacing;
  final bool? disabled;
  final bool? iconNextButton;
  final bool? threeIconNextButton;
  final bool? isOutline;
  final String? iconNext;
  final double? iconNextHeight;
  final Image? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(context),
      decoration: isOutline == true
          ? BoxDecoration(
              border: Border.all(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(12),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: bgColor,
            ),
      child: TextButton(
        onPressed: disabled == true ? null : onPressed,
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          fixedSize: size,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixIcon ?? Container(),
            VText(
              text,
              fontSize: fontSize ?? 12,
              fontWeight: fontWeight ?? FontWeight.w600,
              color: textColor ?? VColor.mainWhite,
              spacing: spacing,
              align: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}

class VInputText extends StatefulWidget {
  final String? hint;
  final InputDecoration? decoration;
  final TextEditingController? controller;
  final bool? secureText;
  final Function(String)? onChanged;
  final Function()? toggleBtn;
  final TextInputType? keyboardType;
  final EdgeInsets? padding;
  final double? width;
  final TextStyle? style;
  final String? errorText;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool autocorrect;
  final int? maxLength;
  final int? maxLines;
  final bool usePattern;
  final bool numberOnly;
  final bool capsOnly;
  final bool enabled;
  final String? helperText;
  final Widget? prefixIcon;

  const VInputText({
    super.key,
    this.hint,
    this.decoration,
    this.controller,
    this.secureText,
    this.onChanged,
    this.keyboardType,
    this.padding,
    this.style,
    this.width,
    this.errorText,
    this.focusNode,
    this.toggleBtn,
    this.readOnly = false,
    this.autocorrect = false,
    this.maxLength,
    this.maxLines = 1,
    this.usePattern = false,
    this.numberOnly = false,
    this.capsOnly = false,
    this.enabled = true,
    this.helperText,
    this.prefixIcon,
  });

  @override
  _VInputText createState() => _VInputText();
}

class _VInputText extends State<VInputText> with Constant, Helpers {
  final textFieldFocusNode = FocusNode();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? getWidth(context),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  maxLength: widget.maxLength,
                  maxLines: widget.maxLines,
                  readOnly: widget.readOnly,
                  autocorrect: widget.autocorrect,
                  focusNode: widget.focusNode,
                  enabled: widget.enabled,
                  inputFormatters: widget.usePattern
                      ? [FilteringTextInputFormatter.digitsOnly]
                      : widget.numberOnly
                          ? [FilteringTextInputFormatter.digitsOnly]
                          : widget.capsOnly
                              ? [UpperCaseTextFormatter()]
                              : [
                                  FilteringTextInputFormatter
                                      .singleLineFormatter
                                ],
                  controller: widget.controller,
                  obscureText: widget.secureText == true ? hidePassword : false,
                  onChanged: (value) {
                    widget.onChanged != null ? widget.onChanged!(value) : () {};
                  },
                  keyboardType: widget.keyboardType,
                  cursorColor: VColor.mainWhite.withOpacity(.50),
                  cursorWidth: 1,
                  style: TextStyle(
                    color: widget.readOnly
                        ? VColor.mainWhite.withOpacity(.50)
                        : VColor.mainWhite,
                  ),
                  selectionControls: CustomColorSelectionHandle(Colors.white),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    helperText: widget.helperText,
                    labelText: widget.hint,
                    labelStyle: widget.style ??
                        TextStyle(
                          color: VColor.mainWhite.withOpacity(.50),
                          fontSize: 16,
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: VColor.black1616.withOpacity(.25)),
                    ),
                    disabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: VColor.secondaryBlack,
                      ),
                    ),
                    fillColor: VColor.black1616,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: widget.prefixIcon != null
                        ? Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: widget.prefixIcon,
                          )
                        : null,
                    prefixIconConstraints:
                        BoxConstraints.loose(Size.fromHeight(25)),
                    suffixIcon: widget.secureText == true
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (widget.secureText == true) {
                                    hidePassword = !hidePassword;
                                    if (textFieldFocusNode.hasPrimaryFocus) {
                                      return;
                                    }

                                    textFieldFocusNode.canRequestFocus = false;
                                  }
                                });
                              },
                              child: Icon(
                                hidePassword == true
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                                size: 20,
                                color: VColor.mainWhite.withOpacity(.80),
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            ],
          ),
          widget.errorText != null ? const SizedBox(height: 4) : Container(),
          widget.errorText != ""
              ? widget.errorText != null
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: VText(
                        widget.errorText ?? "",
                        color: VColor.mainBlack,
                      ),
                    ).paddingOnly(left: 50)
                  : Container()
              : Container(),
        ],
      ),
    );
  }
}

Widget dividerLine(Color color, double width, double height) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(color: color),
  );
}

Widget stackPageAppBar() {
  return Positioned(
    left: 4,
    top: 1,
    child: SafeArea(
      child: IconButton(
        icon: Assets.icons.arrowLeft.svg(),
        color: VColor.mainWhite,
        iconSize: 30,
        onPressed: () {
          Get.back();
        },
      ),
    ),
  );
}
