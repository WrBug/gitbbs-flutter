import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/ui/editcomment/action.dart';
import 'package:gitbbs/ui/editcomment/state.dart';

Reducer<EditCommentState> buildReducer() {
  return asReducer<EditCommentState>(<Object, Reducer<EditCommentState>>{
    EditCommentAction.pageTypeChanged: _pageTypeChanged,
  });
}

EditCommentState _pageTypeChanged(EditCommentState state, Action action) {
  final EditCommentState newState = state.clone();
  return newState;
}