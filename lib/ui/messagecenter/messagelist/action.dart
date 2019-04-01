import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/git_content_file.dart';
import 'package:gitbbs/network/github/model/github_message.dart';

enum MessageListAction { refreshData, onRefreshData }

class MessageListActionCreator {
  static Action onRefreshDataAction(List<GithubMessage> data) {
    return Action(MessageListAction.onRefreshData, payload: data);
  }

  static Action refreshDataAction() {
    return const Action(MessageListAction.refreshData);
  }
}
