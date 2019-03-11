import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/model/entry/comment_edit_data.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/network/github/GithubHttpRequest.dart';
import 'package:gitbbs/ui/editcomment/edit_comment_page.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/action.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/state.dart';

Effect<CommentListState> buildEffect() {
  return combineEffects(<Object, Effect<CommentListState>>{
    Lifecycle.initState: _init,
    CommentListAction.editComment: _editComment,
    CommentListAction.replyComment: _reply
  });
}

void _init(Action action, Context<CommentListState> ctx) async {
  GitHttpRequest request = GithubHttpRequest.getInstance();
  var pagingData = await request.getComments(ctx.state.issue.getNumber(), null);
  ctx.dispatch(CommentListActionCreator.updateAction(pagingData));
}

void _editComment(Action action, Context<CommentListState> ctx) {
  Navigator.of(ctx.context).push(MaterialPageRoute(
      builder: (context) => EditCommentPage().buildPage(CommentEditData(
          ctx.state.issue, Type.modify,
          comment: action.payload))));
}

void _reply(Action action, Context<CommentListState> ctx) {
  Navigator.of(ctx.context).push(MaterialPageRoute(
      builder: (context) => EditCommentPage().buildPage(CommentEditData(
          ctx.state.issue, Type.reply,
          comment: action.payload))));
}
