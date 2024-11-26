import 'package:aegislabs/core/logger/logger_types.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'app_except.dart';

class ErrorInterceptor extends Interceptor with ProviderLogger {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    var dioErr = err.copyWith(error: null);
    if (!kIsWeb) {
      AppException appException = AppException.create(err);
      loggy.error('DioError===: ${appException.toString()}');
      var list5xx = [500, 501, 502, 503, 504, 505, 404];
      /*if (list5xx.firstWhereOrNull((e) => e == err.response?.statusCode) !=
          null) {
        showSnackBarError(
            t.message.error.something_code(error: appException.message ?? ""));
      }*/
      dioErr = err.copyWith(error: appException);
    }
    super.onError(dioErr, handler);
  }
}
