import 'package:aegislabs/common/components/dialog/dialogs.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AppException implements Exception {
  final String? message;
  final int? code;

  AppException([
    this.code,
    this.message,
  ]);

  @override
  String toString() {
    return "$code$message";
  }

  factory AppException.create(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        {
          showToast(message: "something_wrong".tr);
          return BadRequestException(-1, "Canceled");
        }
      case DioExceptionType.connectionTimeout:
        {
          showToast(message: "something_wrong".tr);
          return BadRequestException(-1, "Connection Timeout");
        }
      case DioExceptionType.sendTimeout:
        {
          showToast(message: "something_wrong".tr);
          return BadRequestException(-1, "Request Timeout");
        }
      case DioExceptionType.receiveTimeout:
        {
          showToast(message: "something_wrong".tr);
          return BadRequestException(-1, "Receive Timeout");
        }
      case DioExceptionType.badResponse:
        {
          try {
            int? errCode = error.response?.statusCode;
            // String errMsg = error.response.statusMessage;
            // return ErrorEntity(code: errCode, message: errMsg);
            switch (errCode) {
              case 400:
                {
                  var res = error.response?.data as Map<String, dynamic>;
                  // if ((res["message"] as String).contains("not allowed")) {
                  //   showFullErrorDialog(
                  //       message:
                  //           "Akun Anda tidak bisa memakai Aplikasi ini, silahkan download aplikasi yang telah disediakan.",
                  //       buttonText: t.button.close,
                  //       buttonClick: () {
                  //         AccountRepo.to.clearData();
                  //         Get.offAllNamed(AppRoutes.APP);
                  //       });
                  //}
                  return UnauthorisedException(errCode, res["message"]);
                }
              case 401:
              case 403:
                {
                  // var res = error.response?.data as Map<String, dynamic>;
                  // Logger.critical(error.requestOptions.path);
                  // if ((res["message"] as String).contains("please log in") &&
                  //     error.requestOptions.path != 'user/confirm-pin') {
                  //   showPIN();
                  //   // showFullErrorDialog(
                  //   //     message:
                  //   //         "Session anda telah habis, silahkan untuk Login kembali.",
                  //   //     buttonText: t.button.close,
                  //   //     buttonClick: () {
                  //   //       AccountRepo.to.clearData();
                  //   //       Get.offAllNamed(AppRoutes.APP);
                  //   //     });
                  //}

                  return UnauthorisedException(errCode, "Unauthorised");
                }
              case 404:
                {
                  return UnauthorisedException(errCode, "API Not Found");
                }
              case 405:
                {
                  return UnauthorisedException(errCode, "Method Not Allowed");
                }
              case 500:
              case 502:
              case 503:
              case 505:
                {
                  showToast(message: "something_wrong".tr);
                  return UnauthorisedException(
                      errCode, "Internal server Error");
                }

              default:
                {
                  return AppException(errCode, error.response?.statusMessage);
                }
            }
          } on Exception catch (_) {
            return AppException(-1, _.toString());
          }
        }

      default:
        {
          return AppException(-1, error.message);
          // return AppException(-1, error.message);
        }
    }
  }
}

/// 请求错误
class BadRequestException extends AppException {
  BadRequestException([super.code, super.message]);
}

/// 未认证异常
class UnauthorisedException extends AppException {
  UnauthorisedException([super.code, super.message]);
}
