import 'package:flutter/material.dart';
import 'dart:io';
import 'widget/NewsListView.dart';
import 'route/NewsDetailPage.dart';
import 'NewsTypeConstant.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return HomePageState();
  }
}

class HomePageState extends State<StatefulWidget> {
  var httpClient = HttpClient();
  var typeList = NewsTypeConstant.map.keys.toList();
  TabController tabController;
  PageController pageController;
  @override
  Widget build(BuildContext context) {
    tabController = TabController(
      length: typeList.length,
      vsync: AnimatedListState(),
    );
    pageController = PageController(
      initialPage: 0,
    );
    tabController.addListener((){
      print("tabController ${tabController.indexIsChanging}");
      if(tabController.indexIsChanging){
        onPageChange(tabController.index, p: pageController);
      }
    });
    pageController.addListener((){

    });

    return Scaffold(
        appBar: AppBar(
          title: Text("瓜瓜头条"),
          bottom: TabBar(
            controller: tabController,
            isScrollable: true,
            tabs: NewsTypeConstant.map.keys.map((key) {
              return SizedBox(width: 45,child: Tab(
                text: key,
              ),);
            }).toList(),
          ),
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: PageView.builder(
                    itemBuilder: (context, index) {
                      return createListView(typeList[index]);
//                      return Text("Hello");
                    },
                    onPageChanged: (index){
                      print("pageController $index $isPageCanChanged");
                      if (isPageCanChanged) {//由于pageview切换是会回调这个方法,又会触发切换tabbar的操作,所以定义一个flag,控制pageview的回调
                        onPageChange(index);
                      }
                    },
                    controller: pageController,
                    itemCount: typeList.length,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: null
//      FloatingActionButton(
//        onPressed: null,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ),
        );
  }

  var isPageCanChanged = true;

  onPageChange(int index, {PageController p, TabController t}) async {
    print("onPageChange $p");
    if (p != null) {//判断是哪一个切换
      isPageCanChanged = false;
      // 防止两个回调无限循环触发
      await pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);//等待pageview切换完毕,再释放pageivew监听
      isPageCanChanged = true;
    } else {
      tabController.animateTo(index);//切换Tabbar
    }
  }

  createListView(newsType) {
    return NewsListView(
        newsType,
            (detail) => {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NewsDetailPage(detail);
          }))
        });
//    return Flexible(
//      child: NewsListView(
//          newsType,
//          (detail) => {
//                Navigator.push(context, MaterialPageRoute(builder: (context) {
//                  return NewsDetailPage(detail);
//                }))
//              }),
//    );
  }
}
