import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/PagingData.dart';
import 'package:gitbbs/model/db/gitissue_data_base.dart';
import 'package:gitbbs/model/entry/midddle_issues_data.dart';
import 'package:gitbbs/model/event/comments_count_changed_event.dart';
import 'package:gitbbs/model/event/refresh_list_event.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/network/IssueState.dart';
import 'package:gitbbs/network/github/GithubHttpRequest.dart';
import 'package:gitbbs/ui/main/home/action.dart';
import 'package:gitbbs/ui/main/home/inner_action.dart';
import 'package:gitbbs/ui/main/home/page_state.dart';
import 'package:gitbbs/util/event_bus_helper.dart';

Effect<PageState> buildEffect() {
  return combineEffects(<Object, Effect<PageState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    PageAction.loadData: _onLoadData,
    PageAction.loadMiddleData: _onLoadMiddleData,
    PageAction.loadMoreData: _onLoadMoreData,
  });
}

void _dispose(Action action, Context<PageState> ctx) {
  print('_dispose');
}

void _init(Action action, Context<PageState> ctx) {
  print('_init');
  EventBusHelper.on<CommentCountChangedEvent>().listen((event) {
    ctx.dispatch(PageInnerActionCreator.onCommentsCountChangedAction(event));
  });
  EventBusHelper.on<RefreshIssueEvent>().listen((event) {
    _onLoadData(action, ctx);
  });
  EventBusHelper.on<LoadLocalIssueEvent>().listen((event) {
    _loadCache(ctx, ctx.state.list.length);
  });
  _loadCache(ctx, 20);
}

void _loadCache(Context<PageState> ctx, int size) {
  var db = GitIssueDataBase.createInstance();
  db.getList(size: size).then((initToDos) {
    ctx.dispatch(PageInnerActionCreator.loadInitData(initToDos.data));
  });
}

void _onLoadMiddleData(Action action, Context<PageState> ctx) async {
  GitHttpRequest request = GitHttpRequest.getInstance();
  MiddleIssuesData issuesData = action.payload;
  issuesData.refreshing = true;
  ctx.dispatch(PageInnerActionCreator.showMiddleProgress(issuesData));
  var data = await request.getMoreIssues(
      state: IssueState.ALL,
      before: issuesData.beforeIssue.getCursor(),
      after: issuesData.afterIssue.getCursor());
  ctx.dispatch(
      PageInnerActionCreator.refreshMiddleDataAction(issuesData, data));
}

void _onLoadData(Action action, Context<PageState> ctx) async {
  GitHttpRequest request = GitHttpRequest.getInstance();
  String cursor = '';
  if (ctx.state.list?.isNotEmpty == true) {
    cursor = ctx.state.list.first.getCursor();
  }
  var data = await request.getMoreIssues(state: IssueState.ALL, before: cursor);
  ctx.dispatch(PageInnerActionCreator.refreshDataAction(data));
}

void _onLoadMoreData(Action action, Context<PageState> ctx) async {
  String cursor = '';
  int number;
  if (ctx.state.list?.isNotEmpty == true) {
    cursor = ctx.state.list.last.getCursor();
    number = ctx.state.list.last.getNumber();
  }
  PagingData<GitIssue> dbData = await GitIssueDataBase.createInstance()
      .getList(beforeNumber: number, size: 30);
  if (dbData.data?.isNotEmpty == true) {
    ctx.dispatch(PageInnerActionCreator.onLoadMoreDataAction(
        PagingData(true, dbData.data)));
    return;
  }
  GitHttpRequest request = GitHttpRequest.getInstance();
  var data = await request.getMoreIssues(state: IssueState.ALL, after: cursor);
  ctx.dispatch(PageInnerActionCreator.onLoadMoreDataAction(data));
}
