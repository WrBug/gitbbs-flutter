import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:gitbbs/ui/favoritelist/action.dart';
import 'package:gitbbs/ui/favoritelist/state.dart';

Widget buildView(
    FavoriteListState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter adapter = viewService.buildAdapter();
  if (state.easyRefreshKey.currentState != null) {
    state.easyRefreshKey.currentState.callRefreshFinish();
  }
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
    autoControl: false,
    onRefresh: () {
      dispatch(FavoriteListActionCreator.refreshDataAction());
    },
  );
}
