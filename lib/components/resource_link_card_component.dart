import 'package:bible_app/components/componets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ResourceLinkCardComponent extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final VoidCallback onTap;

  const ResourceLinkCardComponent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(text: title),
                    const Gap(5),
                    LabelText(text: subtitle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
