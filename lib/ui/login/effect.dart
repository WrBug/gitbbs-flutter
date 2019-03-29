import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/ui/login/action.dart';
import 'package:gitbbs/ui/login/state.dart';

Effect<LoginPageState> buildEffect() {
  return combineEffects(<Object, Effect<LoginPageState>>{
    Lifecycle.initState: _init,
    LoginAction.login: _login
  });
}

void _init(Action action, Context<LoginPageState> ctx) async {}

void _login(Action action, Context<LoginPageState> ctx) async {
  if (ctx.state.loading) {
    return;
  }
  if (ctx.state.usernameController.text == '') {
    ctx.state.scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text('GITHUB用户名不得为空')));
    return;
  }
  if (ctx.state.passwordController.text == '') {
    ctx.state.scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text('GITHUB密码不得为空')));
    return;
  }
  ctx.state.scaffoldKey.currentState
      .showSnackBar(SnackBar(content: Text('正在验证密码，请稍后')));
  ctx.dispatch(LoginActionCreator.onLoadingChangedAction(true));
  GitHttpRequest request = GitHttpRequest.getInstance();
  bool success = await request.signIn(
      ctx.state.usernameController.text, ctx.state.passwordController.text);
  if (success) {
    ctx.state.scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text('登录成功')));
    Navigator.pop(ctx.context, true);
  } else {
    ctx.state.scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text('登录失败')));
    ctx.dispatch(LoginActionCreator.onLoadingChangedAction(false));
  }
}
