import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/ui/editissue/action.dart';
import 'package:gitbbs/ui/editissue/state.dart';
import 'package:markdown_editor/markdown_editor.dart';

Reducer<EditIssueState> buildReducer() {
  return asReducer<EditIssueState>(<Object, Reducer<EditIssueState>>{
    EditIssueAction.updateTags: _updateTags,
    EditIssueAction.updateInitText: _updateInitText,
    EditIssueAction.togglePageType: _togglePageType
  });
}

EditIssueState _updateTags(EditIssueState state, Action action) {
  EditIssueState newState = state.clone();
  newState.tags = action.payload;
  return newState;
}

EditIssueState _updateInitText(EditIssueState state, Action action) {
  EditIssueState newState = state.clone();
  newState.initText = action.payload;
  return newState;
}

EditIssueState _togglePageType(EditIssueState state, Action action) {
  var pageType = state.getCurrentPage();
  if (pageType == PageType.preview) {
    pageType = PageType.editor;
  } else {
    pageType = PageType.preview;
  }
  state.mdKey.currentState.setCurrentPage(pageType);
  return state;
}
