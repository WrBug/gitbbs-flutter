import 'package:common_utils/common_utils.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gitbbs/constant/ColorConstant.dart';
import 'package:gitbbs/model/git_comment.dart';
import 'package:gitbbs/ui/widget/avatar_img.dart';

class CommentComponent extends Component<GitComment> {
  CommentComponent() : super(view: _buildView);
}

Widget _buildView(
  GitComment comment,
  Dispatch dispatch,
  ViewService viewService,
) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _headerBuild(comment, dispatch),
        Padding(
          padding: EdgeInsets.fromLTRB(28, 6, 10, 0),
          child: MarkdownBody(
            data: comment.getBody(),
          ),
        ),
      ],
    ),
  );
}

Widget _headerBuild(GitComment comment, Dispatch dispatch) {
  return Row(children: <Widget>[
    AvatarImg(
      comment.getAuthor().getAvatarUrl(),
      radius: 14,
    ),
    Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            comment.getAuthor().getName(),
            style: TextStyle(fontSize: 14, color: text_content_color),
          ),
          Text(
            DateUtil.getDateStrByDateTime(
                DateTime.parse(comment.getCreatedAt()).toLocal()),
            style: TextStyle(fontSize: 12, color: text_summary_color),
          )
        ],
      ),
    ),
    Padding(padding: EdgeInsets.fromLTRB(8, 0, 0, 0)),
    _iconButtonBuild(comment, dispatch),
    Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
    Text(
      'F${comment.getFloor()}',
      style: TextStyle(color: text_title_color, fontSize: 14),
    )
  ]);
}

_iconButtonBuild(GitComment comment, Dispatch dispatch) {
  List<Widget> list = List();
  list.add(IconButton(
    icon: Icon(Icons.comment),
    iconSize: 18,
    color: icon_summary_color,
    onPressed: () {},
  ));
  if (comment.viewerCanUpdate) {
    list.add(IconButton(
      icon: Icon(Icons.edit),
      iconSize: 18,
      color: icon_summary_color,
      onPressed: () {},
    ));
  }
  if (comment.viewerCanDelete) {
    list.add(IconButton(
      icon: Icon(Icons.delete),
      iconSize: 18,
      color: icon_summary_color,
      onPressed: () {},
    ));
  }
  return Row(
    children: list,
  );
}
