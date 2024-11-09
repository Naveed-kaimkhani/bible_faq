import 'package:bible_faq/constants/constants.dart';
import 'package:flutter/material.dart';

class MainImage extends StatelessWidget {
  const MainImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.resourceImages[0],
      height: 220,
    );
  }
}
