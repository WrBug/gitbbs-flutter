import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/PagingData.dart';
import 'package:gitbbs/model/git_comment.dart';
import 'package:gitbbs/network/github/model/GithubComment.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/action.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/state.dart';

Reducer<CommentListState> buildReducer() {
  return asReducer<CommentListState>(
      <Object, Reducer<CommentListState>>{CommentListAction.update: _update});
}

CommentListState _update(CommentListState state, Action action) {
  PagingData<GitComment> data = action.payload;
  CommentListState newState = state.clone();
  newState.list = data.data;
  newState.list.sort((a, b) => b.getCreatedAt().compareTo(a.getCreatedAt()));
  newState.list.forEach((comment) {
    comment.setFloor(newState.list.length - newState.list.indexOf(comment));
  });
  newState.hasNext = data.hasNext;
  return newState;
}
