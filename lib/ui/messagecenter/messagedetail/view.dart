import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gitbbs/ui/messagecenter/messagedetail/state.dart';
import 'package:gitbbs/ui/widget/loading_view.dart';

Widget buildView(
    MessageDetailState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    key: state.scaffoldKey,
    appBar: AppBar(
      title: Text(state.githubMessage.title),
    ),
    body: _mainBodyBuild(state, dispatch, viewService),
  );
}

_mainBodyBuild(
    MessageDetailState state, Dispatch dispatch, ViewService viewService) {
  if (state.body == null) {
    return Center(child: LoadingView());
  }
  return Markdown(data: state.body);
}
