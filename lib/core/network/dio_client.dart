import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_end_points.dart';
import 'intercepter.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: ApiEndpoints.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  dio.interceptors.addAll([
    AuthInterceptor(),
    RetryInterceptor(dio: dio),
    LogInterceptor(responseBody: true),
  ]);

  return dio;
});