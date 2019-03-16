import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/model/cachemanager/user_cache_manager.dart';
import 'package:gitbbs/model/entry/comment_edit_data.dart';
import 'package:gitbbs/model/entry/comment_list_data.dart';
import 'package:gitbbs/model/event/comments_count_changed_event.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/network/github/GithubHttpRequest.dart';
import 'package:gitbbs/ui/editcomment/edit_comment_page.dart';
import 'package:gitbbs/ui/editissue/bean/edit_issue_info.dart';
import 'package:gitbbs/ui/editissue/edit_issue_page.dart';
import 'package:gitbbs/ui/issuedetail/action.dart';
import 'package:gitbbs/ui/issuedetail/bean/issue_cache.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/comment_list_page.dart';
import 'package:gitbbs/ui/issuedetail/state.dart';
import 'package:gitbbs/util/event_bus_helper.dart';
import 'package:gitbbs/model/cachemanager/issue_cache_manager.dart';

Effect<IssueDetailState> buildEffect() {
  return combineEffects(<Object, Effect<IssueDetailState>>{
    Lifecycle.initState: _init,
    IssueDetailAction.toggleCommentsVisible: _toggleCommentVisible,
    IssueDetailAction.addComment: _addComment,
    IssueDetailAction.toggleFavorite: _toggleFavorite,
    IssueDetailAction.showAuthorPopMenu: _showAuthorPopMenuAction
  });
}

void _init(Action action, Context<IssueDetailState> ctx) async {
  EventBusHelper.on<CommentCountChangedEvent>().listen((event) {
    ctx.dispatch(IssueDetailActionCreator.onCommentsCountChangedAction(event));
  });
  var body =
      await IssueCacheManager.getIssueCache(ctx.state.originIssue.getNumber());
  var map = await UserCacheManager.getFavoriteMap();
  ctx.dispatch(IssueDetailActionCreator.updateCacheAction(
      IssueCache(body, map.containsKey(ctx.state.originIssue.getId()))));
  GitHttpRequest request = GitHttpRequest.getInstance();
  var issue = await request.getIssue(ctx.state.originIssue.getNumber());
  ctx.dispatch(IssueDetailActionCreator.update(issue));
}

void _showAuthorPopMenuAction(
    Action action, Context<IssueDetailState> ctx) async {
  final result = await showMenu(
      context: ctx.context,
      position: RelativeRect.fromLTRB(2000.0, 90, 10.0, 10.0),
      items: <PopupMenuEntry<String>>[
        new PopupMenuItem<String>(
            value: 'edit',
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.mode_edit,
                  size: 18,
                ),
                Padding(padding: EdgeInsets.fromLTRB(16, 0, 0, 0)),
                new Text('编辑')
              ],
            )),
        new PopupMenuDivider(height: 1.0),
        new PopupMenuItem<String>(
            value: 'delete',
            child: new Row(
              children: <Widget>[
                Icon(
                  Icons.delete_forever,
                  size: 16,
                ),
                Padding(padding: EdgeInsets.fromLTRB(16, 0, 0, 0)),
                new Text('删除')
              ],
            ))
      ]);
  if (result == 'edit') {
    Navigator.of(ctx.context).push(MaterialPageRoute(
        builder: (context) => EditIssuePage().buildPage(EditIssueInfo(
            IssueType.article, IssueEditType.modify, ctx.state.getIssue()))));
  }
}

void _toggleFavorite(Action action, Context<IssueDetailState> ctx) async {
  if (ctx.state.favorite) {
    UserCacheManager.removeFavorite(ctx.state.getIssue().getId());
  } else {
    UserCacheManager.addFavorite(ctx.state.getIssue());
  }
  ctx.dispatch(IssueDetailActionCreator.onFavoriteStatusChangedAction(
      !ctx.state.favorite));
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
  })).then((comment) {
    if (comment != null) {
      ctx.dispatch(IssueDetailActionCreator.onCommentsCountChangedAction(
          CommentCountChangedEvent(true, action.payload.getNumber())));
    }
  });
}
