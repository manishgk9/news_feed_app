import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_feed_app/utils/contstants/storage_keys.dart';
import '../models/article.dart';

class BookmarksController extends GetxController {
  final GetStorage _storage = GetStorage();
  var bookmarks = <Article>[].obs;

  @override
  void onInit() {
    super.onInit();
    final raw = _storage.read(StorageKeys.bookmarks) as String?;
    if (raw != null) {
      try {
        final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
        bookmarks.assignAll(list.map((m) => Article.fromJson(m)).toList());
      } catch (e) {
        bookmarks.clear();
      }
    }
  }

  void toggleBookmark(Article a) {
    final idx = bookmarks.indexWhere((x) => x.url == a.url);
    if (idx >= 0) {
      bookmarks.removeAt(idx);
    } else {
      bookmarks.insert(0, a);
    }
    _save();
  }

  bool isBookmarked(Article a) => bookmarks.any((x) => x.url == a.url);

  void _save() {
    _storage.write(
      StorageKeys.bookmarks,
      jsonEncode(bookmarks.map((e) => e.toJson()).toList()),
    );
  }
}
