import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/model/GitUser.dart';
import 'package:gitbbs/model/cachemanager/user_cache_manager.dart';

class UserInfoState implements Cloneable<UserInfoState> {
  GitUser gitUser;
  GlobalKey<ScaffoldState> scaffoldKey;
  bool authFailed;

  @override
  UserInfoState clone() {
    return UserInfoState()
      ..gitUser = gitUser
      ..authFailed = authFailed
      ..scaffoldKey = scaffoldKey;
  }
}

UserInfoState initState(GlobalKey<ScaffoldState> key) {
  return UserInfoState()
    ..gitUser = UserCacheManager.getUser()
    ..authFailed = UserCacheManager.isAuthFailed()
    ..scaffoldKey = key;
}
