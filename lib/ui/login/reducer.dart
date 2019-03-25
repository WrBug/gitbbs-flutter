import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/ui/login/state.dart';
import 'action.dart';

Reducer<LoginPageState> buildReducer() {
  return asReducer<LoginPageState>(<Object, Reducer<LoginPageState>>{
    LoginAction.onLoadingChanged: _onLoadingChanged
  });
}

LoginPageState _onLoadingChanged(LoginPageState state, Action action) {
  final LoginPageState newState = state.clone();
  newState.loading = action.payload;
  return newState;
}
