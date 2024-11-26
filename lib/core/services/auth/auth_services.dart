import 'package:retrofit/error_logger.dart';
import 'package:aegislabs/core/http/dio_client.dart';
import 'package:aegislabs/core/models/base_reponse/base_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:retrofit/http.dart';

part 'auth_services.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService() {
    String baseUrl = dotenv.env["BASE_URL"]!;
    return _AuthService(DioClient().dio, baseUrl: baseUrl.trim());
  }

  @POST("/auth/login")
  Future<dynamic> login(
    @Body() Map<String, String> payload,
  );

  @POST("/users")
  Future<BaseResponse<String?>> register(
    @Body() Map<String, String> payload,
  );
}
