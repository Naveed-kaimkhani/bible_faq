// import 'package:bible_app/components/componets.dart';
// import 'package:bible_app/constants/constants.dart';
// import 'package:bible_app/data/data.dart';
// import 'package:bible_app/model/model.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';

// class BrowsingHistryScreen extends StatelessWidget {
//   BrowsingHistryScreen({super.key});

//   final List<Question> questions = QuestionRepository.fetchLatestQuestions();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(
//         title: "Browsing History",
//       ),
//       body: BodyContainerComponent(
//         child: Column(
//           children: [
//             const CustomTextField(),
//             const Gap(10),
//             Expanded(
//               child: ListView.builder(
//                 padding: EdgeInsets.zero,
//                 itemCount: questions.length,
//                 itemBuilder: (context, index) {
//                   final question = questions[index];
//                   return Card(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 0),
//                       child: ListTile(
//                         contentPadding: const EdgeInsets.all(0),
//                         leading: Image.asset(question.imagePath),
//                         title: Column(
//                           children: [
//                             TitleText(
//                               text: question.text,
//                               fontSize: AppFontSize.xsmall,
//                             ),
//                             const Gap(8),
//                           ],
//                         ),
//                         subtitle: const LabelText(
//                           text: "Read on Oct 24, 2024 8:20PM",
//                           textColor: Color(0xffA2A2A2),
//                           fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
