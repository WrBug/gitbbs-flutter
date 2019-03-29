import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/ui/login/login.dart';
import 'package:gitbbs/ui/userissues/adapter.dart';
import 'package:gitbbs/ui/userissues/reducer.dart';
import 'package:gitbbs/ui/userissues/effect.dart';
import 'package:gitbbs/ui/userissues/state.dart';
import 'view.dart';

class UserIssuePage extends Page<UserIssuesPageState, String> {
  UserIssuePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<UserIssuesPageState>(
              adapter: UserIssueListAdapter()),
        );

  static Future start(BuildContext context, String username) async {
    var login = await LoginPage.checkLoginAndStart(context);
    if (login == true) {
      return Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UserIssuePage().buildPage(username)));
    }
    return null;
  }
}
