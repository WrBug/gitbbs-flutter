import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/ui/login/state.dart';
import 'action.dart';

Reducer<LoginPageState> buildReducer() {
  return asReducer<LoginPageState>(<Object, Reducer<LoginPageState>>{
    LoginAction.onLoadingChanged: _onLoadingChanged,
    LoginAction.onStarDataRepoCheckChanged: _onStarDataRepoCheckChanged,
    LoginAction.onStarAppRepoCheckChanged: _onStarAppRepoCheckChanged
  });
}

LoginPageState _onLoadingChanged(LoginPageState state, Action action) {
  final LoginPageState newState = state.clone();
  newState.loading = action.payload;
  return newState;
}

LoginPageState _onStarDataRepoCheckChanged(
    LoginPageState state, Action action) {
  final LoginPageState newState = state.clone();
  newState.starDataRepo = action.payload;
  return newState;
}

LoginPageState _onStarAppRepoCheckChanged(LoginPageState state, Action action) {
  final LoginPageState newState = state.clone();
  newState.starAppRepo = action.payload;
  return newState;
}
