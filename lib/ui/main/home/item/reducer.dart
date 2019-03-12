import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/event/comments_count_changed_event.dart';

Reducer<GitIssue> buildReducer() {
  return asReducer(<Object, Reducer<GitIssue>>{
//    IssueItemAction.onCommentsCountChanged: _onCommentsCountChanged
  });
}

GitIssue _onCommentsCountChanged(GitIssue issue, Action action) {
  CommentCountChangedEvent event = action.payload;
  if (issue.getNumber() != event.number) {
    return issue;
  }
  final GitIssue newState = issue.clone();
  if (event.isAdd) {
    newState.comments++;
  } else {
    newState.comments--;
  }
  return newState;
}
