import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/network/github/model/GithubComment.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/action.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/state.dart';

Reducer<CommentListState> buildReducer() {
  return asReducer<CommentListState>(
      <Object, Reducer<CommentListState>>{CommentListAction.update: _update});
}

CommentListState _update(CommentListState state, Action action) {
  List<GithubComment> list = action.payload;
  CommentListState newState = state.clone();
  newState.list = list;
  return newState;
}
