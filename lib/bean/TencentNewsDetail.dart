import 'package:json_annotation/json_annotation.dart';

part 'TencentNewsDetail.g.dart';

@JsonSerializable()
class TencentNewsDetail extends Object {

  // 图片
  String bimg;
  // 简介
  String intro;
  String title;
  String source;
  DateTime publish_time;
  String url;

  TencentNewsDetail(this.bimg, this.intro, this.title,this.source, this.publish_time, this.url);


  factory TencentNewsDetail.fromJson(Map<String, dynamic> json) => _$TencentNewsDetailFromJson(json);
  Map<String, dynamic> toJson() => _$TencentNewsDetailToJson(this);

  @override
  String toString() {
    return 'TencentNewsDetail{bimg: $bimg, intro: $intro, title: $title, source: $source, publish_time: $publish_time, url: $url}';
  }


}