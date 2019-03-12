import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/entry/comment_list_data.dart';
import 'package:gitbbs/network/github/model/GithubComment.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/adapter/comment_list_adapter.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/effect.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/reducer.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/state.dart';
import 'view.dart';

class CommentListPage extends Page<CommentListState, CommentListData> {
  CommentListPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<CommentListState>(
                adapter: CommentListAdapter(),
                slots: <String, Dependent<CommentListState>>{}));
}
