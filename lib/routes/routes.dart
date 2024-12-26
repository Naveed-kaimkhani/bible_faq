import 'package:bible_faq/constants/app_routs.dart';
import 'package:bible_faq/view/ask_question_screen.dart';
import 'package:bible_faq/view/free_bible_guide_screen.dart';
import 'package:bible_faq/view/home_screen/fav_question_search_screen.dart';
import 'package:bible_faq/view/question_details_screen.dart';
import 'package:bible_faq/view/topic_details_screen.dart';
import 'package:bible_faq/view/view.dart';
import 'package:get/get.dart';

class Routes {
  static getAppRoutes() => [
        GetPage(
          name: AppRouts.splashScreen,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: AppRouts.homeScreen,
          page: () => HomeScreen(),
        ),
        GetPage(
          name: AppRouts.settingScreen,
          page: () => const SettingScreen(),
        ),
        GetPage(
          name: AppRouts.allBibleQuestionAnswerScreen,
          page: () => AllBilbeQuestionAndAnswerScreen(),
        ),
        GetPage(
          name: AppRouts.bibleTopicsScreen,
          page: () => BibleTopicsScreen(),
        ),
        // GetPage(
        //   name: AppRouts.browsingHistryScreen,
        //   page: () => BrowsingHistryScreen(),
        // ),
        GetPage(
          name: AppRouts.latestQuestionScreen,
          page: () => LatestQuestionScreen(),
        ),
        GetPage(
          name: AppRouts.myFavouritQuestionScreen,
          page: () => MyFavouriteQuestionScreen(),
        ),
        GetPage(
          name: AppRouts.searchQusetionScreen,
          page: () => SearchQuestionsScreen(),
        ),
        GetPage(
          name: AppRouts.topicScreen,
          page: () => TopicsScreen(),
        ),
         GetPage(
          name: AppRouts.questionDetailScreen,
          page: () => QuestionDetailScreen(),
        ),
        
        GetPage(
          name: AppRouts.aboutUsScreen,
          page: () => const AboutUsScreen(),
        ),
        // GetPage(
        //   name: AppRouts.newsAndResourcesScreen,
        //   page: () => const NewsAndResourcesScreen(),
        // ),
        GetPage(
          name: AppRouts.freeBilbeGuideScreen,
          page: () => const FreeBibleGuideScreen(),
        ),
        GetPage(
          name: AppRouts.askQuestionScreen,
          page: () => const AskQuestionScreen(),
        ),
        
        GetPage(
          name: AppRouts.favQuestionSearchScreen,
          page: () => const FavQuestionSearchScreen(),
        ),
        GetPage(
          name: AppRouts.topicDeatailsScreen,
          page: () => const TopicDetailsScreen(),
        ),
      ];
}
