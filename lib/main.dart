import 'package:flutter/material.dart';
import 'package:flutter_copy_osc/Constants.dart';
import 'package:flutter_copy_osc/events/ThemeEvent.dart';
import 'package:flutter_copy_osc/pages/DiscoveryPage.dart';
import 'package:flutter_copy_osc/pages/MyInfoPage.dart';
import 'package:flutter_copy_osc/pages/NewsListPages.dart';
import 'package:flutter_copy_osc/pages/TweetsListPage.dart';
import 'package:flutter_copy_osc/utils/DataUtils.dart';
import 'package:flutter_copy_osc/utils/ThemeUtils.dart';
import 'package:flutter_copy_osc/widgets/MyDrawer.dart';

void main() => runApp(CopyOSCApp());

class CopyOSCApp extends StatefulWidget {
  @override
  CopyOSCAppState createState() => CopyOSCAppState();
}

class CopyOSCAppState extends State<CopyOSCApp> {
  final appBarTitles = ['资讯', '动弹', '发现', '我的'];
  final titleTextStyleSelected = TextStyle(color: const Color(0xff63ca6c));
  final titleTextStyleNormal = TextStyle(color: const Color(0xff969696));

  Color themeColor = ThemeUtils.currentThemeColor;
  int _tableIndex = 0;

  var tableImages;
  var _body;
  var pages;

  Image getTableImage(String path) {
    return Image.asset(
      path,
      width: 20,
      height: 20,
    );
  }

  @override
  void initState() {
    super.initState();
    DataUtils.getThemeColorIndex().then((index) {
      if (index != null) {
        ThemeUtils.currentThemeColor = ThemeUtils.supportThemeColors[index];
        Constants.eventBus
            .fire(ThemeEvent(ThemeUtils.supportThemeColors[index]));
      }
    });

    Constants.eventBus.on<ThemeEvent>().listen((themeEvent) {
      setState(() {
        themeColor = themeEvent.color;
      });
    });

    pages = <Widget>[
      new NewsListPage(),
      new TweetsListPage(),
      new DiscoveryPage(),
      new MyInfoPage(),
    ];

    if (tableImages == null) {
      tableImages = [
        [
          getTableImage('images/ic_nav_news_normal.png'),
          getTableImage('images/ic_nav_news_actived.png')
        ],
        [
          getTableImage('images/ic_nav_tweet_normal.png'),
          getTableImage('images/ic_nav_tweet_actived.png')
        ],
        [
          getTableImage('images/ic_nav_discover_normal.png'),
          getTableImage('images/ic_nav_discover_actived.png')
        ],
        [
          getTableImage('images/ic_nav_my_normal.png'),
          getTableImage('images/ic_nav_my_pressed.png')
        ]
      ];
    }
  }

  TextStyle getTableTextStyle(int currentIndex) {
    return currentIndex == _tableIndex
        ? titleTextStyleSelected
        : titleTextStyleNormal;
  }

  Image getTableIcon(int currentIndex) {
    return currentIndex == _tableIndex
        ? tableImages[currentIndex][1]
        : tableImages[currentIndex][0];
  }

  Text getTableTitle(int currentIndex) {
    return Text(
      appBarTitles[currentIndex],
      style: getTableTextStyle(currentIndex),
    );
  }

  @override
  Widget build(BuildContext context) {
    _body = IndexedStack(
      index: _tableIndex,
      children: pages,
    );
    return MaterialApp(
      theme: ThemeData(primaryColor: themeColor),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            appBarTitles[_tableIndex],
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: _body,
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: getTableIcon(0),
              title: getTableTitle(0),
            ),
            BottomNavigationBarItem(
              icon: getTableIcon(1),
              title: getTableTitle(1),
            ),
            BottomNavigationBarItem(
              icon: getTableIcon(2),
              title: getTableTitle(2),
            ),
            BottomNavigationBarItem(
              icon: getTableIcon(3),
              title: getTableTitle(3),
            ),
          ],
          currentIndex: _tableIndex,
          onTap: (index){
            setState(() {
              _tableIndex = index;
            });
          },
        ),
        drawer: MyDrawer(),
      ),
    );
  }
}
