// import 'package:bible_app/components/componets.dart';
// import 'package:bible_app/components/resource_link_card_component.dart';
// import 'package:bible_app/constants/app_images.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';

// class NewsAndResourcesScreen extends StatelessWidget {
//   const NewsAndResourcesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(
//         title: "News and Resources",
//       ),
//       body: BodyContainerComponent(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const TitleText(text: "Latest Posts"),
//               ResourceComponent(
//                 title: "Do you have a Bible question?",
//                 subTitle:
//                     "Ask your Bible questions, and we'll respond with answers based on the Holy Scriptures.",
//                 image: AppImages.resourceImages[1],
//                 width: double.infinity,
//                 ontap: () {},
//               ),
//               ResourceComponent(
//                 title: "Video: Marvelous Works of God",
//                 subTitle:
//                     "Take a trip through the universe with the Hubble space telescope and discover the brilliance and glory of God's creation.",
//                 image: AppImages.resourceImages[2],
//                 width: double.infinity,
//                 ontap: () {},
//               ),
//               const Gap(5),
//               const TitleText(text: "Links"),
//               const Gap(5),
//               Column(
//                 children: [
//                   ResourceLinkCardComponent(
//                     title: "Bible Materials Catalog",
//                     subtitle:
//                         "Explore subjects you're interested in with our extensive Bible materials catalog.",
//                     image: AppImages.questionImages[0],
//                     onTap: () {},
//                   ),
//                   ResourceLinkCardComponent(
//                     title: "Historical Bible Manuscripts",
//                     subtitle:
//                         "Dive into the history and authenticity of biblical manuscripts preserved over centuries.",
//                     image: AppImages.questionImages[1],
//                     onTap: () {},
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
