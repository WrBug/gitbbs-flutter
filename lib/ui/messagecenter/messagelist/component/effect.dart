import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/model/git_content_file.dart';
import 'package:gitbbs/network/github/model/github_message.dart';
import 'package:gitbbs/ui/messagecenter/messagelist/component/action.dart';

Effect<GithubMessage> buildEffect() {
  return combineEffects(<Object, Effect<GithubMessage>>{
    Lifecycle.initState: _init,
    MessageItemAction.onGetDetail: _onGetDetail
  });
}

void _init(Action action, Context<GithubMessage> ctx) {}

void _onGetDetail(Action action, Context<GithubMessage> ctx) {
  Navigator.of(ctx.context).push(MaterialPageRoute(builder: (ct) {
//    return IssueDetailPage().buildPage(ctx.state);
  }));
}
