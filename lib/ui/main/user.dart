import 'package:flutter/material.dart';
import 'package:gitbbs/constant/ColorConstant.dart';
import 'package:gitbbs/model/GitUser.dart';
import 'package:gitbbs/model/UserCacheManager.dart';

class UserTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserTab();
}

class _UserTab extends State<UserTab> {
  GitUser _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = UserCacheManager.getUser();
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
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(6),
          ),
          Center(
              child: ClipOval(
            child: FadeInImage.assetNetwork(
              placeholder: "assets/github.png",
              //预览图
              fit: BoxFit.fitWidth,
              image: _user.avatarUrl,
              width: 60.0,
              height: 60.0,
            ),
          )),
          Padding(
            padding: EdgeInsets.all(8),
          ),
          Center(
              child: Text(
            _user.bio,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ))
        ],
      ),
    );
  }
}
