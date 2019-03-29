import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/model/cachemanager/user_cache_manager.dart';
import 'package:gitbbs/ui/login/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'view.dart';

class LoginPage extends Page<LoginPageState, dynamic> {
  LoginPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView);

  static Future checkLoginAndStart(BuildContext context) {
    if (UserCacheManager.isAuthFailed() != true) {
      return Future.value(true);
    }
    return Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => LoginPage().buildPage(null)));
  }
}
