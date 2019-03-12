import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/db/gitissue_data_base.dart';
import 'package:gitbbs/model/event/comments_count_changed_event.dart';
import 'package:gitbbs/ui/issuedetail/action.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/action.dart';
import 'package:gitbbs/ui/issuedetail/state.dart';

Reducer<IssueDetailState> buildReducer() {
  return asReducer<IssueDetailState>(<Object, Reducer<IssueDetailState>>{
    IssueDetailAction.update: _update,
    IssueDetailAction.commentsVisibleChanged: _commentsVisibleChanged,
    IssueDetailAction.onCommentsCountChanged: _onCommentsCountChanged
  });
}

IssueDetailState _commentsVisibleChanged(
    IssueDetailState state, Action action) {
  final IssueDetailState newState = state.clone();
  return newState;
}

IssueDetailState _update(IssueDetailState state, Action action) {
  var issue = action.payload ?? GitIssue;
  final IssueDetailState newState = state.clone();
  newState.issue = issue;
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
  GitIssueDataBase.createInstance().save(gitIssue: newState.issue);
  return newState;
}
