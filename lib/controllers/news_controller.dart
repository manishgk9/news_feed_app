import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:news_feed_app/utils/services/cache_service.dart';
import 'package:news_feed_app/utils/services/news_api.dart';
import '../models/article.dart';
import '../models/news_response.dart';

class NewsController extends GetxController {
  final NewsApi _api = NewsApi();
  final CacheService _cache = CacheService();

  // reactive state
  var articles = <Article>[].obs;
  var page = 1.obs;
  var isLoading = false.obs;
  var isPaginationLoading = false.obs;
  var hasMore = true.obs;
  var error = ''.obs;

  var query = 'india'.obs;
  final CancelToken cancelToken = CancelToken();
  // search debounce
  Timer? _debounceTimer;
  final RxList<String> searchHistory = <String>[].obs;
  // connectivity
  final Connectivity _connectivity = Connectivity();
  var online = true.obs;
  // late StreamSubscription<ConnectivityResult> _connSub;

  late StreamSubscription<List<ConnectivityResult>> _connSub;

  @override
  void onInit() {
    super.onInit();
    searchHistory.assignAll(_cache.getSearchHistory());
    _connSub = _connectivity.onConnectivityChanged.listen((results) {
      final result = results.isNotEmpty
          ? results.first
          : ConnectivityResult.none;
      _onConnectivityChanged(result);
    });

    final cached = _cache.getCachedNews();
    if (cached != null && cached.articles.isNotEmpty) {
      articles.assignAll(cached.articles);
      // We keep cached data but also refresh
      fetchInitial(refresh: false, useCacheFallback: true);
    } else {
      fetchInitial();
    }
  }

  void addSearchHistory(String query) {
    // update observable
    if (!searchHistory.contains(query)) {
      searchHistory.insert(0, query);
      _cache.addSearchQuery(query);
    }
  }

  void _onConnectivityChanged(ConnectivityResult result) {
    online.value = result != ConnectivityResult.none;
  }

  Future<void> fetchInitial({
    bool refresh = true,
    bool useCacheFallback = false,
  }) async {
    try {
      if (isLoading.value) return;
      isLoading.value = true;
      page.value = 1;
      hasMore.value = true;
      error.value = '';
      cancelToken.cancel(); // cancel previous
      // new cancel token for this run
      final ct = CancelToken();
      // fetch
      final resp = await _api.fetchEverything(
        q: query.value,
        page: page.value,
        cancelToken: ct,
      );
      articles.assignAll(resp.articles);
      // cache for 30 minutes
      _cache.cacheNews(resp, DateTime.now().add(const Duration(minutes: 30)));
      // set has more
      hasMore.value = resp.articles.length >= 20;
    } on DioException catch (e) {
      // network error: fallback to cache if available
      final cached = _cache.getCachedNews();
      if (cached != null && useCacheFallback) {
        articles.assignAll(cached.articles);
        error.value = 'Showing cached data due to network issue.';
      } else {
        error.value = 'Failed to load news: ${e.message}';
      }
    } catch (e) {
      error.value = 'Something went wrong';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchNextPage() async {
    if (isPaginationLoading.value || !hasMore.value) return;
    isPaginationLoading.value = true;
    try {
      page.value += 1;
      final resp = await _api.fetchEverything(q: query.value, page: page.value);
      if (resp.articles.isEmpty) {
        hasMore.value = false;
      } else {
        articles.addAll(resp.articles);
        // optionally append to cache (create new NewsResponse)
        final existing = _cache.getCachedNews();
        if (existing != null) {
          final combined = NewsResponse(
            status: existing.status,
            totalResults: existing.totalResults,
            articles: [...existing.articles, ...resp.articles],
          );
          _cache.cacheNews(
            combined,
            DateTime.now().add(const Duration(minutes: 30)),
          );
        }
      }
    } on DioException catch (e) {
      page.value -= 1; // rollback
      error.value = 'Pagination failed: ${e.message}';
    } catch (e) {
      page.value -= 1;
      error.value = 'Pagination failed';
    } finally {
      isPaginationLoading.value = false;
    }
  }

  Future<void> refresh() async => await fetchInitial();

  void onSearchChanged(String q) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 600), () {
      query.value = q.trim().isEmpty ? '' : q.trim();
      // save search history
      _cache.addSearchQuery(query.value);
      fetchInitial();
    });
  }

  // List<String> get searchHistory => _cache.getSearchHistory();

  @override
  void onClose() {
    _connSub.cancel();
    _debounceTimer?.cancel();
    cancelToken.cancel();
    super.onClose();
  }
}
