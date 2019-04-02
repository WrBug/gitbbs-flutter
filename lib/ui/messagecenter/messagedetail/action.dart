import 'package:fish_redux/fish_redux.dart';

enum MessageDetailAction { onLoadBody }

class MessageDetailActionCreator {
  static Action onLoadBodyAction(String body) {
    return Action(MessageDetailAction.onLoadBody, payload: body);
  }
}
