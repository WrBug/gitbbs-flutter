import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/entry/comment_edit_data.dart';
import 'package:gitbbs/model/git_comment.dart';
import 'package:markdown_editor/editor.dart';
import 'package:markdown_editor/markdown_editor.dart';

class EditCommentState implements Cloneable<EditCommentState> {
  GitComment comment;
  GitIssue issue;
  Type type;
  GlobalKey<MarkdownEditorWidgetState> mdKey;
  GlobalKey<ScaffoldState> scaffoldKey;

  PageType getCurrentPage() {
    return mdKey.currentState?.getCurrentPage() ?? PageType.editor;
  }

  String getBody() {
    if (type == Type.modify) {
      return mdKey.currentState?.getMarkDownText()?.text ?? "";
    }
    if (type == Type.add) {
      return mdKey.currentState?.getMarkDownText()?.text ?? "";
    }
    if (type == Type.reply) {
      String content = '> ' + comment.getBody().replaceAll('\n', '\n> ').replaceAll('\r\n', '\r\n> ');
      String reply = mdKey.currentState?.getMarkDownText()?.text ?? "";
      return '''$content
      
      
      @${comment.getAuthor().getName()} $reply''';
    }
    return '';
  }

  bool isBodyEmpty() {
    return (mdKey.currentState?.getMarkDownText()?.text ?? '') == '';
  }

  @override
  EditCommentState clone() {
    return EditCommentState()
      ..comment = comment
      ..issue = issue
      ..scaffoldKey = scaffoldKey
      ..mdKey = mdKey
      ..type = type;
  }
}

EditCommentState initState(CommentEditData data) {
  return EditCommentState()
    ..comment = data.comment
    ..issue = data.issue
    ..scaffoldKey = GlobalKey<ScaffoldState>()
    ..mdKey = GlobalKey<MarkdownEditorWidgetState>()
    ..type = data.type;
}
