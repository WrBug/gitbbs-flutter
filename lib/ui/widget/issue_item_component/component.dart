import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/ui/widget/issue_item_component/effect.dart';
import 'package:gitbbs/ui/widget/issue_item_component/reducer.dart';
import 'package:gitbbs/ui/widget/issue_item_component/view.dart';

class IssueComponent extends Component<GitIssue> {
  IssueComponent()
      : super(view: buildView, effect: buildEffect(), reducer: buildReducer());
}
