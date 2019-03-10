import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/network/github/model/GithubComment.dart';

class CommentComponent extends Component<GithubComment> {
  CommentComponent() : super(view: _buildView);
}

Widget _buildView(
  GithubComment comment,
  Dispatch dispatch,
  ViewService viewService,
) {
  return Text(comment.body);
}
