import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';

enum IssueDetailAction { update }

class IssueDetailActionCreator {
  static Action update(GitIssue issue) {
    return Action(IssueDetailAction.update, payload: issue);
  }
}
