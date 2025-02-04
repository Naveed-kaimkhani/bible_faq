// import 'package:bible_faq/components/componets.dart';
// import 'package:bible_faq/constants/constants.dart';
// import 'package:bible_faq/data/data.dart';
// import 'package:bible_faq/model/model.dart';
// import 'package:bible_faq/view/free_bible_guide_screen/study_method.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';

// class TopicDetailsScreen extends StatelessWidget {
//   const TopicDetailsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:  CustomAppBar(
//         title: "Topics",
//         isShowSettingTrailing: true,
//         isShowShareTrailing: true,
//         isShowStarTrailing: true,
//       ),
//       body: BodyContainerComponent(
//           child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: 160,
//               decoration: BoxDecoration(
//                 color: AppColors.aquaBlue.withOpacity(.2),
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: const Center(
//                 child: LabelText(
//                   text: "Angels, Spirit Beings",
//                   textColor: AppColors.tealBlue,
//                   textAlign: TextAlign.center,
//                   fontWeight: FontWeight.w700,
//                   fontSize: AppFontSize.small,
//                   isChangeTextColor: false,
//                 ),
//               ),
//             ),
//             const TitleText(
//                 text:
//                     "How can the Bible help me find purpose and direction in life, especially when I'm feeling lost or uncertain about the future?"),
//             const Gap(10),
//             Image.asset(
//               AppImages.resourceImages[1],
//             ),
//             const Gap(10),
//             const LabelText(
//               text:
//                   "The Bible offers profound wisdom on finding purpose and direction, especially during times of uncertainty or when we feel lost. It provides timeless guidance that helps believers understand their unique role in God’s plan. Here are some key ways the Bible offers direction:",
//               textColor: AppColors.darkGray,
//             ),
//             const StudyMethod(
//                 number: 1,
//                 title: "God’s Plan for You",
//                 description:
//                     "The Bible emphasizes that God has a specific plan and purpose for each person. In Jeremiah 29:11, we read: \"For I know the plans I have for you,\" declares the Lord, \"plans to prosper you and not to harm you, plans to give you hope and a future.\""),
//             const StudyMethod(
//                 number: 2,
//                 title: "Seeking God’s Guidance through Prayer",
//                 description:
//                     "In times of uncertainty, the Bible encourages us to seek God through prayer for clarity and guidance. Proverbs 3:5-6 advises: \"Trust in the Lord with all your heart and lean not on your own understanding; in all your ways submit to Him, and He will make your paths straight.\""),
//             const StudyMethod(
//                 number: 3,
//                 title: "Discovering Your Unique Gifts",
//                 description:
//                     "The Bible teaches that everyone is gifted in specific ways and has a unique role to play in God's plan. 1 Peter 4:10 says: \"Each of you should use whatever gift you have received to serve others, as faithful stewards of God's grace in its various forms.foreshadow the New Testament revelations."),
//             const TitleText(
//               text: "Related Questions",
//               fontSize: AppFontSize.xmedium,
//             ),
//             SizedBox(height: Get.height * .5, child: QuestionSection()),
//           ],
//         ),
//       )),
//     );
//   }
// }

// class QuestionSection extends StatelessWidget {
//   QuestionSection({super.key});

//   // final List<Question> questions = QuestionRepository.fetchLatestQuestions();

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: EdgeInsets.zero,
//       itemCount: questions.length,
//       itemBuilder: (context, index) {
//         final question = questions[index];
//         return Card(
//           child: Padding(
//             padding: const EdgeInsets.all(8),
//             child: ListTile(
//               contentPadding: const EdgeInsets.all(0),
//               leading: Image.asset(question.imagePath),
//               title: TitleText(
//                 text: question.text,
//                 fontSize: AppFontSize.xsmall,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
