import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/PagingData.dart';
import 'package:gitbbs/ui/main/home/action.dart';
import 'package:gitbbs/ui/main/home/inner_action.dart';
import 'package:gitbbs/ui/main/home/page_state.dart';

Reducer<PageState> buildReducer() {
  return asReducer(<Object, Reducer<PageState>>{
//  PageAction.loadData:_
    PageInnerAction.refreshData: _refreshData,
    PageInnerAction.loadMoreData: _loadMoreData,
  });
}

PageState _refreshData(PageState state, Action action) {
  final PageState newState = PageState();
  final PagingData<GitIssue> data = action.payload ?? PagingData;
  newState.list = data.data;
  newState.hasNext = data.hasNext;
  return newState;
}

PageState _loadMoreData(PageState state, Action action) {
  final PagingData<GitIssue> data = action.payload ?? PagingData;
  final PageState newState = state.clone();
  newState.list.addAll(data.data);
  newState.hasNext = data.hasNext;
  return newState;
}
