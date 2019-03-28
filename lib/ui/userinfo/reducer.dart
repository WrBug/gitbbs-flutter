import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/event/UserUpdatedEvent.dart';
import 'package:gitbbs/ui/userinfo/action.dart';
import 'package:gitbbs/ui/userinfo/user_info_state.dart';

Reducer<UserInfoState> buildReducer() {
  return asReducer(<Object, Reducer<UserInfoState>>{
    UserInfoAction.onUserStatusChanged: _onUserStatusChanged
  });
}

UserInfoState _onUserStatusChanged(UserInfoState state, Action action) {
  UserUpdatedEvent event = action.payload;
  UserInfoState newState = state.clone();
  newState.gitUser = event.user;
  newState.authFailed = event.authFailed;
  return newState;
}
