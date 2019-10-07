import 'package:flutter/material.dart';
import 'package:flutter_news/bean/TencentNewsDetail.dart';
import 'dart:io';
import 'dart:convert';
import '../bean/TencentNewsListResponse.dart';
import 'NewsListItem.dart';
import '../NewsTypeConstant.dart';

class NewsListView extends StatefulWidget {

  var itemClick;
  var newsType;

  NewsListView(this.newsType, this.itemClick) {
  }

  @override
  State<StatefulWidget> createState() {
    return NewsListViewState();
  }

}

class NewsListViewState extends State<NewsListView> {
  /**
   * 0：初始化
   * 1：加载成功
   * 2：加载失败
   * 3：加载完毕，没有更多啦
   */
  var loadState;
  List<TencentNewsDetail> data;
  var currentPage;

  void initState() {
    loadState = 0;
    currentPage = 0;

  }

  @override
  Widget build(BuildContext context) {
    if (loadState == 0) {
      getNewsList();
      return Center(child: CircularProgressIndicator(strokeWidth: 2.0),);
    } else if (loadState == 2) {
      print(double.infinity);
      return InkWell(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: double.infinity,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.error,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
              Text("加载失败，请点击重试", style: TextStyle(fontSize: 20))
            ],
          ),
        ),
        onTap: getNewsList,
      );
    } else {
      return RefreshIndicator(child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            if(index == data.length){
              // 说明是最后一个
              print("加载下一页");
              if(loadState == 3){
                return getFinshView();
              }else{
                getNewsList(page : currentPage + 1);
                return getLoadingView();
              }
            }
            return NewsListItem(data[index], widget.itemClick);
          },
          separatorBuilder: (BuildContext context, int index) {
            return new Padding(padding: EdgeInsets.symmetric(horizontal: 10),
            child: new Container(height: 1.0, color: Colors.black12,),);
          },
          itemCount: data == null ? 0 : data.length + 1), // 最后一个用来显示加载中
          onRefresh: () => getNewsList());
    }
  }

  getLoadingView(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          child: SizedBox(width: 20,height: 20,child: CircularProgressIndicator(strokeWidth: 2.0, ),)
        ),
        Text("加载中", style: TextStyle(fontSize: 20))
      ],
    );
  }

  getFinshView(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          child: Icon(
            Icons.check,
            color: Colors.blue,
            size: 30,
          )
        ),
        Text("已加载全部内容~", style: TextStyle(fontSize: 20))
      ],
    );
  }

  getNewsList({int page = 0}) async {
    try {
      currentPage = page;
      var httpClient = new HttpClient();
      var uri = Uri.parse(
          "https://pacaio.match.qq.com/irs/rcd?cid=56&ext=${NewsTypeConstant.map[widget.newsType]}&token=c786875b8e04da17b24ea5e332745e0f&num=20&expIds=20190106A13PFT%7C20190108A04MLS&page=$currentPage");
      var request = await httpClient.getUrl(uri);
      var response = await request.close();
//    await Future.delayed(Duration(milliseconds: 2000));
      var responseBody = await response.transform(utf8.decoder).join();
//    print(responseBody);
      var json = jsonDecode(responseBody);
      var tencentNewsListResponse = TencentNewsListResponse.fromJson(json);
      print(tencentNewsListResponse.data.length);
      setState(() {
        loadState = 1;
        if(currentPage == 0){
          data = tencentNewsListResponse.data;
        }else{
          if(tencentNewsListResponse.data.isEmpty ){
            loadState = 3;
          }else{
            data.addAll(tencentNewsListResponse.data);
          }
        }
      });

    } catch (e) {
      print(e);
      setState(() {
        loadState = 2;
        data = null;
      });
    }
  }

}
