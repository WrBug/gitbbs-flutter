import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/ui/editissue/bean/edit_issue_info.dart';
import 'package:gitbbs/ui/editissue/effect.dart';
import 'package:gitbbs/ui/editissue/reducer.dart';
import 'package:gitbbs/ui/editissue/state.dart';
import 'view.dart';

class EditIssuePage extends Page<EditIssueState, EditIssueInfo> {
  EditIssuePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView);
}
