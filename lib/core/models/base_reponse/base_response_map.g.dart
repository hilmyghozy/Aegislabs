// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseMap _$BaseResponseMapFromJson(Map<String, dynamic> json) =>
    BaseResponseMap(
      code: (json['code'] as num?)?.toInt(),
      codeMessage: json['code_message'] as String?,
      codeType: json['code_type'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      traceId: json['trace_id'] as String?,
    );

Map<String, dynamic> _$BaseResponseMapToJson(BaseResponseMap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'code_message': instance.codeMessage,
      'code_type': instance.codeType,
      'data': instance.data,
      'trace_id': instance.traceId,
    };
