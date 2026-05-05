import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["Authorization"] = "Bearer YOUR_TOKEN";
    super.onRequest(options, handler);
  }
}

class RetryInterceptor extends Interceptor {
  final Dio dio;
  int retryCount = 0;

  RetryInterceptor({required this.dio});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (retryCount < 3) {
      retryCount++;
      try {
        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (_) {
        return super.onError(err, handler);
      }
    }
    return super.onError(err, handler);
  }
}