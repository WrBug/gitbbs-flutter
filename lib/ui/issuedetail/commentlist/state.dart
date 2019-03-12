import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/entry/comment_list_data.dart';
import 'package:gitbbs/model/git_comment.dart';
import 'package:gitbbs/network/github/model/GithubComment.dart';

class CommentListState implements Cloneable<CommentListState> {
  GitIssue issue;
  List<GitComment> list;
  GlobalKey<EasyRefreshState> easyRefreshKey;
  GlobalKey<RefreshHeaderState> headerKey;
  GlobalKey<RefreshFooterState> footerKey;
  GlobalKey<ScaffoldState> scaffoldKey;

  bool hasNext;

  @override
  CommentListState clone() {
    return CommentListState()
      ..issue = issue
      ..easyRefreshKey = easyRefreshKey
      ..headerKey = headerKey
      ..footerKey = footerKey
      ..scaffoldKey = scaffoldKey
      ..hasNext = hasNext
      ..list = List.of(list);
  }
}

CommentListState initState(CommentListData data) {
  CommentListState state = CommentListState();
  state.issue = data.issue;
  state.scaffoldKey = data.scaffoldKey;
  state.list = List();
  state.hasNext = true;
  state.easyRefreshKey = new GlobalKey<EasyRefreshState>();
  state.headerKey = new GlobalKey<RefreshHeaderState>();
  state.footerKey = new GlobalKey<RefreshFooterState>();
  return state;
}
