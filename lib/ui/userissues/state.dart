import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:gitbbs/model/GitIssue.dart';

class UserIssuesPageState implements Cloneable<UserIssuesPageState> {
  List<GitIssue> list;
  String username;
  bool hasNext;
  GlobalKey<EasyRefreshState> easyRefreshKey;
  GlobalKey<RefreshHeaderState> headerKey;
  GlobalKey<RefreshFooterState> footerKey;
  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  UserIssuesPageState clone() {
    return UserIssuesPageState()
      ..list = list == null ? null : List.of(list)
      ..scaffoldKey = scaffoldKey
      ..easyRefreshKey = easyRefreshKey
      ..username = username
      ..headerKey = headerKey
      ..footerKey = footerKey
      ..hasNext = hasNext;
  }
}

UserIssuesPageState initState(String username) {
  var state = UserIssuesPageState();
  state.easyRefreshKey = GlobalKey<EasyRefreshState>();
  state.hasNext = false;
  state.username = username;
  state.headerKey = GlobalKey<RefreshHeaderState>();
  state.footerKey = GlobalKey<RefreshFooterState>();
  state.scaffoldKey = GlobalKey();
  return state;
}
