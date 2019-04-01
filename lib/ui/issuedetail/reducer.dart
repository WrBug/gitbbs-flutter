import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/db/gitissue_data_base.dart';
import 'package:gitbbs/model/event/comments_count_changed_event.dart';
import 'package:gitbbs/ui/issuedetail/action.dart';
import 'package:gitbbs/ui/issuedetail/bean/issue_cache.dart';
import 'package:gitbbs/ui/issuedetail/state.dart';

Reducer<IssueDetailState> buildReducer() {
  return asReducer<IssueDetailState>(<Object, Reducer<IssueDetailState>>{
    IssueDetailAction.update: _update,
    IssueDetailAction.updateCache: _updateCache,
    IssueDetailAction.commentsVisibleChanged: _commentsVisibleChanged,
    IssueDetailAction.onCommentsCountChanged: _onCommentsCountChanged,
    IssueDetailAction.onFavoriteStatusChanged: _onFavoriteStatusChanged
  });
}

IssueDetailState _commentsVisibleChanged(
    IssueDetailState state, Action action) {
  final IssueDetailState newState = state.clone();
  return newState;
}

IssueDetailState _onFavoriteStatusChanged(
    IssueDetailState state, Action action) {
  bool status = action.payload;
  final IssueDetailState newState = state.clone();
  newState.favorite = status;
  return newState;
}

IssueDetailState _update(IssueDetailState state, Action action) {
  GitIssue issue = action.payload ?? GitIssue;
  final IssueDetailState newState = state.clone();
  newState.issue = issue;
  newState.body = issue.body ?? '';
  return newState;
}

IssueDetailState _updateCache(IssueDetailState state, Action action) {
  IssueCache map = action.payload;
  if (state.body?.isNotEmpty == true) {
    return state;
  }
  final IssueDetailState newState = state.clone();
  newState.body = map.body;
  newState.favorite = map.favorite;
  return newState;
}

IssueDetailState _onCommentsCountChanged(
    IssueDetailState state, Action action) {
  CommentCountChangedEvent event = action.payload;
  if (state.getIssue().getNumber() != event.number) {
    return state;
  }
  final IssueDetailState newState = state.clone();
  if (event.isAdd) {
    newState.getIssue().comments++;
  } else {
    newState.getIssue().comments--;
  }
  GitIssueDataBase.createInstance().save(newState.issue);
  return newState;
}
