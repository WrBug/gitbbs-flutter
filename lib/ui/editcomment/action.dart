import 'package:fish_redux/fish_redux.dart';

enum EditCommentAction {
  togglePageType,
  checkSubmitComment,
  submitComment,
  pageTypeChanged,
  onUpdateInitText
}

class EditCommentActionCreator {
  static Action togglePageTypeAction() {
    return const Action(EditCommentAction.togglePageType);
  }

  static Action onUpdateInitTextAction(String initText) {
    return  Action(EditCommentAction.onUpdateInitText, payload: initText);
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
