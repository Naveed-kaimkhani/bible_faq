import 'package:bible_app/constants/app_colors.dart';
import 'package:bible_app/constants/app_fonts.dart';
import 'package:bible_app/view_model/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LabelText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final Theme? theme;
  final double? fontSize;
  final double? height;
  final TextOverflow? overflow;
  final int? maxLine;
  final Color textColor;
  final TextAlign textAlign;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final bool isChangeTextColor;
  final FontStyle fontStyle;

  const LabelText(
      {super.key,
      required this.text,
      this.overflow,
      this.theme,
      this.fontWeight = FontWeight.w400,
      this.maxLine,
      this.fontSize = AppFontSize.xsmall,
      this.textAlign = TextAlign.start,
      this.textColor = AppColors.black,
      this.decoration = TextDecoration.none,
      this.decorationColor,
      this.height,
      this.isChangeTextColor = true,
      this.fontStyle = FontStyle.normal});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Obx(
      () {
        bool isDarkMode = themeController.isDarkMode.value;
        return Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            color: isChangeTextColor
                ? isDarkMode
                    ? AppColors.white
                    : textColor
                : textColor,
            fontWeight: fontWeight,
            fontSize: fontSize,
            decoration: decoration,
            decorationColor: decorationColor,
            height: height,
            fontStyle: fontStyle,
          ),
          overflow: overflow,
          maxLines: maxLine,
        );
      },
    );
  }
}

class TitleText extends StatelessWidget {
  final String text;
  final FontWeight weight;
  final Theme? theme;
  final double? fontSize;
  final double? height;
  final TextOverflow? overflow;
  final int? maxLine;
  final Color textColor;
  final TextAlign textAlign;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final bool isChangeTextTheme;

  const TitleText({
    super.key,
    required this.text,
    this.overflow,
    this.theme,
    this.weight = FontWeight.w600,
    this.maxLine,
    this.fontSize = AppFontSize.small,
    this.textAlign = TextAlign.start,
    this.textColor = AppColors.black,
    this.decoration = TextDecoration.none,
    this.decorationColor,
    this.height,
    this.isChangeTextTheme = true,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Obx(
      () {
        bool isDarkMode = themeController.isDarkMode.value;
        return LabelText(
          text: text,
          fontWeight: weight,
          fontSize: fontSize,

          // textAlign: textAlign,
          textColor: isChangeTextTheme
              ? isDarkMode
                  ? AppColors.white
                  : textColor
              : textColor,
          // decoration: decoration,
          // decorationColor: decorationColor,

          // height: height,
        );
      },
    );
  }
}
