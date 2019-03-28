import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/constant/ColorConstant.dart';
import 'package:gitbbs/ui/userinfo/action.dart';
import 'package:gitbbs/ui/userinfo/user_info_state.dart';
import 'package:gitbbs/ui/widget/avatar_img.dart';

Widget buildView(
    UserInfoState state, Dispatch dispatch, ViewService viewService) {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        _headerBuild(state, dispatch, viewService),
        Container(
          height: 3000,
        )
      ],
    ),
  );
}

_headerBuild(UserInfoState state, Dispatch dispatch, ViewService viewService) {
  return Container(
      color: app_primary,
      height: 130,
      child: state.authFailed || state.gitUser == null
          ? _noUserHeaderBuild(state, dispatch, viewService)
          : _normalHeaderBuild(state, dispatch, viewService));
}

_normalHeaderBuild(
    UserInfoState state, Dispatch dispatch, ViewService viewService) {
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(6),
      ),
      Center(child: AvatarImg(state.gitUser.getAvatarUrl())),
      Padding(
        padding: EdgeInsets.all(8),
      ),
      Center(
          child: Text(
        state.gitUser.bio == null ? "暂无签名" : state.gitUser.bio,
        style: TextStyle(color: Colors.white, fontSize: 14),
      ))
    ],
  );
}

_noUserHeaderBuild(
    UserInfoState state, Dispatch dispatch, ViewService viewService) {
  return Center(
      child: GestureDetector(
    onTap: () {
      dispatch(UserInfoActionCreator.goLoginAction());
    },
    child: Text(
      '点击登录>>',
      style: TextStyle(color: Colors.white, fontSize: 24),
    ),
  ));
}
