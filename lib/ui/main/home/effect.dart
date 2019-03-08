import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/PagingData.dart';
import 'package:gitbbs/model/db/gitissue_data_base.dart';
import 'package:gitbbs/model/entry/midddle_issues_data.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/network/IssueState.dart';
import 'package:gitbbs/network/github/GithubHttpRequest.dart';
import 'package:gitbbs/ui/main/home/action.dart';
import 'package:gitbbs/ui/main/home/inner_action.dart';
import 'package:gitbbs/ui/main/home/page_state.dart';

Effect<PageState> buildEffect() {
  return combineEffects(<Object, Effect<PageState>>{
    Lifecycle.initState: _init,
    PageAction.loadData: _onLoadData,
    PageAction.loadMiddleData: _onLoadMiddleData,
    PageAction.loadMoreData: _onLoadMoreData,
  });
}

void _init(Action action, Context<PageState> ctx) {
  var db = GitIssueDataBase.createInstance();
  db.getList(size: 10).then((initToDos) {
    ctx.dispatch(PageInnerActionCreator.loadInitData(initToDos.data));
  });
}

void _onLoadMiddleData(Action action, Context<PageState> ctx) {
  GitHttpRequest request = GithubHttpRequest.getInstance();
  MiddleIssuesData issuesData = action.payload;
  issuesData.refreshing = true;
  ctx.dispatch(PageInnerActionCreator.showMiddleProgress(issuesData));
  request
      .getMoreIssues(
          state: IssueState.ALL,
          before: issuesData.beforeIssue.getCursor(),
          after: issuesData.afterIssue.getCursor())
      .then((data) {
    ctx.dispatch(
        PageInnerActionCreator.refreshMiddleDataAction(issuesData, data));
  });
}

void _onLoadData(Action action, Context<PageState> ctx) {
  GitHttpRequest request = GithubHttpRequest.getInstance();
  String cursor = '';
  if (ctx.state.list.isNotEmpty == true) {
    cursor = ctx.state.list.first.getCursor();
  }
  request.getMoreIssues(state: IssueState.ALL, before: cursor).then((data) {
    ctx.dispatch(PageInnerActionCreator.refreshDataAction(data));
  });
}

void _onLoadMoreData(Action action, Context<PageState> ctx) async {
  String cursor = '';
  int number;
  if (ctx.state.list.isNotEmpty == true) {
    cursor = ctx.state.list.last.getCursor();
    number = ctx.state.list.last.getNumber();
  }
  PagingData<GitIssue> data = await GitIssueDataBase.createInstance()
      .getList(beforeNumber: number, size: 30);
  if (data.data.isNotEmpty == true) {
    ctx.dispatch(PageInnerActionCreator.onLoadMoreDataAction(
        PagingData(true, data.data)));
    return;
  }
  GitHttpRequest request = GithubHttpRequest.getInstance();
  request.getMoreIssues(state: IssueState.ALL, after: cursor).then((data) {
    ctx.dispatch(PageInnerActionCreator.onLoadMoreDataAction(data));
  });
}
