import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/constant/ColorConstant.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/ui/issuedetail/action.dart';
import 'package:gitbbs/ui/issuedetail/state.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gitbbs/ui/widget/avatar_img.dart';

Widget buildView(
    IssueDetailState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    key: state.scaffoldKey,
    appBar: AppBar(
      title: Text(state.getIssue().getTitle()),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    floatingActionButton: _floatButtonBuild(state, dispatch, viewService),
    bottomNavigationBar: Builder(
        builder: (context) =>
            _commentsBuild(context, state, dispatch, viewService)),
    body: _mainBodyBuild(state),
  );
}

FloatingActionButton _floatButtonBuild(
    IssueDetailState state, Dispatch dispatch, ViewService viewService) {
  return FloatingActionButton(
    onPressed: () {
      if (state.isCommentsShown()) {
        dispatch(IssueDetailActionCreator.toggleCommentsVisible(null));
        return;
      }
      dispatch(IssueDetailActionCreator.addCommentAction(state.getIssue()));
    },
    child: Icon(state.isCommentsShown() ? Icons.close : Icons.add_comment),
  );
}

_commentsBuild(BuildContext context, IssueDetailState state, Dispatch dispatch,
    ViewService viewService) {
  return BottomAppBar(
    child: tabs(context, state.getIssue(), dispatch, viewService),
    color: app_primary_light,
    shape: CircularNotchedRectangle(),
  );
}

Row tabs(BuildContext context, GitIssue issue, Dispatch dispatch,
    ViewService viewService) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      InkWell(
        onTap: () {
          dispatch(IssueDetailActionCreator.toggleCommentsVisible(context));
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.comment,
                color: Colors.white,
                size: 14,
              ),
              Text(
                issue.getShowComments(),
                style: TextStyle(color: Colors.white, fontSize: 12),
              )
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {},
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 14,
                ),
                Text(
                  '分享',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            )),
      ),
    ],
  );
}

Widget _mainBodyBuild(IssueDetailState state) {
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 40),
      child: Column(
        children: <Widget>[
          _headerBuild(state.getIssue()),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          _bodyBuild(state)
        ],
      ),
    ),
  );
}

Widget _bodyBuild(IssueDetailState state) {
  return MarkdownBody(data: state.getBody());
}

Widget _headerBuild(GitIssue issue) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(issue.getTitle(),
            style: TextStyle(
                fontSize: 24,
                color: text_title_color,
                fontWeight: FontWeight.bold)),
        Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
        Row(children: <Widget>[
          AvatarImg(
            issue.getAuthor().getAvatarUrl(),
            radius: 16,
          ),
          Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                issue.getAuthor().getName(),
                style: TextStyle(fontSize: 16, color: text_content_color),
              ),
              Text(
                DateUtil.getDateStrByDateTime(
                    DateTime.parse(issue.getCreateTime()).toLocal()),
                style: TextStyle(fontSize: 12, color: text_summary_color),
              )
            ],
          )
        ])
      ]);
}
