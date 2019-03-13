import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/entry/midddle_issues_data.dart';

enum PageAction {
  loadData,
  loadMiddleData,
  loadMoreData
}

class PageActionCreator {
  static Action onRefreshDataAction() {
    return const Action(PageAction.loadData);
  }

  static Action loadMiddleDataAction(MiddleIssuesData issues) {
    return Action(PageAction.loadMiddleData, payload: issues);
  }

  static Action onLoadMoreDataAction() {
    return const Action(PageAction.loadMoreData);
  }


}
