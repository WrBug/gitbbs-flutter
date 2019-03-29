import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/PagingData.dart';

enum UserIssuesAction { loadData, onRefreshData, loadMoreData, onLoadMoreData }

class UserIssuesActionCreator {
  static Action loadDataAction() {
    return const Action(UserIssuesAction.loadData);
  }

  static Action loadMoreDataAction() {
    return const Action(UserIssuesAction.loadMoreData);
  }

  static Action onRefreshDataAction(PagingData<GitIssue> data) {
    return Action(UserIssuesAction.onRefreshData, payload: data);
  }

  static Action onLoadMoreDataAction(PagingData<GitIssue> data) {
    return Action(UserIssuesAction.onLoadMoreData, payload: data);
  }
}
