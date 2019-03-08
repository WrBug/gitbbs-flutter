import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';

class IssueDetailState implements Cloneable<IssueDetailState> {
  int number;
  String title;
  GitIssue issue;

  @override
  IssueDetailState clone() {
    return IssueDetailState()
      ..number = number
      ..title = title
      ..issue = issue;
  }
}

IssueDetailState initState(GitIssue issue) {
  final IssueDetailState state = IssueDetailState();
  state.number = issue.getNumber();
  state.title = issue.getTitle();
  return state;
}
