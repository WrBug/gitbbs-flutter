import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:gitbbs/ui/main/home/action.dart';
import 'package:gitbbs/ui/main/home/effect.dart';
import 'package:gitbbs/ui/main/home/item/adapter.dart';
import 'package:gitbbs/ui/main/home/page_state.dart';
import 'package:gitbbs/ui/main/home/reducer.dart';

class HomePage extends Page<PageState, Map<String, dynamic>> {
  HomePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: _buildView,
          dependencies: Dependencies<PageState>(
              adapter: IssueListAdapter(),
              slots: <String, Dependent<PageState>>{
              }),
        );
}
GlobalKey<EasyRefreshState> _easyRefreshKey =
new GlobalKey<EasyRefreshState>();
GlobalKey<RefreshHeaderState> _headerKey =
new GlobalKey<RefreshHeaderState>();
GlobalKey<RefreshFooterState> _footerKey =
new GlobalKey<RefreshFooterState>();
Widget _buildView(PageState state, Dispatch dispatch, ViewService viewService) {

  final ListAdapter adapter = viewService.buildAdapter();
  return EasyRefresh(
    key: _easyRefreshKey,
    child: ListView.builder(
      itemBuilder: adapter.itemBuilder,
      itemCount: adapter.itemCount,
    ),
    autoLoad: state.hasNext,
    refreshHeader: BezierCircleHeader(
      key: _headerKey,
      color: Theme.of(viewService.context).scaffoldBackgroundColor,
    ),
    refreshFooter: BezierBounceFooter(
      key: _footerKey,
      color: Theme.of(viewService.context).scaffoldBackgroundColor,
    ),
    onRefresh: () {
      dispatch(PageActionCreator.onRefreshDataAction());
    },
    loadMore: state.hasNext
        ? () {
            if (!state.hasNext) {
              return;
            }
            dispatch(PageActionCreator.onLoadMoreDataAction());
          }
        : null,
  );
}
