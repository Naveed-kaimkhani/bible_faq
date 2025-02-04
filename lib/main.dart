import 'package:bible_faq/components/app_light_theme.dart';
import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/routes/routes.dart';
import 'package:bible_faq/view_model/controllers/controllers.dart';
import 'package:bible_faq/view_model/font_size_provider.dart';
import 'package:bible_faq/view_model/question_provider/question_provider_sql.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetX controllers
  Get.put(ThemeController());
  Get.put(QuestionsProviderSql());
  Get.put(FontSizeController());

  // Properly wrap the app with MediaQuery
  runApp(
    Builder(
      builder: (context) {
        // Copy existing MediaQueryData and override textScaler
        final mediaQueryData =
            MediaQueryData.fromView(WidgetsBinding.instance.window);
        return MediaQuery(
          data: mediaQueryData.copyWith(
            textScaler: const TextScaler.linear(1.0), // Lock text scale factor
          ),
          child: const BibleFAQ(),
        );
      },
    ),
  );
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
