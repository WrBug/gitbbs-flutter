import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/git_content_file.dart';
import 'package:gitbbs/network/github/model/github_message.dart';

class MessageListPageState implements Cloneable<MessageListPageState> {
  List<GithubMessage> list;
  GlobalKey<EasyRefreshState> easyRefreshKey;
  GlobalKey<RefreshHeaderState> headerKey;
  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  MessageListPageState clone() {
    return MessageListPageState()
      ..list = list == null ? null : List.of(list)
      ..scaffoldKey = scaffoldKey
      ..easyRefreshKey = easyRefreshKey
      ..headerKey = headerKey;
  }
}

MessageListPageState initState(dynamic data) {
  var state = MessageListPageState();
  state.easyRefreshKey = GlobalKey<EasyRefreshState>();
  state.headerKey = GlobalKey<RefreshHeaderState>();
  state.scaffoldKey = GlobalKey();
  return state;
}
