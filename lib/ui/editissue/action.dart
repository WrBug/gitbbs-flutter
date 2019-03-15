import 'package:fish_redux/fish_redux.dart';

enum EditIssueAction { togglePageType,updateTags,updateInitText }

class EditIssueActionCreator {
  static Action updateTagsAction(List<String> tags) {
    return Action(EditIssueAction.updateTags, payload: tags);
  }

  static Action onUpdateInitTextAction(String text) {
    return Action(EditIssueAction.updateInitText, payload: text);
  }

  static Action togglePageTypeAction() {
    return const Action(EditIssueAction.togglePageType);

  }
}
