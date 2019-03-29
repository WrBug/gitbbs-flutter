import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:gitbbs/model/GitUser.dart';
import 'package:gitbbs/model/cachemanager/user_cache_manager.dart';

class UserInfoState implements Cloneable<UserInfoState> {
  GitUser gitUser;
  GlobalKey<ScaffoldState> scaffoldKey;
  int favoriteCount;
  bool authFailed;
  int todayHistoryCount;
  GlobalKey<EasyRefreshState> easyRefreshKey;
  GlobalKey<RefreshHeaderState> headerKey;

  @override
  UserInfoState clone() {
    return UserInfoState()
      ..gitUser = gitUser
      ..favoriteCount = favoriteCount
      ..todayHistoryCount = todayHistoryCount
      ..authFailed = authFailed
      ..easyRefreshKey = easyRefreshKey
      ..headerKey = headerKey
      ..scaffoldKey = scaffoldKey;
  }
}

UserInfoState initState(GlobalKey<ScaffoldState> key) {
  return UserInfoState()
    ..gitUser = UserCacheManager.getUser()
    ..authFailed = UserCacheManager.isAuthFailed()
    ..easyRefreshKey = GlobalKey()
    ..headerKey = GlobalKey()
    ..scaffoldKey = key;
}
