import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/PagingData.dart';
import 'package:gitbbs/ui/userissues/action.dart';
import 'package:gitbbs/ui/userissues/state.dart';

Reducer<UserIssuesPageState> buildReducer() {
  return asReducer(<Object, Reducer<UserIssuesPageState>>{
    UserIssuesAction.onRefreshData: _refreshData,
    UserIssuesAction.onLoadMoreData: _loadMoreData,
  });
}

UserIssuesPageState _refreshData(UserIssuesPageState state, Action action) {
  final UserIssuesPageState newState = state.clone();
  final PagingData<GitIssue> data = action.payload;
  if (state?.list?.isNotEmpty == true && data.hasNext) {
    data.data.last.setMore(true);
  }
  if (newState?.list?.isNotEmpty == true) {
    data.data.addAll(newState.list);
  }
  newState.list = data.data;
  return newState;
}

UserIssuesPageState _loadMoreData(UserIssuesPageState state, Action action) {
  final PagingData<GitIssue> data = action.payload ?? PagingData;
  final UserIssuesPageState newState = state.clone();
  newState.list.addAll(data.data);
  newState.hasNext = data.hasNext;
  return newState;
}
