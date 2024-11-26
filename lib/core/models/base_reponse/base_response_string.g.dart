// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_string.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseString _$BaseResponseStringFromJson(Map<String, dynamic> json) =>
    BaseResponseString(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] as String?,
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$BaseResponseStringToJson(BaseResponseString instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'errors': instance.errors,
    };
