import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:gitbbs/model/GitIssue.dart';

class PageState extends Cloneable<PageState> {
  List<GitIssue> list = List();
  bool hasNext = false;
  List<GitIssue> progressingList = List();
  GlobalKey<EasyRefreshState> easyRefreshKey;
  GlobalKey<RefreshHeaderState> headerKey;
  GlobalKey<RefreshFooterState> footerKey;
  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  PageState clone() {
    return PageState()
      ..list = List.of(list)
      ..progressingList = List.of(progressingList)
      ..scaffoldKey = scaffoldKey
      ..easyRefreshKey = easyRefreshKey
      ..headerKey = headerKey
      ..footerKey = footerKey
      ..hasNext = hasNext;
  }
}

PageState initState(GlobalKey<ScaffoldState> scaffoldKey) {
  var state = PageState();
  state.easyRefreshKey = new GlobalKey<EasyRefreshState>();
  state.headerKey = new GlobalKey<RefreshHeaderState>();
  state.footerKey = new GlobalKey<RefreshFooterState>();
  state.scaffoldKey = scaffoldKey;
  return state;
}
