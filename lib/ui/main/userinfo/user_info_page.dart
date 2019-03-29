import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/ui/main/userinfo/user_info_state.dart';
import 'package:gitbbs/ui/main/userinfo/effect.dart';
import 'package:gitbbs/ui/main/userinfo/reducer.dart';
import 'package:gitbbs/ui/main/userinfo/view.dart';

class UserInfoPage extends Page<UserInfoState, GlobalKey<ScaffoldState>> {
  UserInfoPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
        );
}
