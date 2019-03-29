import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/model/cachemanager/user_cache_manager.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/ui/login/login.dart';
import 'package:gitbbs/ui/userinfo/action.dart';
import 'package:gitbbs/ui/userinfo/bean/user_update_info.dart';
import 'package:gitbbs/ui/userinfo/user_info_state.dart';

Effect<UserInfoState> buildEffect() {
  return combineEffects(<Object, Effect<UserInfoState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    UserInfoAction.goLogin: _goLogin,
    UserInfoAction.refresh: _refresh,
    UserInfoAction.logout: _logout
  });
}

StreamSubscription subscription;

void _dispose(Action action, Context<UserInfoState> ctx) {
  if (subscription != null) {
    subscription.cancel();
    subscription = null;
  }
}

void _init(Action action, Context<UserInfoState> ctx) async {
  subscription = UserCacheManager.addUserChangedListener().listen((event) {
    ctx.dispatch(UserInfoActionCreator.onUserStatusChangedAction(event));
    _refresh(action, ctx);
  });
  _refresh(action, ctx);
}

void _refresh(Action action, Context<UserInfoState> ctx) async {
  if (ctx.state.gitUser == null) {
    return;
  }
  GitHttpRequest request = GitHttpRequest.getInstance();
  var count = await request.getUserIssuesCount(ctx.state.gitUser.getName());
  var favoriteCount = (await UserCacheManager.getFavoriteList()).length;
  ctx.dispatch(UserInfoActionCreator.onRefreshedAction(
      UserUpdateInfo(favoriteCount, count, 0)));
}

void _goLogin(Action action, Context<UserInfoState> ctx) {
  LoginPage.checkLoginAndStart(ctx.context);
}

void _logout(Action action, Context<UserInfoState> ctx) {
  showDialog(
      context: ctx.context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('提示'),
          content: Text('是否退出当前账号？'),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('取消')),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  UserCacheManager.removeCache();
                },
                child: Text('确定')),
          ],
        );
      });
}
