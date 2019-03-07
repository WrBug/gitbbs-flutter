import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/constant/ColorConstant.dart';
import 'package:gitbbs/model/GitUser.dart';
import 'package:gitbbs/model/UserCacheManager.dart';
import 'package:gitbbs/ui/login/login_page.dart';
import 'package:gitbbs/ui/widget/avatar_img.dart';

class UserTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserTab();
}

class _UserTab extends State<UserTab> {
  GitUser _user;
  bool _authFailed = false;
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _user = UserCacheManager.getUser();
    _authFailed = UserCacheManager.isAuthFailed();
    _subscription = UserCacheManager.addUserChangedListener().listen((event) {
      setState(() {
        _authFailed = event.authFailed;
        _user = event.user;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _headerBuild(),
          Container(
            height: 3000,
          )
        ],
      ),
    );
  }

  _headerBuild() {
    return Container(
        color: app_primary,
        height: 130,
        child: _authFailed || _user == null
            ? _noUserHeaderBuild()
            : _normalHeaderBuild());
  }

  _noUserHeaderBuild() {
    return Center(
        child: GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Text(
        '点击登录>>',
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    ));
  }

  _normalHeaderBuild() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(6),
        ),
        Center(child: AvatarImg(_user.getAvatarUrl())),
        Padding(
          padding: EdgeInsets.all(8),
        ),
        Center(
            child: Text(
          _user.bio,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ))
      ],
    );
  }
}
