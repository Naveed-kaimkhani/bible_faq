import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubscriptionCard extends StatelessWidget {
  final String title;

  const SubscriptionCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Transform.scale(
          scale: .8,
          child: CupertinoSwitch(
            activeTrackColor: AppColors.tealBlue,
            value: true,
            onChanged: (val) {},
          ),
        ),
        title: LabelText(text: title),
      ),
    );
  }
}
