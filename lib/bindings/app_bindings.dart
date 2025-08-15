import 'package:get/get.dart';
import 'package:news_feed_app/controllers/bookmarks_controller.dart';
import 'package:news_feed_app/controllers/news_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(() => NewsController(), permanent: true);
    Get.put(() => BookmarksController(), permanent: true);
  }
}
