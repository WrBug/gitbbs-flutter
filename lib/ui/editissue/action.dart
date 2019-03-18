import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/ui/widget/selectable_tags.dart';

enum EditIssueAction {
  togglePageType,
  saveIssue,
  submitIssue,
  updateTags,
  updateInitText
}

class EditIssueActionCreator {
  static Action updateTagsAction(List<Tag> tags) {
    return Action(EditIssueAction.updateTags, payload: tags);
  }

  static Action saveIssueAction() {
    return Action(EditIssueAction.saveIssue);
  }

  static Action onUpdateInitTextAction(String text) {
    return Action(EditIssueAction.updateInitText, payload: text);
  }

  static Action togglePageTypeAction() {
    return const Action(EditIssueAction.togglePageType);
  }

  static Action submitIssueAction() {
    return const Action(EditIssueAction.submitIssue);
  }
}
