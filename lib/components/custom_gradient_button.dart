import 'package:bible_app/components/componets.dart';
import 'package:bible_app/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final double? fontSize;
  final FontWeight fontWeight;
  final double height;
  final double width;
  final bool? isShowGradient;
  final EdgeInsetsGeometry? margin;

  const CustomGradientButton({
    super.key,
    required this.text,
    required this.onTap,
    this.fontWeight = FontWeight.w600,
    this.fontSize = 16,
    this.height = 56,
    this.width = double.infinity,
    this.isShowGradient = true,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: isShowGradient == true
              ? const LinearGradient(
                  colors: [AppColors.tealBlue, AppColors.aquaBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isShowGradient == false ? AppColors.tealBlue : null,
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: margin,
        child: Center(
          child: LabelText(
            text: text,
            fontSize: fontSize ?? 16, // Ensure a default font size
            fontWeight: fontWeight,
            textColor: AppColors.white,
          ),
        ),
      ),
    );
  }
}
