import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:gitbbs/ui/main/home/action.dart';
import 'package:gitbbs/ui/main/home/page_state.dart';

Widget buildView(PageState state, Dispatch dispatch, ViewService viewService) {
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
        dispatch(PageActionCreator.onRefreshDataAction());
      },
      loadMore: () {
        if (!state.hasNext) {
          state.footerKey.currentState.onNoMore();
          state.scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('页面到底了！')));
          return;
        }
        dispatch(PageActionCreator.onLoadMoreDataAction());
      });
}
