import 'package:aegislabs/common/base_repository.dart';
import 'package:aegislabs/common/provider/storage_provider.dart';
import 'package:aegislabs/core/http/handler/error_handler.dart';
import 'package:aegislabs/core/http/handler/exeption.dart';
import 'package:aegislabs/core/http/handler/failures.dart';
import 'package:aegislabs/core/models/carts/carts_model.dart';
import 'package:aegislabs/core/models/products/products_model.dart';
import 'package:aegislabs/core/services/product/product_services.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductRepository extends BaseRepository {
  ProductRepository();

  static ProductRepository get to => Get.find();
  final ProductService api = ProductService();
  final StorageProvider storage = StorageProvider.to;

  Future<Either<Failure, List<Products>?>> products() async {
    try {
      final result = await api.products();
      return Right(result.cast<Products>());
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

  Future<Either<Failure, Products?>> productsDetail(int productId) async {
    try {
      final result = await api.productsDetail(productId);
      return Right(result);
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

  Future<Either<Failure, List<String>?>> getCategories() async {
    try {
      final result = await api.getCategories();
      return Right(result.cast<String>());
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

  Future<Either<Failure, List<Products>?>> getProductByCategories(
    String categories,
  ) async {
    try {
      final result = await api.getSpecificCategories(categories);
      return Right(result.cast<Products>());
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

  Future<Either<Failure, List<CartsModel>?>> getCarts() async {
    try {
      final result = await api.getCarts();
      return Right(result.cast<CartsModel>());
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

  Future<Either<Failure, dynamic>> addCart({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final result = await api.addCarts(payload);
      return Right(result);
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

  Future<Either<Failure, dynamic>> deleteCart(
    int id,
  ) async {
    try {
      final result = await api.deleteCarts(id);
      return Right(result);
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
