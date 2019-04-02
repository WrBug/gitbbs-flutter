import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/ui/messagecenter/messagedetail/action.dart';
import 'package:gitbbs/ui/messagecenter/messagedetail/state.dart';
import 'package:flutter/material.dart';

Effect<MessageDetailState> buildEffect() {
  return combineEffects(<Object, Effect<MessageDetailState>>{
    Lifecycle.initState: _init,
  });
}

void _init(Action action, Context<MessageDetailState> ctx) async {
  if (ctx.state.githubMessage == null) {
    Navigator.pop(ctx.context);
    return;
  }
  var gitHttpRequest = GitHttpRequest.getInstance();
  var body =
      await gitHttpRequest.getOfficialMessage(ctx.state.githubMessage.path);
  ctx.dispatch(MessageDetailActionCreator.onLoadBodyAction(body));
}
