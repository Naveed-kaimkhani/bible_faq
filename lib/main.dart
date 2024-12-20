import 'package:bible_faq/components/app_light_theme.dart';
import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/routes/routes.dart';
import 'package:bible_faq/view_model/api_controller/all_question_provider.dart';
import 'package:bible_faq/view_model/controllers/controllers.dart';
import 'package:bible_faq/view_model/question_provider/question_provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController());
  
  Get.put(QuestionsProviderSql());
  Get.put(QuestionProviderAPI());
  // DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => const BibleFAQ()
  //   );
  runApp(const BibleFAQ());
}

class BibleFAQ extends StatelessWidget {
  const BibleFAQ({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bible FAQ',
      defaultTransition: Transition.cupertino,
      theme: AppLightTheme.lightTheme,
      darkTheme: AppDarkTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      getPages: Routes.getAppRoutes(),
      initialRoute: AppRouts.splashScreen,
    );
  }
}
