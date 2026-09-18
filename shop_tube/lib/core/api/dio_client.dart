import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_tube/core/constant/app_constant.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstant.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),

      headers: {
        'Content-Type': 'application/json',
        'Accept': "application/json",
      },
    ),
  );

  dio.interceptors.add(
    LogInterceptor(requestBody: true, responseBody: true, error: true),
  );

  return dio;
});
