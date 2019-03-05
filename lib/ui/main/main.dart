import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gitbbs/constant/ColorConstant.dart';
import 'package:gitbbs/model/GitUser.dart';
import 'package:gitbbs/model/UserCacheManager.dart';
import 'package:gitbbs/model/event/UserUpdatedEvent.dart';
import 'package:gitbbs/ui/main/home.dart';
import 'package:gitbbs/ui/main/user.dart';
import 'package:gitbbs/util/EventBusHelper.dart';

void main() {
  UserCacheManager.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: app_primary,
      ),
      home: MyHomePage(title: 'Gitbbs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var index = 0;
  final items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("主页")),
    BottomNavigationBarItem(
        icon: Icon(Icons.question_answer), title: Text("问答")),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), title: Text("收藏")),
    BottomNavigationBarItem(icon: Icon(Icons.face), title: Text("我的"))
  ];
  final title = ['主页', '问答', '收藏', '我的'];
  final bodies = [HomeTab(), Text("2"), Text("3"), UserTab()];
  GitUser _user;
  StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
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
      appBar: AppBar(
        title: index != 3
            ? Text(title[index])
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
                    child: Text(_user == null ? '请登录' : _user.name),
                  )
                ],
              ),
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        onTap: (index) {
          setState(() {
            this.index = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
      ),
      body: bodies[index],
    );
  }
}
