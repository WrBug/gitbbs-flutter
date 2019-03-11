import 'package:fish_redux/fish_redux.dart';
import 'package:markdown_editor/markdown_editor.dart';

enum EditCommentAction {
  togglePageType,
  checkSubmitComment,
  submitComment,
  pageTypeChanged
}

class EditCommentActionCreator {
  static Action togglePageTypeAction() {
    return const Action(EditCommentAction.togglePageType);
  }

  static Action pageTypeChangedAction() {
    return const Action(EditCommentAction.pageTypeChanged);
  }

  static Action submitCommentAction() {
    return const Action(EditCommentAction.submitComment);
  }

  static Action checkSubmitCommentAction() {
    return const Action(EditCommentAction.checkSubmitComment);
  }
}
