import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gitbbs/constant/ColorConstant.dart';
import 'package:gitbbs/model/GitUser.dart';
import 'package:gitbbs/model/UserCacheManager.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/ui/favoritelist/favorite_list_page.dart';
import 'package:gitbbs/ui/main/home/home_page.dart';
import 'package:gitbbs/ui/main/user_tab.dart';
import 'package:gitbbs/ui/widget/loading.dart';

void main() {
  UserCacheManager.init();
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: app_primary,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  var _currentPageIndex = 0;
  final items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("主页")),
    BottomNavigationBarItem(
        icon: Icon(Icons.question_answer), title: Text("问答")),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), title: Text("收藏")),
    BottomNavigationBarItem(icon: Icon(Icons.face), title: Text("我的"))
  ];
  var bodies;

  final title = ['主页', '问答', '收藏', '我的'];
  GitUser _user;
  StreamSubscription subscription;
  PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    bodies = [
      HomePage().buildPage(key, wantKeepAlive: true),
      Text("2"),
      FavoriteListPage().buildPage(key, wantKeepAlive: true),
      UserTab()
    ];
    _user = UserCacheManager.getUser();
    subscription = UserCacheManager.addUserChangedListener().listen((event) {
      if (!event.authFailed) {
        setState(() {
          _user = event.user;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: _currentPageIndex != 3
            ? Text(title[_currentPageIndex])
            : Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    onTap: () {},
                  ),
                  Center(
                    child: Text(_user == null ? '请登录' : _user.getName()),
                  )
                ],
              ),
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        onTap: (index) {
          _controller.jumpToPage(index);
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPageIndex,
      ),
      body: PageView.builder(
        controller: _controller,
        itemBuilder: (context, index) => bodies[index],
        itemCount: bodies.length,
        onPageChanged: _pageChange,
      ),
    );
  }

  void _pageChange(int index) {
    setState(() {
      if (_currentPageIndex != index) {
        _currentPageIndex = index;
      }
    });
  }
}
