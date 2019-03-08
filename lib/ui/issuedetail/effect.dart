import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/network/github/GithubHttpRequest.dart';
import 'package:gitbbs/ui/issuedetail/action.dart';
import 'package:gitbbs/ui/issuedetail/state.dart';

Effect<IssueDetailState> buildEffect() {
  return combineEffects(
      <Object, Effect<IssueDetailState>>{Lifecycle.initState: _init});
}

void _init(Action action, Context<IssueDetailState> ctx) async {
  GitHttpRequest request = GithubHttpRequest.getInstance();
  var issue = await request.getIssue(ctx.state.number);
  ctx.dispatch(IssueDetailActionCreator.update(issue));
}
