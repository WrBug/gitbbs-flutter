import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/ui/messagecenter/messagelist/action.dart';
import 'package:gitbbs/ui/messagecenter/messagelist/state.dart';

Effect<MessageListPageState> buildEffect() {
  return combineEffects(<Object, Effect<MessageListPageState>>{
    Lifecycle.initState: _init,
    MessageListAction.refreshData: _loadData
  });
}

void _init(Action action, Context<MessageListPageState> ctx) {
  _loadData(action, ctx);
}

void _loadData(Action action, Context<MessageListPageState> ctx) async {
  GitHttpRequest request = GitHttpRequest.getInstance();
  var list = await request.getOfficialMessageList();
  ctx.dispatch(MessageListActionCreator.onRefreshDataAction(list));
}
