import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/event/UserUpdatedEvent.dart';

enum UserInfoAction { goLogin, logout, onUserStatusChanged }

class UserInfoActionCreator {
  static Action goLoginAction() => const Action(UserInfoAction.goLogin);

  static Action onUserStatusChangedAction(UserUpdatedEvent event) =>
      Action(UserInfoAction.onUserStatusChanged, payload: event);
}
