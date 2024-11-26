import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'interceptor/error_interceptor.dart';
import 'interceptor/http_params_interceptor.dart';

class DioClient with DioLoggy {
  static void initClient({
    required String baseUrl,
    int connectTimeout = CONNECT_TIMEOUT,
    int receiveTimeout = RECEIVE_TIMEOUT,
    List<Interceptor>? interceptors,
  }) {
    DioClient().init(
      baseUrl: baseUrl,
      connectTimeout: const Duration(milliseconds: CONNECT_TIMEOUT),
      receiveTimeout: const Duration(milliseconds: RECEIVE_TIMEOUT),
      interceptors: interceptors,
    );
  }

  static const int CONNECT_TIMEOUT = 60 * 1000;
  static const int RECEIVE_TIMEOUT = 60 * 1000;

  static final _instance = DioClient._internal();

  final cancelToken = CancelToken();

  factory DioClient() => _instance;

  late Dio dio;

  DioClient._internal() {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(milliseconds: CONNECT_TIMEOUT),
      receiveTimeout: const Duration(milliseconds: RECEIVE_TIMEOUT),
    );

    dio = Dio(options);
    if (kDebugMode) {
      dio.interceptors.add(LoggyDioInterceptor(
        requestBody: true,
        requestHeader: true,
      ));
    }

    dio.interceptors.add(HttpParamsInterceptor());
    dio.interceptors.add(ErrorInterceptor());
  }

  void init({
    String? baseUrl,
    Duration connectTimeout = const Duration(milliseconds: CONNECT_TIMEOUT),
    Duration receiveTimeout = const Duration(milliseconds: RECEIVE_TIMEOUT),
    Map<String, String>? headers,
    List<Interceptor>? interceptors,
  }) {
    dio.options = dio.options.copyWith(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      headers: headers ?? const {},
    );
    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }
  }
}
