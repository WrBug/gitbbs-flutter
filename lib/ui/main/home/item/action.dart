import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/event/comments_count_changed_event.dart';

enum IssueItemAction { onGetDetail}

class IssueItemActionCreator {
  static Action onGetDetailAction(GitIssue issue) {
    return Action(IssueItemAction.onGetDetail, payload: issue);
  }

}
