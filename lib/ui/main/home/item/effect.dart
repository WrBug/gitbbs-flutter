import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/ui/issuedetail/issue_detail_page.dart';
import 'package:gitbbs/ui/main/home/item/action.dart';

Effect<GitIssue> buildEffect() {
  return combineEffects(
      <Object, Effect<GitIssue>>{IssueItemAction.onGetDetail: _onGetDetail});
}

void _onGetDetail(Action action, Context<GitIssue> ctx) {
  Navigator.of(ctx.context).push(MaterialPageRoute(builder: (ct) {
    return IssueDetailPage().buildPage(ctx.state);
  }));
}
