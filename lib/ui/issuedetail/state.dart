import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/issue_cache_manager.dart';

class IssueDetailState implements Cloneable<IssueDetailState> {
  GitIssue originIssue;
  GitIssue issue;
  PersistentBottomSheetController controller;

  GitIssue getIssue() {
    return issue == null ? originIssue : issue;
  }

  bool isCommentsShown() {
    return controller != null;
  }

  String getBody() {
    var body = getIssue().getBody();
    if (body != null) {
      return body;
    }
    body = IssueCacheManager.getCache(getIssue().getNumber());
    return body;
  }

  @override
  IssueDetailState clone() {
    return IssueDetailState()
      ..originIssue = originIssue
      ..controller = controller
      ..issue = issue;
  }
}

IssueDetailState initState(GitIssue issue) {
  final IssueDetailState state = IssueDetailState();
  state.originIssue = issue;
  return state;
}
