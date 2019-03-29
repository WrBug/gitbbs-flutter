import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:gitbbs/constant/ColorConstant.dart';
import 'package:gitbbs/ui/main/userinfo/action.dart';
import 'package:gitbbs/ui/main/userinfo/user_info_state.dart';
import 'package:gitbbs/ui/widget/avatar_img.dart';

Widget buildView(
    UserInfoState state, Dispatch dispatch, ViewService viewService) {
  return EasyRefresh(
      key: state.easyRefreshKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _headerBuild(state, dispatch, viewService),
            Container(height: 20, color: Color(0x0f000000)),
            _itemBuild('消息中心', Icons.notifications_active, dispatch,
                UserInfoActionCreator.goMessageCenterAction()),
            _itemBuild('我的文章', Icons.book, dispatch,
                UserInfoActionCreator.goMyIssuesPageAction(),
                summary:
                    '${state.gitUser?.issuesCount == null ? '' : state.gitUser?.issuesCount}'),
            _itemBuild('浏览历史', Icons.history, dispatch,
                UserInfoActionCreator.goHistoryAction(),
                summary: state.todayHistoryCount == null
                    ? ''
                    : '今日浏览${state.todayHistoryCount}'),
            _itemBuild('项目Github主页', Icons.web, dispatch,
                UserInfoActionCreator.goGithubPageAction()),
            _itemBuild('退出登录', Icons.exposure_neg_1, dispatch,
                UserInfoActionCreator.logoutAction()),
          ],
        ),
      ),
      refreshHeader: MaterialHeader(
        key: state.headerKey,
      ),
      autoControl: true,
      onRefresh: () {
        dispatch(UserInfoActionCreator.refreshAction());
      });
}

_itemBuild(String text, IconData icon, Dispatch dispatch, Action action,
    {String summary = ''}) {
  return Column(
    children: <Widget>[
      InkWell(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: icon_content_color,
              ),
              Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
              Expanded(
                  child: Text(
                text,
                style: TextStyle(color: text_content_color, fontSize: 16),
              )),
              Text(summary,
                  style: TextStyle(color: text_summary_color, fontSize: 14))
            ],
          ),
        ),
        onTap: () => dispatch(action),
      ),
      Divider(height: 1),
    ],
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
