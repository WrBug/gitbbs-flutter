import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/PagingData.dart';
import 'package:gitbbs/model/db/gitissue_data_base.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/network/IssueState.dart';
import 'package:gitbbs/ui/userissues/action.dart';
import 'package:gitbbs/ui/userissues/state.dart';

Effect<UserIssuesPageState> buildEffect() {
  return combineEffects(<Object, Effect<UserIssuesPageState>>{
    Lifecycle.initState: _init,
    UserIssuesAction.loadData: _loadData,
    UserIssuesAction.loadMoreData: _loadMoreData
  });
}

void _init(Action action, Context<UserIssuesPageState> ctx) {
  _loadData(action, ctx);
}

void _loadData(Action action, Context<UserIssuesPageState> ctx) async {
  GitHttpRequest request = GitHttpRequest.getInstance();
  String cursor = '';
  if (ctx.state.list?.isNotEmpty == true) {
    cursor = ctx.state.list.first.getCursor();
  }
  var data = await request.getMoreIssues(
      state: IssueState.ALL, before: cursor, creator: ctx.state.username);
  ctx.dispatch(UserIssuesActionCreator.onRefreshDataAction(data));
}

void _loadMoreData(Action action, Context<UserIssuesPageState> ctx) async {
  String cursor = '';
  int number;
  if (ctx.state.list?.isNotEmpty == true) {
    cursor = ctx.state.list.last.getCursor();
    number = ctx.state.list.last.getNumber();
  }
  PagingData<GitIssue> dbData = await GitIssueDataBase.createInstance()
      .getList(beforeNumber: number, size: 30);
  if (dbData.data?.isNotEmpty == true) {
    ctx.dispatch(UserIssuesActionCreator.onLoadMoreDataAction(
        PagingData(true, dbData.data)));
    return;
  }
  GitHttpRequest request = GitHttpRequest.getInstance();
  var data = await request.getMoreIssues(
      state: IssueState.ALL, after: cursor, creator: ctx.state.username);
  ctx.dispatch(UserIssuesActionCreator.onLoadMoreDataAction(data));
}
