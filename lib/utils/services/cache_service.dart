import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:news_feed_app/models/news_response.dart';
import 'package:news_feed_app/utils/contstants/storage_keys.dart';

class CacheService {
  final GetStorage _storage = GetStorage();

  void cacheNews(NewsResponse news, DateTime expiry) {
    _storage.write(StorageKeys.cacheNews, jsonEncode(news.toJson()));
    _storage.write(StorageKeys.cacheExpiry, expiry.toIso8601String());
  }

  NewsResponse? getCachedNews() {
    final raw = _storage.read(StorageKeys.cacheNews) as String?;
    if (raw == null) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      final expiryStr = _storage.read(StorageKeys.cacheExpiry) as String?;
      if (expiryStr != null) {
        final expiry = DateTime.parse(expiryStr);
        if (DateTime.now().isAfter(expiry)) {
          // expired
          _storage.remove(StorageKeys.cacheNews);
          _storage.remove(StorageKeys.cacheExpiry);
          return null;
        }
      }
      return NewsResponse.fromJson(map);
    } catch (e) {
      return null;
    }
  }

  // search history
  List<String> getSearchHistory() {
    final list = _storage.read(StorageKeys.searchHistory) as List<dynamic>?;
    return list?.cast<String>() ?? [];
  }

  void addSearchQuery(String q) {
    final list = getSearchHistory();
    list.remove(q); //
    list.insert(0, q);
    _storage.write(StorageKeys.searchHistory, list.take(10).toList());
  }
}
