import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/network/IssueState.dart';
import 'package:gitbbs/network/github/GithubHttpRequest.dart';
import 'package:gitbbs/ui/main/home/action.dart';
import 'package:gitbbs/ui/main/home/inner_action.dart';
import 'package:gitbbs/ui/main/home/page_state.dart';
import 'action.dart' as list_action;

Effect<PageState> buildEffect() {
  return combineEffects(<Object, Effect<PageState>>{
    Lifecycle.initState: _init,
    PageAction.loadData: _onLoadData,
    PageAction.loadMoreData: _onLoadMoreData,
  });
}

void _init(Action action, Context<PageState> ctx) {
  final List<GitIssue> initToDos = [];
//  ctx.dispatch(PageActionCreator.loadDataAction(initToDos));
}

void _onLoadData(Action action, Context<PageState> ctx) {
  GitHttpRequest request = GithubHttpRequest.getInstance();
  request.getIssues(state: IssueState.ALL, after: '').then((data) {
    ctx.dispatch(PageInnerActionCreator.refreshDataAction(data));
  });
}

void _onLoadMoreData(Action action, Context<PageState> ctx) {
  String cursor = '';
  if (ctx.state.list.isNotEmpty == true) {
    cursor = ctx.state.list.last.getCursor();
  }
  GitHttpRequest request = GithubHttpRequest.getInstance();
  request.getIssues(state: IssueState.ALL, after: cursor).then((data) {
    ctx.dispatch(PageInnerActionCreator.onLoadMoreDataAction(data));
  });
}
