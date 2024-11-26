import 'package:aegislabs/common/base_repository.dart';
import 'package:aegislabs/common/provider/storage_provider.dart';
import 'package:aegislabs/core/http/handler/error_handler.dart';
import 'package:aegislabs/core/http/handler/exeption.dart';
import 'package:aegislabs/core/http/handler/failures.dart';
import 'package:aegislabs/core/services/auth/auth_services.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthRepository extends BaseRepository {
  AuthRepository();

  static AuthRepository get to => Get.find();
  final AuthService api = AuthService();
  final StorageProvider storage = StorageProvider.to;
  // final ConfigProvider config = ConfigProvider.to;

  RxString token = ''.obs;

  @override
  void onInit() async {
    getToken();
    super.onInit();
  }

  saveToken(String token) async {
    await storage.setString(STORAGE_TOKEN, token);
  }

  getToken() {
    token.value = storage.getString(STORAGE_TOKEN);
  }

  deleteToken() async {
    token.value = "";
    await storage.remove(STORAGE_TOKEN);

    print('token deleted');
  }

  Future<Either<Failure, dynamic?>> login({
    required Map<String, String> payload,
  }) async {
    try {
      final result = await api.login(payload);

      print('myToken ${result['token']}');
      await saveToken(result['token'] ?? '');
      return Right(result['token']);
    } on DioException catch (e, stacktrace) {
      debugPrintStack(stackTrace: stacktrace);
      if (e.type == DioExceptionType.cancel) {
        return Left(
            CancelTokenFailure(handleDioError(e), e.response?.statusCode));
      } else {
        return Left(ServerFailure(handleDioError(e), e.response?.statusCode));
      }
    } on ServerException {
      rethrow;
    } catch (e, stacktrace) {
      loggy.error('error ${api}> $e');
      loggy.error('stacktrace>  ${stacktrace.toString()}');
      return Left(ServerFailure(e.toString(), null));
    }
  }
}
