import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:gitbbs/ui/browsehistory/action.dart';
import 'package:gitbbs/ui/browsehistory/state.dart';

Widget buildView(
    BrowseHistoryPageState state, Dispatch dispatch, ViewService viewService) {
  if (state.easyRefreshKey.currentState != null) {
    state.easyRefreshKey.currentState.callRefreshFinish();
  }
  return Scaffold(
    key: state.scaffoldKey,
    appBar: AppBar(
      title: Text('浏览历史'),
    ),
    body: _bodyBuild(state, dispatch, viewService),
  );
}

_bodyBuild(
    BrowseHistoryPageState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter adapter = viewService.buildAdapter();
  return EasyRefresh(
      key: state.easyRefreshKey,
      child: ListView.builder(
        itemBuilder: adapter.itemBuilder,
        itemCount: adapter.itemCount,
      ),
      autoLoad: state.hasNext,
      refreshHeader: BezierCircleHeader(
        key: state.headerKey,
        color: Theme.of(viewService.context).scaffoldBackgroundColor,
      ),
      refreshFooter: BezierBounceFooter(
        key: state.footerKey,
        color: Theme.of(viewService.context).scaffoldBackgroundColor,
      ),
      autoControl: true,
      onRefresh: () {
        dispatch(BrowseHistoryCreator.loadDataAction());
      },
      loadMore: () {
        if (!state.hasNext) {
          state.footerKey.currentState.onNoMore();
          state.scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('页面到底了！')));
          return;
        }
        dispatch(BrowseHistoryCreator.loadMoreDataAction());
      });
}
