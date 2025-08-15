import 'package:dio/dio.dart';
import 'package:news_feed_app/models/news_response.dart';
import 'dio_client.dart';

class NewsApi {
  final DioClient _dioClient = DioClient();

  Future<NewsResponse> fetchEverything({
    required String q,
    required int page,
    int pageSize = 20,
    CancelToken? cancelToken,
  }) async {
    final dio = _dioClient.client;
    final response = await dio.get(
      '/everything',
      queryParameters: {
        'q': q,
        'sortBy': 'publishedAt',
        'pageSize': pageSize,
        'page': page,
        // apiKey added by default in BaseOptions
      },
      cancelToken: cancelToken,
    );
    return NewsResponse.fromJson(response.data);
  }
}
