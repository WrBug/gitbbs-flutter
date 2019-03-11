import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/model/entry/comment_edit_data.dart';
import 'package:gitbbs/ui/editcomment/effect.dart';
import 'package:gitbbs/ui/editcomment/reducer.dart';
import 'package:gitbbs/ui/editcomment/state.dart';
import 'view.dart';

class EditCommentPage extends Page<EditCommentState, CommentEditData> {
  EditCommentPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView);
}
