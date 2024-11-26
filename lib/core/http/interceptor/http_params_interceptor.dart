import 'package:aegislabs/common/provider/config_provider.dart';
import 'package:aegislabs/common/provider/storage_provider.dart';
import 'package:dio/dio.dart';

class HttpParamsInterceptor extends Interceptor {
  HttpParamsInterceptor();

  final StorageProvider storageProvider = StorageProvider.to;
  final ConfigProvider configProvider = ConfigProvider.to;

  static const APPID = "App-ID";
  static const TOKEN = "Authorization";
  static const VERSION = "X-Version";
  static const ONESIGNAL = "X-Player";
  static const CONTENT = "Content-Type";
  static const ACCEPT = "Accept";
  static const JSON = "application/json";

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var headers = options.headers;

    // headers[CONTENT] = JSON;
    headers[ACCEPT] = JSON;
    headers[VERSION] = configProvider.version();
    headers[APPID] = configProvider.appId;

    final token = storageProvider.getString(STORAGE_TOKEN);

    if (token.isNotEmpty) {
      headers[TOKEN] = 'Bearer $token';
    }

    print('headers : $headers');

    options.headers = headers;
    super.onRequest(options, handler);
  }
}
