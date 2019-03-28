import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/model/cachemanager/user_cache_manager.dart';
import 'package:gitbbs/ui/login/login.dart';
import 'package:gitbbs/ui/userinfo/action.dart';
import 'package:gitbbs/ui/userinfo/user_info_state.dart';

Effect<UserInfoState> buildEffect() {
  return combineEffects(<Object, Effect<UserInfoState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    UserInfoAction.goLogin: _goLogin
  });
}

StreamSubscription subscription;

void _dispose(Action action, Context<UserInfoState> ctx) {
  if (subscription != null) {
    subscription.cancel();
    subscription = null;
  }
}

void _init(Action action, Context<UserInfoState> ctx) {
  subscription = UserCacheManager.addUserChangedListener().listen((event) {
    ctx.dispatch(UserInfoActionCreator.onUserStatusChangedAction(event));
  });
}

void _goLogin(Action action, Context<UserInfoState> ctx) {
  Navigator.push(ctx.context,
      MaterialPageRoute(builder: (context) => LoginPage().buildPage(null)));
}
