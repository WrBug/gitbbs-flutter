import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/network/github/model/github_message.dart';
import 'package:gitbbs/ui/messagecenter/messagedetail/effect.dart';
import 'package:gitbbs/ui/messagecenter/messagedetail/reducer.dart';
import 'package:gitbbs/ui/messagecenter/messagedetail/state.dart';
import 'package:gitbbs/ui/messagecenter/messagedetail/view.dart';

class MessageDetailPage extends Page<MessageDetailState, GithubMessage> {
  MessageDetailPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView);

  static Future start(BuildContext context, GithubMessage message) async {
    return Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MessageDetailPage().buildPage(message)));
  }
}
