import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/cachemanager/user_cache_manager.dart';

class FavoriteListState implements Cloneable<FavoriteListState> {
  List<GitIssue> list;
  GlobalKey<EasyRefreshState> easyRefreshKey;
  GlobalKey<RefreshHeaderState> headerKey;
  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  FavoriteListState clone() {
    return FavoriteListState()
      ..list = List.of(list)
      ..scaffoldKey = scaffoldKey
      ..easyRefreshKey = easyRefreshKey
      ..headerKey = headerKey;
  }
}

FavoriteListState initState(GlobalKey<ScaffoldState> scaffoldKey) {
  return FavoriteListState()
    ..list = []
    ..easyRefreshKey = GlobalKey<EasyRefreshState>()
    ..headerKey = GlobalKey<RefreshHeaderState>()
    ..scaffoldKey = scaffoldKey;
}
