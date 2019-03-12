import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/model/entry/comment_edit_data.dart';
import 'package:gitbbs/model/entry/comment_list_data.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/network/github/GithubHttpRequest.dart';
import 'package:gitbbs/ui/editcomment/edit_comment_page.dart';
import 'package:gitbbs/ui/issuedetail/action.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/comment_list_page.dart';
import 'package:gitbbs/ui/issuedetail/state.dart';

Effect<IssueDetailState> buildEffect() {
  return combineEffects(<Object, Effect<IssueDetailState>>{
    Lifecycle.initState: _init,
    IssueDetailAction.toggleCommentsVisible: _toggleCommentVisible,
    IssueDetailAction.addComment: _addComment
  });
}

void _init(Action action, Context<IssueDetailState> ctx) async {
  GitHttpRequest request = GithubHttpRequest.getInstance();
  var issue = await request.getIssue(ctx.state.originIssue.getNumber());
  ctx.dispatch(IssueDetailActionCreator.update(issue));
}

void _toggleCommentVisible(Action action, Context<IssueDetailState> ctx) async {
  final context = action.payload ?? BuildContext;
  if (!ctx.state.isCommentsShown()) {
    ctx.state.controller = showBottomSheet(
        context: context,
        builder: (context) {
          return CommentListPage().buildPage(
              CommentListData(ctx.state.getIssue(), ctx.state.scaffoldKey));
        });
    ctx.state.controller.closed.whenComplete(() {
      ctx.state.controller = null;
      ctx.dispatch(IssueDetailActionCreator.commentsVisibleChangedAction());
    });
    ctx.dispatch(IssueDetailActionCreator.commentsVisibleChangedAction());
  } else {
    ctx.state.controller.close();
  }
}

void _addComment(Action action, Context<IssueDetailState> ctx) async {
  Navigator.of(ctx.context).push(MaterialPageRoute(builder: (context) {
    return EditCommentPage()
        .buildPage(CommentEditData(action.payload, Type.add));
  }));
}
