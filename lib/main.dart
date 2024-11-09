import 'package:bible_faq/components/app_light_theme.dart';
import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/routes/routes.dart';
import 'package:bible_faq/view_model/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController());
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
