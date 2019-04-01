import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';

enum MessageItemAction { onGetDetail }

class MessageItemActionCreator {
  static Action onGetDetailAction() {
    return Action(MessageItemAction.onGetDetail);
  }
}
