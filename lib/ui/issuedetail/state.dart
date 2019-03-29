import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/model/GitIssue.dart';

class IssueDetailState implements Cloneable<IssueDetailState> {
  GitIssue originIssue;
  GitIssue issue;
  String body;
  bool favorite;
  PersistentBottomSheetController controller;
  GlobalKey<ScaffoldState> scaffoldKey;

  GitIssue getIssue() {
    return issue == null ? originIssue : issue;
  }

  bool isCommentsShown() {
    return controller != null;
  }

  @override
  IssueDetailState clone() {
    return IssueDetailState()
      ..originIssue = originIssue
      ..controller = controller
      ..scaffoldKey = scaffoldKey
      ..body = body
      ..favorite = favorite
      ..issue = issue;
  }
}

IssueDetailState initState(GitIssue issue) {
  final IssueDetailState state = IssueDetailState();
  state.originIssue = issue;
  state.favorite = false;
  state.body = issue.body;
  state.scaffoldKey = GlobalKey<ScaffoldState>();
  return state;
}
