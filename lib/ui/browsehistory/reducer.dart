import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/PagingData.dart';
import 'package:gitbbs/ui/browsehistory/action.dart';
import 'package:gitbbs/ui/browsehistory/state.dart';

Reducer<BrowseHistoryPageState> buildReducer() {
  return asReducer(<Object, Reducer<BrowseHistoryPageState>>{
    BrowseHistoryAction.onRefreshData: _refreshData,
    BrowseHistoryAction.onLoadMoreData: _loadMoreData,
  });
}

BrowseHistoryPageState _refreshData(
    BrowseHistoryPageState state, Action action) {
  final BrowseHistoryPageState newState = state.clone();
  final PagingData<GitIssue> data = action.payload;
  newState.list = data.data;
  newState.hasNext = data.hasNext;
  return newState;
}

BrowseHistoryPageState _loadMoreData(
    BrowseHistoryPageState state, Action action) {
  final PagingData<GitIssue> data = action.payload ?? PagingData;
  final BrowseHistoryPageState newState = state.clone();
  newState.list.addAll(data.data);
  newState.hasNext = data.hasNext;
  return newState;
}
