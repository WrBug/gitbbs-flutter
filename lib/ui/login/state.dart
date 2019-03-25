import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class LoginPageState implements Cloneable<LoginPageState> {
  bool loading;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;
  TextEditingController usernameController;
  TextEditingController passwordController;

  @override
  LoginPageState clone() {
    return LoginPageState()
      ..loading = loading
      ..formKey = formKey
      ..scaffoldKey = scaffoldKey
      ..usernameController = usernameController
      ..passwordController = passwordController;
  }
}

LoginPageState initState(dynamic data) {
  return LoginPageState()
    ..loading = false
    ..scaffoldKey = GlobalKey()
    ..usernameController = TextEditingController()
    ..passwordController = TextEditingController()
    ..formKey = new GlobalKey<FormState>();
}
