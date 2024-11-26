import 'package:json_annotation/json_annotation.dart';

part 'base_response_string.g.dart';

@JsonSerializable()
class BaseResponseString {
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "code")
  final int? code;
  @JsonKey(name: "data")
  final String? data;
  @JsonKey(name: "errors")
  final String? errors;

  BaseResponseString({
    this.status,
    this.message,
    this.code,
    this.data,
    this.errors,
  });

  BaseResponseString copyWith({
    int? status,
    String? message,
    int? code,
    String? data,
    String? errors,
  }) =>
      BaseResponseString(
        status: status ?? this.status,
        message: message ?? this.message,
        code: code ?? this.code,
        data: data ?? this.data,
        errors: errors ?? this.errors,
      );

  factory BaseResponseString.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$BaseResponseStringFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseStringToJson(this);
}
