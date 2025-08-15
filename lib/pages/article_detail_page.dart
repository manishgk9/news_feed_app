import 'package:flutter/material.dart';
import 'package:news_feed_app/controllers/theme_controller.dart';
import 'package:share_plus/share_plus.dart';
import 'package:get/get.dart';
import '../models/article.dart';
import '../controllers/bookmarks_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  Future<void> _openUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        Get.snackbar(
          'Error',
          'Could not open URL',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade700,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Invalid URL',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade700,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final BookmarksController b = Get.find();
    final title = article.title ?? 'Article';
    final primaryColor = Theme.of(context).colorScheme.primary;
    final isDark = Get.find<ThemeController>().isDarkMode;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          // color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
        // backgroundColor: Color.fromARGB(255, 44, 109, 142),
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 2,
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            // color: Colors.white,
          ),
        ),
        actions: [
          Obx(() {
            return IconButton(
              icon: Icon(
                b.isBookmarked(article)
                    ? Icons.bookmark
                    : Icons.bookmark_outline,
                // color: Colors.white,
              ),
              onPressed: () => b.toggleBookmark(article),
            );
          }),
          IconButton(
            icon: const Icon(
              Icons.share,
              //  color:
              //  Colors.white
            ),
            onPressed: () {
              final url = article.url ?? '';
              if (url.isNotEmpty) Share.share('$title\n$url');
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (article.urlToImage != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage!,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                    Container(height: 220, color: Colors.grey[300]),
                errorWidget: (_, __, ___) => Container(
                  height: 220,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, size: 48),
                ),
              ),
            ),
          const SizedBox(height: 16),
          Text(
            article.title ?? '',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            article.source?.name ?? '',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          if (article.description?.isNotEmpty ?? false)
            Text(
              article.description!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          const SizedBox(height: 12),
          if (article.content?.isNotEmpty ?? false)
            Text(
              article.content!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          const SizedBox(height: 32),

          // Modern Primary Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 44, 109, 142),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              onPressed: () {
                final url = article.url ?? '';
                if (url.isNotEmpty) {
                  Get.snackbar(
                    'Open Link',
                    'Would open: $url',
                    backgroundColor: primaryColor,
                    colorText: Colors.white,
                  );
                  _openUrl(url);
                }
              },
              icon: const Icon(Icons.open_in_new, color: Colors.white),
              label: const Text(
                'Read Full Article',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
