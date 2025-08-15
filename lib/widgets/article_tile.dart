// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:news_feed_app/utils/date_utils.dart';
// import '../models/article.dart';

// class ArticleTile extends StatelessWidget {
//   final Article article;
//   final VoidCallback onTap;
//   final VoidCallback? onBookmarkTap;
//   final bool isBookmarked;

//   const ArticleTile({
//     Key? key,
//     required this.article,
//     required this.onTap,
//     this.onBookmarkTap,
//     this.isBookmarked = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final headline = article.title ?? 'No title';
//     final subtitle = article.description ?? '';
//     final imageUrl = article.urlToImage;
//     final source = article.source?.name ?? 'Unknown';
//     return ListTile(
//       onTap: onTap,
//       leading: imageUrl != null
//           ? ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: CachedNetworkImage(
//                 imageUrl: imageUrl,
//                 width: 92,
//                 height: 70,
//                 fit: BoxFit.fill,
//                 placeholder: (c, s) =>
//                     Container(width: 92, height: 64, color: Colors.grey[300]),
//                 errorWidget: (c, s, e) => Container(
//                   width: 92,
//                   height: 70,
//                   color: Colors.grey[300],
//                   child: Icon(Icons.broken_image),
//                 ),
//               ),
//             )
//           : Container(width: 92, height: 70, color: Colors.grey[300]),
//       title: Text(headline, maxLines: 2, overflow: TextOverflow.ellipsis),
//       subtitle: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 4),
//           Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis),
//           SizedBox(height: 6),

//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   source,
//                   style: TextStyle(fontSize: 12, color: Colors.grey),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               SizedBox(width: 8),
//               Text(
//                 formatDate(article.publishedAt),
//                 style: TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//             ],
//           ),
//         ],
//       ),
//       trailing: IconButton(
//         icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_outline),
//         onPressed: onBookmarkTap,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../utils/date_utils.dart';
import '../models/article.dart';

class ArticleTile extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;
  final VoidCallback? onBookmarkTap;
  final bool isBookmarked;

  const ArticleTile({
    Key? key,
    required this.article,
    required this.onTap,
    this.onBookmarkTap,
    this.isBookmarked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headline = article.title ?? 'No title';
    final subtitle = article.description ?? '';
    final imageUrl = (article.urlToImage?.isNotEmpty ?? false)
        ? article.urlToImage!
        : 'https://via.placeholder.com/400x250.png?text=No+Image';
    final source = article.source?.name ?? 'Unknown';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        // color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: theme.brightness == Brightness.light ? 3 : 0,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with fixed ratio
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: theme.dividerColor.withOpacity(0.1)),
                errorWidget: (context, url, error) => Container(
                  color: theme.dividerColor.withOpacity(0.1),
                  child: const Icon(Icons.broken_image, size: 40),
                ),
              ),
            ),

            // Text content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    headline,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          source,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.textTheme.bodySmall?.color
                                ?.withOpacity(0.6),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        formatDate(article.publishedAt),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.textTheme.bodySmall?.color?.withOpacity(
                            0.6,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isBookmarked
                              ? Icons.bookmark
                              : Icons.bookmark_outline,
                          size: 20,
                        ),
                        onPressed: onBookmarkTap,
                        splashRadius: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
