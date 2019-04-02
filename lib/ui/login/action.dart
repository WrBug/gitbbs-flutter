import 'package:fish_redux/fish_redux.dart';

enum LoginAction {
  login,
  onLoadingChanged,
  onStarDataRepoCheckChanged,
  onStarAppRepoCheckChanged
}

class LoginActionCreator {
  static Action loginAction() => const Action(LoginAction.login);

  static Action onLoadingChangedAction(bool loading) =>
      Action(LoginAction.onLoadingChanged, payload: loading);

  static Action onStarDataRepoCheckChangedAction(bool changed) =>
      Action(LoginAction.onStarDataRepoCheckChanged, payload: changed);

  static Action onStarAppRepoCheckChangedAction(bool changed) =>
      Action(LoginAction.onStarAppRepoCheckChanged, payload: changed);
}
