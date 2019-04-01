import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/ui/messagecenter/messagelist/adapter.dart';
import 'package:gitbbs/ui/messagecenter/messagelist/reducer.dart';
import 'package:gitbbs/ui/messagecenter/messagelist/effect.dart';
import 'package:gitbbs/ui/messagecenter/messagelist/state.dart';
import 'view.dart';

class MessageListPage extends Page<MessageListPageState, dynamic> {
  MessageListPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies:
              Dependencies<MessageListPageState>(adapter: MessageListAdapter()),
        );

  static Future start(BuildContext context) async {
    return Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MessageListPage().buildPage(null)));
  }
}
