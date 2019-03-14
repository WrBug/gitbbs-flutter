import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/model/event/comments_count_changed_event.dart';
import 'package:gitbbs/ui/issuedetail/bean/issue_cache.dart';

enum IssueDetailAction {
  update,
  updateCache,
  addComment,
  toggleFavorite,
  toggleCommentsVisible,
  commentsVisibleChanged,
  onCommentsCountChanged,
  onFavoriteStatusChanged
}

class IssueDetailActionCreator {
  static Action update(GitIssue issue) {
    return Action(IssueDetailAction.update, payload: issue);
  }

  static Action toggleFavoriteAction() {
    return Action(IssueDetailAction.toggleFavorite);
  }

  static Action updateCacheAction(IssueCache cache) {
    return Action(IssueDetailAction.updateCache, payload: cache);
  }

  static Action onFavoriteStatusChangedAction(bool changed) {
    return Action(IssueDetailAction.onFavoriteStatusChanged, payload: changed);
  }

  static Action commentsVisibleChangedAction() {
    return const Action(IssueDetailAction.commentsVisibleChanged);
  }

  static Action toggleCommentsVisible(BuildContext context) {
    return Action(IssueDetailAction.toggleCommentsVisible, payload: context);
  }

  static Action addCommentAction(GitIssue issue) {
    return Action(IssueDetailAction.addComment, payload: issue);
  }

  static Action onCommentsCountChangedAction(CommentCountChangedEvent event) {
    return Action(IssueDetailAction.onCommentsCountChanged, payload: event);
  }
}
