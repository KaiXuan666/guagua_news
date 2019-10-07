import 'package:flutter/material.dart';

//import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../bean/TencentNewsDetail.dart';

class NewsDetailPage extends StatelessWidget {
  TencentNewsDetail newsDetail;

  NewsDetailPage(this.newsDetail) {}

  @override
  Widget build(BuildContext context) {
    print(newsDetail.url);
    return WebviewScaffold(
        appBar: AppBar(
          title: Text("新闻详情"),
        ),
        url: newsDetail.url);
  }
}
