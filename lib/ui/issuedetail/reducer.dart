import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/ui/issuedetail/action.dart';
import 'package:gitbbs/ui/issuedetail/state.dart';

Reducer<IssueDetailState> buildReducer() {
  return asReducer<IssueDetailState>(<Object, Reducer<IssueDetailState>>{
    IssueDetailAction.update: _update,
    IssueDetailAction.commentsVisibleChanged: _commentsVisibleChanged
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
