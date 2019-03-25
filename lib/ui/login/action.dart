import 'package:fish_redux/fish_redux.dart';

enum LoginAction { login, onLoadingChanged }

class LoginActionCreator {
  static Action loginAction() => const Action(LoginAction.login);

  static Action onLoadingChangedAction(bool loading) =>
      Action(LoginAction.onLoadingChanged, payload: loading);
}
