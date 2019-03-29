import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/ui/issuedetail/effect.dart';
import 'package:gitbbs/ui/issuedetail/reducer.dart';
import 'package:gitbbs/ui/issuedetail/state.dart';
import 'view.dart';

class IssueDetailPage extends Page<IssueDetailState, GitIssue> {
  IssueDetailPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView);
}
