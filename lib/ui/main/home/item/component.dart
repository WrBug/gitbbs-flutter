import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/ui/main/home/item/effect.dart';
import 'package:gitbbs/ui/main/home/item/reducer.dart';
import 'view.dart';

class IssueComponent extends Component<GitIssue> {
  IssueComponent()
      : super(view: buildView, effect: buildEffect(), reducer: buildReducer());
}
