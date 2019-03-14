import 'package:common_utils/common_utils.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gitbbs/constant/ColorConstant.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/ui/favoritelist/adapter/action.dart';
import 'package:gitbbs/ui/favoritelist/adapter/effect.dart';
import 'package:gitbbs/ui/widget/avatar_img.dart';

class FavoriteComponent extends Component<GitIssue> {
  FavoriteComponent() : super(view: _buildView, effect: buildEffect());
}

Widget _buildView(GitIssue gitIssue, dispatch, ViewService viewService) {
  return InkWell(
      onTap: () {
        dispatch(FavoriteItemActionCreator.getDetailAction());
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              gitIssue.getTitle(),
              maxLines: 2,
              style: TextStyle(
                  color: text_title_color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            _contentPreviewBuild(gitIssue),
            _bottomInfoBuild(gitIssue)
          ],
        ),
      ));
}

_contentPreviewBuild(GitIssue gitIssue) {
  return (gitIssue.bodyText ?? '') == ''
      ? Container(
          height: 0,
        )
      : Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Text(
            gitIssue.bodyText ?? '',
            maxLines: 3,
            style: TextStyle(color: text_summary_color, fontSize: 14),
          ),
        );
}

_bottomInfoBuild(GitIssue gitIssue) {
  return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          AvatarImg(
            gitIssue.getAuthor().getAvatarUrl(),
            radius: 8,
          ),
          Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
          Text(
            gitIssue.getAuthor().getName(),
            style: TextStyle(fontSize: 12),
          ),
          Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
          Text(
            '${gitIssue.comments} 评论',
            style: TextStyle(fontSize: 12),
          ),
          Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
          Text(
            TimelineUtil.formatByDateTime(
                DateTime.parse(gitIssue.getCreateTime()),
                dayFormat: DayFormat.Full),
            style: TextStyle(fontSize: 12),
          )
        ],
      ));
}
