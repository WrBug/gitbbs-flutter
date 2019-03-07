import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/PagingData.dart';

enum PageInnerAction { refreshData, loadMoreData }

class PageInnerActionCreator {
  static Action refreshDataAction(PagingData<GitIssue> data) {
    return Action(PageInnerAction.refreshData, payload: data);
  }

  static Action onLoadMoreDataAction(PagingData<GitIssue> data) {
    return Action(PageInnerAction.loadMoreData, payload: data);
  }
}
