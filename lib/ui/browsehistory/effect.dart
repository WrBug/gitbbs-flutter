import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/db/gitissue_data_base.dart';
import 'package:gitbbs/ui/browsehistory/action.dart';
import 'package:gitbbs/ui/browsehistory/state.dart';

Effect<BrowseHistoryPageState> buildEffect() {
  return combineEffects(<Object, Effect<BrowseHistoryPageState>>{
    Lifecycle.initState: _init,
    BrowseHistoryAction.loadData: _loadData,
    BrowseHistoryAction.loadMoreData: _loadMoreData
  });
}

void _init(Action action, Context<BrowseHistoryPageState> ctx) {
  _loadData(action, ctx);
}

void _loadData(Action action, Context<BrowseHistoryPageState> ctx) async {
  var data = await GitIssueDataBase.createInstance().getBrowseHistories();
  ctx.dispatch(BrowseHistoryCreator.onRefreshDataAction(data));
}

void _loadMoreData(Action action, Context<BrowseHistoryPageState> ctx) async {
  GitIssue last;
  if (ctx.state.list?.isNotEmpty == true) {
    last = ctx.state.list.last;
  }
  var data = await GitIssueDataBase.createInstance()
      .getBrowseHistories(beforeIssue: last);
  ctx.dispatch(BrowseHistoryCreator.onLoadMoreDataAction(data));
}
