import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:flutter/material.dart';

enum IssueDetailAction { update, toggleCommentsVisible, commentsVisibleChanged }

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
}
