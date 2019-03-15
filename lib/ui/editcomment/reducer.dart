import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/ui/editcomment/action.dart';
import 'package:gitbbs/ui/editcomment/state.dart';

Reducer<EditCommentState> buildReducer() {
  return asReducer<EditCommentState>(<Object, Reducer<EditCommentState>>{
    EditCommentAction.pageTypeChanged: _pageTypeChanged,
    EditCommentAction.onUpdateInitText: _onUpdateInitText,
  });
}

EditCommentState _pageTypeChanged(EditCommentState state, Action action) {
  final EditCommentState newState = state.clone();
  return newState;
}

EditCommentState _onUpdateInitText(EditCommentState state, Action action) {
  final EditCommentState newState = state.clone();
  newState.mdKey.currentState.setText(action.payload);
  return newState;
}
