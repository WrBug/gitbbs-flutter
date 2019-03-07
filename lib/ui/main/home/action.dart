import 'package:fish_redux/fish_redux.dart';

enum PageAction { loadData, loadMoreData }

class PageActionCreator {
  static Action onRefreshDataAction() {
    return const Action(PageAction.loadData);
  }

  static Action onLoadMoreDataAction() {
    return const Action(PageAction.loadMoreData);
  }
}
