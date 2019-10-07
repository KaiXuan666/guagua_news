// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TencentNewsDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TencentNewsDetail _$TencentNewsDetailFromJson(Map<String, dynamic> json) {
  return TencentNewsDetail(
    json['bimg'] as String,
    json['intro'] as String,
    json['title'] as String,
    json['source'] as String,
    json['publish_time'] == null
        ? null
        : DateTime.parse(json['publish_time'] as String),
    json['url'] as String,
  );
}

Map<String, dynamic> _$TencentNewsDetailToJson(TencentNewsDetail instance) =>
    <String, dynamic>{
      'bimg': instance.bimg,
      'intro': instance.intro,
      'title': instance.title,
      'source': instance.source,
      'publish_time': instance.publish_time?.toIso8601String(),
      'url': instance.url,
    };
