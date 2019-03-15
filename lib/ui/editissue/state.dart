import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/ui/editissue/bean/edit_issue_info.dart';
import 'package:markdown_editor/markdown_editor.dart';

class EditIssueState implements Cloneable<EditIssueState> {
  GitIssue issue;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<MarkdownEditorWidgetState> mdKey;
  TextEditingController titleController;
  IssueType issueType;
  IssueEditType editType;
  List<String> tags;
  String initText;

  @override
  EditIssueState clone() {
    return EditIssueState()
      ..issue = issue
      ..mdKey = mdKey
      ..titleController = titleController
      ..issueType = issueType
      ..tags = tags
      ..initText = initText
      ..editType = editType
      ..scaffoldKey = scaffoldKey;
  }

  getCurrentPage() {
    return mdKey?.currentState?.getCurrentPage() ?? PageType.editor;
  }

  String getCacheKey() {
    return issue?.getId() ?? "" + issueType.toString();
  }
}

EditIssueState initState(EditIssueInfo issueInfo) {
  EditIssueState state = EditIssueState();
  state.issue = issueInfo.issue;
  state.scaffoldKey = GlobalKey();
  state.issueType = issueInfo.issueType;
  state.editType = issueInfo.editType;
  state.tags = [];
  state.initText = '';
  state.mdKey = GlobalKey();
  state.titleController = TextEditingController();
  if (state.issue != null) {
    state.titleController.text = state.issue.getTitle();
  }
  return state;
}
