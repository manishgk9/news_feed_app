import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_feed_app/additional_screens/splash.dart';
// import 'package:news_feed_app/bindings/app_bindings.dart';
import 'package:news_feed_app/controllers/bookmarks_controller.dart';
import 'package:news_feed_app/controllers/news_controller.dart';
import 'package:news_feed_app/controllers/theme_controller.dart';
import 'package:news_feed_app/utils/theme.dart';
// import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(NewsController(), permanent: true);
  Get.put(BookmarksController(), permanent: true);
  Get.put(ThemeController(), permanent: true);
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      return GetMaterialApp(
        title: 'News Feed',
        // initialBinding: AppBindings(),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.themeMode.value,
        // home: HomePage(),
        home: SplashScreen(),
      );
    });
  }
}
