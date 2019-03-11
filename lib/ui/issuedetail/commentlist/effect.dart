import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/network/github/GithubHttpRequest.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/action.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/state.dart';

Effect<CommentListState> buildEffect() {
  return combineEffects(<Object, Effect<CommentListState>>{
    Lifecycle.initState: _init,
  });
}

void _init(Action action, Context<CommentListState> ctx) async {
  GitHttpRequest request = GithubHttpRequest.getInstance();
  var pagingData = await request.getComments(ctx.state.issue.getNumber(), null);
  ctx.dispatch(CommentListActionCreator.updateAction(pagingData));
}
