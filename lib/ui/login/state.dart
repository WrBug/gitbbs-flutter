import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class LoginPageState implements Cloneable<LoginPageState> {
  bool loading;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;
  TextEditingController usernameController;
  TextEditingController passwordController;
  bool starDataRepo;
  bool starAppRepo;

  @override
  LoginPageState clone() {
    return LoginPageState()
      ..loading = loading
      ..formKey = formKey
      ..scaffoldKey = scaffoldKey
      ..starDataRepo = starDataRepo
      ..starAppRepo = starAppRepo
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
    ..starDataRepo = true
    ..starAppRepo = true
    ..formKey = new GlobalKey<FormState>();
}
