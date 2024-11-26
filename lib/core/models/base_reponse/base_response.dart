import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "code")
  final int? code;
  @JsonKey(name: "data")
  final T? data;
  @JsonKey(name: "token")
  final String? token;
  @JsonKey(name: "errors")
  final String? errors;

  BaseResponse({
    this.status,
    this.message,
    this.code,
    this.data,
    this.token,
    this.errors,
  });

  BaseResponse copyWith({
    int? status,
    String? message,
    int? code,
    T? data,
    String? token,
    String? errors,
  }) =>
      BaseResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        code: status ?? this.code,
        data: data ?? this.data,
        token: token ?? this.token,
        errors: errors ?? this.errors,
      );

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T value) toJsonT) =>
      _$BaseResponseToJson<T>(this, toJsonT);
}
