import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/network/github/model/github_message.dart';

class MessageDetailState implements Cloneable<MessageDetailState> {
  GithubMessage githubMessage;
  String body;
  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  MessageDetailState clone() {
    return MessageDetailState()
      ..scaffoldKey = scaffoldKey
      ..body = body
      ..githubMessage = githubMessage;
  }
}

MessageDetailState initState(GithubMessage githubMessage) {
  final MessageDetailState state = MessageDetailState();
  state.githubMessage = githubMessage;
  state.scaffoldKey = GlobalKey<ScaffoldState>();
  return state;
}
