import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/PagingData.dart';
import 'package:gitbbs/model/git_comment.dart';
import 'package:gitbbs/network/github/model/GithubComment.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/action.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/state.dart';
import 'package:gitbbs/util/issue_cache_manager.dart';

Reducer<CommentListState> buildReducer() {
  return asReducer<CommentListState>(<Object, Reducer<CommentListState>>{
    CommentListAction.onRefreshed: _onRefreshed,
    CommentListAction.onMoreLoaded: _onMoreLoaded,
    CommentListAction.onCommentDeleted: _onCommentDeleted
  });
}

CommentListState _onRefreshed(CommentListState state, Action action) {
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

CommentListState _onMoreLoaded(CommentListState state, Action action) {
  PagingData<GitComment> data = action.payload;
  CommentListState newState = state.clone();
  newState.list.addAll(data.data);
  newState.list.sort((a, b) => b.getCreatedAt().compareTo(a.getCreatedAt()));
  newState.list.forEach((comment) {
    comment.setFloor(newState.list.length - newState.list.indexOf(comment));
  });
  newState.hasNext = data.hasNext;
  return newState;
}

CommentListState _onCommentDeleted(CommentListState state, Action action) {
  CommentListState newState = state.clone();
  newState.list.remove(action.payload);
  IssueCacheManager.removeCommentItem(state.issue.getNumber(), action.payload);
  return newState;
}
