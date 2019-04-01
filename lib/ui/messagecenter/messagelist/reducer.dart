import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/network/github/model/github_message.dart';
import 'package:gitbbs/ui/messagecenter/messagelist/action.dart';
import 'package:gitbbs/ui/messagecenter/messagelist/state.dart';

Reducer<MessageListPageState> buildReducer() {
  return asReducer(<Object, Reducer<MessageListPageState>>{
    MessageListAction.onRefreshData: _refreshData,
  });
}

MessageListPageState _refreshData(MessageListPageState state, Action action) {
  final MessageListPageState newState = state.clone();
  final List<GithubMessage> data = action.payload;
  newState.list = data;
  return newState;
}
