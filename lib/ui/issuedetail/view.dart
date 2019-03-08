import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/ui/issuedetail/state.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

Widget buildView(
    IssueDetailState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text(state.title),
    ),
    body: Container(
      child: Markdown(
        data: state.issue == null ? "# ${state.title}" : state.issue.getBody(),
      ),
    ),
  );
}
