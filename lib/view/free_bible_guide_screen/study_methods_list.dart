import 'package:bible_faq/view/free_bible_guide_screen/free_bible_guide_screen.dart';
import 'package:flutter/material.dart';

class StudyMethodsList extends StatelessWidget {
  const StudyMethodsList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StudyMethod(
            number: 1,
            title: "Exhaustive Topical Bible Study",
            description:
                "Dive deep into specific topics and explore what the Bible says about them."),
        StudyMethod(
            number: 2,
            title: "Study of Symbolic Language",
            description:
                "Understand the rich symbolism used throughout the Bible to reveal spiritual truths."),
        StudyMethod(
            number: 3,
            title: "Study by Time Frame",
            description:
                "Learn how events in the Bible are connected by their historical and prophetic timelines."),
        StudyMethod(
            number: 4,
            title: "Study by Context",
            description:
                "Discover how understanding the context of a passage can deepen its meaning."),
        StudyMethod(
            number: 5,
            title: "Study by Type and Antitype",
            description:
                "See how Old Testament events and figures foreshadow the New Testament revelations."),
      ],
    );
  }
}
