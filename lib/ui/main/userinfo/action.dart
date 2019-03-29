import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/event/UserUpdatedEvent.dart';
import 'package:gitbbs/ui/main/userinfo/bean/user_update_info.dart';

enum UserInfoAction {
  goLogin,
  refresh,
  logout,
  goMessageCenter,
  goMyIssuesPage,
  goGithubPage,
  goHistory,
  onUserStatusChanged,
  onRefreshed
}

class UserInfoActionCreator {
  static Action goLoginAction() => const Action(UserInfoAction.goLogin);
  static Action refreshAction() => const Action(UserInfoAction.refresh);

  static Action logoutAction() => const Action(UserInfoAction.logout);

  static Action goMessageCenterAction() =>
      const Action(UserInfoAction.goMessageCenter);

  static Action goMyIssuesPageAction() =>
      const Action(UserInfoAction.goMyIssuesPage);

  static Action goGithubPageAction() =>
      const Action(UserInfoAction.goGithubPage);

  static Action goHistoryAction() => const Action(UserInfoAction.goHistory);

  static Action onUserStatusChangedAction(UserUpdatedEvent event) =>
      Action(UserInfoAction.onUserStatusChanged, payload: event);

  static Action onRefreshedAction(UserUpdateInfo info) =>
      Action(UserInfoAction.onRefreshed, payload: info);
}
