import 'package:common_utils/common_utils.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/constant/ColorConstant.dart';
import 'package:gitbbs/network/github/model/github_message.dart';
import 'package:gitbbs/ui/messagecenter/messagelist/component/action.dart';

Widget buildView(
  GithubMessage gitMessage,
  Dispatch dispatch,
  ViewService viewService,
) {
  return InkWell(
      onTap: () {
        dispatch(MessageItemActionCreator.onGetDetailAction());
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              gitMessage.title,
              maxLines: 2,
              style: TextStyle(
                  color: text_title_color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            ),
            Text(
              DateUtil.getDateStrByMs(gitMessage.date),
              style: TextStyle(color: text_summary_color),
            )
          ],
        ),
      ));
}
