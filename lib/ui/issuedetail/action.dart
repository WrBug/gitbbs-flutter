import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/model/event/comments_count_changed_event.dart';

enum IssueDetailAction {
  update,
  addComment,
  toggleCommentsVisible,
  commentsVisibleChanged,
  onCommentsCountChanged,
}

class IssueDetailActionCreator {
  static Action update(GitIssue issue) {
    return Action(IssueDetailAction.update, payload: issue);
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
