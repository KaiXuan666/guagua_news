// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TencentNewsListResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TencentNewsListResponse _$TencentNewsListResponseFromJson(
    Map<String, dynamic> json) {
  return TencentNewsListResponse(
    json['msg'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : TencentNewsDetail.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TencentNewsListResponseToJson(
        TencentNewsListResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'data': instance.data,
    };
