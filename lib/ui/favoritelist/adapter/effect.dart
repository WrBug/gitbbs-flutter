import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/ui/favoritelist/adapter/action.dart';
import 'package:gitbbs/ui/issuedetail/issue_detail_page.dart';

Effect<GitIssue> buildEffect() {
  return combineEffects(
      <Object, Effect<GitIssue>>{FavoriteItemAction.getDetail: _getDetail});
}

void _getDetail(Action action, Context<GitIssue> ctx) async {
  Navigator.of(ctx.context).push(MaterialPageRoute(builder: (ct) {
    return IssueDetailPage().buildPage(ctx.state);
  }));
}
