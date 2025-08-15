import 'dart:async';
import 'package:dio/dio.dart';
import 'package:news_feed_app/utils/contstants/api_constants.dart';

class DioClient {
  final Dio _dio;
  final CancelToken cancelToken = CancelToken();

  DioClient._internal(this._dio);

  factory DioClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Accept': 'application/json'},
        queryParameters: {'apiKey': ApiConstants.apiKey},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onError: (err, handler) async {
          // retry logic for network errors
          if (_shouldRetry(err)) {
            try {
              // simple retry with delay
              await Future.delayed(const Duration(seconds: 1));
              final response = await dio.fetch(err.requestOptions);
              return handler.resolve(response);
            } catch (e) {
              return handler.next(err);
            }
          }
          return handler.next(err);
        },
      ),
    );

    return DioClient._internal(dio);
  }

  static bool _shouldRetry(DioException err) {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.unknown) {
      return true;
    }
    return false;
  }

  Dio get client => _dio;

  void cancelRequests([String? reason]) {
    cancelToken.cancel(reason ?? 'Cancelled');
  }
}
