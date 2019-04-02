import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/ui/messagecenter/messagedetail/action.dart';
import 'package:gitbbs/ui/messagecenter/messagedetail/state.dart';

Reducer<MessageDetailState> buildReducer() {
  return asReducer<MessageDetailState>(<Object, Reducer<MessageDetailState>>{
    MessageDetailAction.onLoadBody: _onLoadBody
  });
}

MessageDetailState _onLoadBody(MessageDetailState state, Action action) {
  var newState = state.clone();
  newState.body = action.payload ?? '';
  return newState;
}
