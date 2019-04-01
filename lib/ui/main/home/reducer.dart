import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/PagingData.dart';
import 'package:gitbbs/model/db/gitissue_data_base.dart';
import 'package:gitbbs/model/entry/midddle_issues_data.dart';
import 'package:gitbbs/model/event/comments_count_changed_event.dart';
import 'package:gitbbs/ui/main/home/inner_action.dart';
import 'package:gitbbs/ui/main/home/page_state.dart';

Reducer<PageState> buildReducer() {
  return asReducer(<Object, Reducer<PageState>>{
    PageInnerAction.loadInitData: _loadInitData,
    PageInnerAction.refreshData: _refreshData,
    PageInnerAction.refreshMiddleData: _refreshMiddleData,
    PageInnerAction.loadMoreData: _loadMoreData,
    PageInnerAction.showMiddleProgress: _showMiddleProgress,
    PageInnerAction.onCommentsCountChanged: _onCommentsCountChanged
  });
}

PageState _loadInitData(PageState state, Action action) {
  final PageState newState = state.clone();
  newState.list = action.payload;
  newState.hasNext = true;
  return newState;
}

PageState _refreshData(PageState state, Action action) {
  final PageState newState = state.clone();
  final PagingData<GitIssue> data = action.payload ?? PagingData;
  if (state?.list?.isNotEmpty == true && data.hasNext) {
    data.data.last.setMore(true);
  }
  data.data.addAll(newState.list);
  newState.list = data.data;
  return newState;
}

PageState _refreshMiddleData(PageState state, Action action) {
  final MiddleIssuesData issuesData = action.payload[0] ?? MiddleIssuesData;
  List<GitIssue> changedList = List();
  issuesData.afterIssue.setMore(false);
  changedList.add(issuesData.afterIssue);
  issuesData.refreshing = false;
  final PagingData<GitIssue> data = action.payload[1] ?? PagingData;
  var index = state.list.indexOf(issuesData.afterIssue);
  if (state.list.isNotEmpty == true && data.hasNext) {
    data.data.last.setMore(true);
    changedList.add(data.data.last);
  }
  state.progressingList.remove(issuesData.afterIssue);
  state.list.insertAll(index + 1, data.data);
  final PageState newState = state.clone();
  GitIssueDataBase.createInstance().saveAll(changedList);
  return newState;
}

PageState _loadMoreData(PageState state, Action action) {
  final PagingData<GitIssue> data = action.payload ?? PagingData;
  final PageState newState = state.clone();
  newState.list.addAll(data.data);
  newState.hasNext = data.hasNext;
  return newState;
}

PageState _showMiddleProgress(PageState state, Action action) {
  final MiddleIssuesData data = action.payload ?? MiddleIssuesData;
  final PageState newState = state.clone();
  newState.progressingList.add(data.afterIssue);
  return newState;
}

PageState _onCommentsCountChanged(PageState state, Action action) {
  CommentCountChangedEvent event = action.payload;
  final PageState newState = state.clone();
  bool find = false;
  for (var item in newState.list) {
    if (item.getNumber() == event.number) {
      find = true;
      if (event.isAdd) {
        item.comments++;
      } else {
        item.comments--;
      }
      break;
    }
  }
  return find ? newState : state;
}
