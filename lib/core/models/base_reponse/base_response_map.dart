import 'package:json_annotation/json_annotation.dart';

part 'base_response_map.g.dart';

@JsonSerializable()
class BaseResponseMap {
  @JsonKey(name: "code")
  final int? code;
  @JsonKey(name: "code_message")
  final String? codeMessage;
  @JsonKey(name: "code_type")
  final String? codeType;
  @JsonKey(name: "data")
  final Map<String, dynamic>? data;
  @JsonKey(name: "trace_id")
  final String? traceId;

  BaseResponseMap({
    this.code,
    this.codeMessage,
    this.codeType,
    this.data,
    this.traceId,
  });

  BaseResponseMap copyWith({
    int? code,
    String? codeMessage,
    String? codeType,
    Map<String, dynamic>? data,
    String? traceId,
  }) =>
      BaseResponseMap(
        code: code ?? this.code,
        codeMessage: codeMessage ?? this.codeMessage,
        codeType: codeType ?? this.codeType,
        data: data ?? this.data,
        traceId: traceId ?? this.traceId,
      );

  factory BaseResponseMap.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$BaseResponseMapFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseMapToJson(this);
}
