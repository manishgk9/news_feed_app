import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_feed_app/controllers/theme_controller.dart';
import '../controllers/bookmarks_controller.dart';
import '../widgets/article_tile.dart';
import 'article_detail_page.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Get.find<ThemeController>().isDarkMode;
    final BookmarksController b = Get.find<BookmarksController>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            // color: Colors.white
          ),
        ),
        title: const Text(
          'Bookmarks',
          // style: TextStyle
          // (color: Colors.white)
        ),
        centerTitle: true,
        // backgroundColor: Color.fromARGB(255, 44, 109, 142),
        backgroundColor: isDark ? Colors.black : Colors.white,
      ),
      body: Obx(() {
        final bookmarks = b.bookmarks;

        if (bookmarks.isEmpty) {
          return const Center(
            child: Text(
              'No bookmarks yet.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: bookmarks.length,
          itemBuilder: (context, index) {
            final article = bookmarks[index];
            return ArticleTile(
              article: article,
              isBookmarked: b.isBookmarked(article),
              onBookmarkTap: () => b.toggleBookmark(article),
              onTap: () => Get.to(() => ArticleDetailPage(article: article)),
            );
          },
        );
      }),
    );
  }
}
