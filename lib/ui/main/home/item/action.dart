import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';

enum IssueItemAction { onGetDetail }

class IssueItemActionCreator {
  static Action onGetDetailAction(GitIssue issue) {
    return Action(IssueItemAction.onGetDetail, payload: issue);
  }
}
