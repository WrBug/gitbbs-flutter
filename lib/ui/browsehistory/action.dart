import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/PagingData.dart';

enum BrowseHistoryAction { loadData, onRefreshData, loadMoreData, onLoadMoreData }

class BrowseHistoryCreator {
  static Action loadDataAction() {
    return const Action(BrowseHistoryAction.loadData);
  }

  static Action loadMoreDataAction() {
    return const Action(BrowseHistoryAction.loadMoreData);
  }

  static Action onRefreshDataAction(PagingData<GitIssue> data) {
    return Action(BrowseHistoryAction.onRefreshData, payload: data);
  }

  static Action onLoadMoreDataAction(PagingData<GitIssue> data) {
    return Action(BrowseHistoryAction.onLoadMoreData, payload: data);
  }
}
