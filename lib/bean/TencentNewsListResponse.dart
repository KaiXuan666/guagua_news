import 'TencentNewsDetail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'TencentNewsListResponse.g.dart';

@JsonSerializable()
class TencentNewsListResponse extends Object {

  String msg;
  List<TencentNewsDetail> data;

  TencentNewsListResponse(this.msg, this.data);


  factory TencentNewsListResponse.fromJson(Map<String, dynamic> json) => _$TencentNewsListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TencentNewsListResponseToJson(this);

  @override
  String toString() {
    return 'TencentNewsListResponse{msg: $msg, data: $data}';
  }
}