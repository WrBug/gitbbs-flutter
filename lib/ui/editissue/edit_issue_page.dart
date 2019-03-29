import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/ui/editissue/bean/edit_issue_info.dart';
import 'package:gitbbs/ui/editissue/effect.dart';
import 'package:gitbbs/ui/editissue/reducer.dart';
import 'package:gitbbs/ui/editissue/state.dart';
import 'package:gitbbs/ui/login/login.dart';
import 'view.dart';

class EditIssuePage extends Page<EditIssueState, EditIssueInfo> {
  EditIssuePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView);

  static Future start(BuildContext context, EditIssueInfo info) async {
    bool login = await LoginPage.checkLoginAndStart(context);
    if (login == true) {
      return Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EditIssuePage().buildPage(info)));
    }
    return null;
  }
}
