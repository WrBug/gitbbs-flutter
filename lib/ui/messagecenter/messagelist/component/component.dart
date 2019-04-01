import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/git_content_file.dart';
import 'package:gitbbs/network/github/model/github_message.dart';
import 'package:gitbbs/ui/messagecenter/messagelist/component/effect.dart';
import 'package:gitbbs/ui/messagecenter/messagelist/component/reducer.dart';
import 'package:gitbbs/ui/messagecenter/messagelist/component/view.dart';

class MessageComponent extends Component<GithubMessage> {
  MessageComponent()
      : super(view: buildView, effect: buildEffect(), reducer: buildReducer());
}
