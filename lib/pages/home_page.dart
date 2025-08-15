// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:news_feed_app/controllers/theme_controller.dart';
// import 'package:news_feed_app/pages/article_detail_page.dart';
// import 'package:news_feed_app/pages/bookmark_page.dart';
// import 'package:news_feed_app/pages/search_page.dart';
// import '../controllers/news_controller.dart';
// import '../controllers/bookmarks_controller.dart';
// import '../widgets/article_tile.dart';
// import '../widgets/news_list_shimmer.dart';
// import '../widgets/offline_banner.dart';

// class HomePage extends StatelessWidget {
//   HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final NewsController c = Get.find();
//     final BookmarksController b = Get.find();
//     final primaryColor = Theme.of(context).colorScheme.primary;
//     final isDark = Get.find<ThemeController>().isDarkMode;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         // backgroundColor: Color.fromARGB(255, 44, 109, 142),
//         backgroundColor: isDark ? Colors.black : Colors.white,
//         title: Row(
//           children: [
//             Text(
//               'News Feed',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//                 // color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//         elevation: 2,
//         actions: [
//           Row(
//             // mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               IconButton(
//                 icon: const Icon(
//                   CupertinoIcons.search,
//                   // color: Colors.white
//                 ),
//                 onPressed: () => Get.to(() => SearchPage()),
//               ),
//               Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(
//                       Icons.bookmark_outline,
//                       // color: Colors.white,
//                     ),
//                     onPressed: () => Get.to(() => BookmarksPage()),
//                   ),
//                   Obx(() {
//                     return IconButton(
//                       icon: Icon(
//                         Get.find<ThemeController>().isDarkMode
//                             ? CupertinoIcons.sun_max_fill
//                             : Icons.dark_mode_outlined,
//                         // color: Colors.white,
//                       ),
//                       onPressed: () =>
//                           Get.find<ThemeController>().toggleTheme(),
//                     );
//                   }),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Offline banner stays fixed too
//           Obx(() => OfflineBanner(online: c.online.value)),

//           // Scrollable list
//           Expanded(
//             child: NotificationListener<ScrollNotification>(
//               onNotification: (scrollInfo) {
//                 if (!c.isPaginationLoading.value &&
//                     c.hasMore.value &&
//                     scrollInfo.metrics.pixels >=
//                         scrollInfo.metrics.maxScrollExtent - 200) {
//                   c.fetchNextPage();
//                 }
//                 return false;
//               },
//               child: RefreshIndicator(
//                 onRefresh: c.refresh,
//                 child: Obx(() {
//                   if (c.isLoading.value && c.articles.isEmpty) {
//                     return const NewsListShimmer();
//                   }
//                   if (c.error.value.isNotEmpty && c.articles.isEmpty) {
//                     return Center(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(c.error.value),
//                           ElevatedButton(
//                             onPressed: c.refresh,
//                             child: const Text('Retry'),
//                           ),
//                         ],
//                       ),
//                     );
//                   }
//                   // ModernSearchBar(hintText: 'Search news...');
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                     child: ListView.separated(
//                       physics: const AlwaysScrollableScrollPhysics(),
//                       itemCount: c.articles.length + (c.hasMore.value ? 1 : 0),
//                       separatorBuilder: (_, __) => const Divider(height: 1),
//                       itemBuilder: (_, index) {
//                         if (index >= c.articles.length) {
//                           return Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Center(child: CircularProgressIndicator()),
//                           );
//                         }
//                         final art = c.articles[index];
//                         return Obx(() {
//                           return ArticleTile(
//                             article: art,
//                             isBookmarked: b.isBookmarked(art),
//                             onBookmarkTap: () => b.toggleBookmark(art),
//                             onTap: () =>
//                                 Get.to(() => ArticleDetailPage(article: art)),
//                           );
//                         });
//                       },
//                     ),
//                   );
//                 }),
//               ),
//             ),
//           ),
//         ],
//       ),

//       floatingActionButton: Obx(
//         () => c.isLoading.value
//             ? FloatingActionButton(
//                 backgroundColor: primaryColor,
//                 onPressed: () {},
//                 child: const CircularProgressIndicator(color: Colors.white),
//               )
//             : FloatingActionButton(
//                 // backgroundColor: primaryColor,
//                 backgroundColor: Color.fromARGB(255, 44, 109, 142),
//                 onPressed: c.refresh,
//                 child: const Icon(Icons.refresh, color: Colors.white),
//               ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import '../controllers/news_controller.dart';
import '../controllers/bookmarks_controller.dart';
import '../pages/article_detail_page.dart';
import '../pages/bookmark_page.dart';
import '../pages/search_page.dart';
import '../widgets/article_tile.dart';
import '../widgets/news_list_shimmer.dart';
import '../widgets/offline_banner.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewsController c = Get.find();
    final BookmarksController b = Get.find();
    final ThemeController t = Get.find();
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: t.isDarkMode ? Colors.black : Colors.white,
        title: Row(
          children: [
            Text(
              'News Feed',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.search),
            onPressed: () => Get.to(() => SearchPage()),
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_outline),
            onPressed: () => Get.to(() => BookmarksPage()),
          ),
          Obx(() {
            return IconButton(
              icon: Icon(
                t.isDarkMode
                    ? CupertinoIcons.sun_max_fill
                    : Icons.dark_mode_outlined,
              ),
              onPressed: () => t.toggleTheme(),
            );
          }),
        ],
      ),
      body: Column(
        children: [
          // Offline banner
          Obx(() => OfflineBanner(online: c.online.value)),

          // Scrollable news list
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (!c.isPaginationLoading.value &&
                    c.hasMore.value &&
                    scrollInfo.metrics.pixels >=
                        scrollInfo.metrics.maxScrollExtent - 100) {
                  c.fetchNextPage();
                }
                return false;
              },
              child: RefreshIndicator(
                onRefresh: c.refresh,
                child: Obx(() {
                  if (c.isLoading.value && c.articles.isEmpty) {
                    return const NewsListShimmer();
                  }
                  if (c.error.value.isNotEmpty && c.articles.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(c.error.value),
                          ElevatedButton(
                            onPressed: c.refresh,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 8,
                    ),
                    itemCount:
                        c.articles.length +
                        (c.isPaginationLoading.value ? 1 : 0),
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (_, index) {
                      if (index >= c.articles.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final art = c.articles[index];
                      return Obx(() {
                        return ArticleTile(
                          article: art,
                          isBookmarked: b.isBookmarked(art),
                          onBookmarkTap: () => b.toggleBookmark(art),
                          onTap: () =>
                              Get.to(() => ArticleDetailPage(article: art)),
                        );
                      });
                    },
                  );
                }),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Obx(
        () => c.isLoading.value
            ? FloatingActionButton(
                backgroundColor: primaryColor,
                onPressed: () {},
                child: const CircularProgressIndicator(color: Colors.white),
              )
            : FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 44, 109, 142),
                onPressed: c.refresh,
                child: const Icon(Icons.refresh, color: Colors.white),
              ),
      ),
    );
  }
}
