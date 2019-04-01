import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:gitbbs/ui/messagecenter/messagelist/action.dart';
import 'package:gitbbs/ui/messagecenter/messagelist/state.dart';

Widget buildView(
    MessageListPageState state, Dispatch dispatch, ViewService viewService) {
  if (state.easyRefreshKey.currentState != null) {
    state.easyRefreshKey.currentState.callRefreshFinish();
  }
  return Scaffold(
    key: state.scaffoldKey,
    appBar: AppBar(
      title: Text('消息中心'),
    ),
    body: _bodyBuild(state, dispatch, viewService),
  );
}

_bodyBuild(
    MessageListPageState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter adapter = viewService.buildAdapter();
  return EasyRefresh(
      key: state.easyRefreshKey,
      child: ListView.builder(
        itemBuilder: adapter.itemBuilder,
        itemCount: adapter.itemCount,
      ),
      refreshHeader: BezierCircleHeader(
        key: state.headerKey,
        color: Theme.of(viewService.context).scaffoldBackgroundColor,
      ),
      autoControl: true,
      onRefresh: () {
        dispatch(MessageListActionCreator.refreshDataAction());
      });
}
