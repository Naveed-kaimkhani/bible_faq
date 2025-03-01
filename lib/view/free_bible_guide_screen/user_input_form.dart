import 'package:bible_app/components/componets.dart';
import 'package:bible_app/constants/app_svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class UserInputForm extends StatelessWidget {
  const UserInputForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          hintText: "Enter your full name...",
          prefixIcon: svgImage(AppSvgIcons.user),
        ),
        const Gap(10),
        CustomTextField(
          hintText: "Your email address...",
          prefixIcon: svgImage(AppSvgIcons.mail),
        ),
        const Gap(10),
        CustomTextField(
          hintText: "Address",
          prefixIcon: svgImage(AppSvgIcons.homeColorOutlined),
        ),
        const Gap(10),
        CustomTextField(
          hintText: "City, state, Zip code",
          prefixIcon: svgImage(AppSvgIcons.code),
        ),
        const Gap(10),
        CustomTextField(
          hintText: "Phone Number",
          prefixIcon: svgImage(AppSvgIcons.call),
        ),
        const Gap(10),
        CustomTextField(
          hintText:
              "Comments (Optional: You may include WeChat, Viber, Whatsapp etc)",
          prefixIcon: svgImage(AppSvgIcons.messageMultiple),
          maxLines: 2,
          height: 70,
        ),
      ],
    );
  }

  Widget svgImage(String image) => SvgPicture.asset(
        image,
        height: 24,
        width: 24,
        fit: BoxFit.scaleDown,
      );
}
