import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:gitbbs/model/GitIssue.dart';

class BrowseHistoryPageState implements Cloneable<BrowseHistoryPageState> {
  List<GitIssue> list;
  bool hasNext;
  GlobalKey<EasyRefreshState> easyRefreshKey;
  GlobalKey<RefreshHeaderState> headerKey;
  GlobalKey<RefreshFooterState> footerKey;
  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  BrowseHistoryPageState clone() {
    return BrowseHistoryPageState()
      ..list = list == null ? null : List.of(list)
      ..scaffoldKey = scaffoldKey
      ..easyRefreshKey = easyRefreshKey
      ..headerKey = headerKey
      ..footerKey = footerKey
      ..hasNext = hasNext;
  }
}

BrowseHistoryPageState initState(dynamic data) {
  var state = BrowseHistoryPageState();
  state.easyRefreshKey = GlobalKey<EasyRefreshState>();
  state.hasNext = false;
  state.headerKey = GlobalKey<RefreshHeaderState>();
  state.footerKey = GlobalKey<RefreshFooterState>();
  state.scaffoldKey = GlobalKey();
  return state;
}
