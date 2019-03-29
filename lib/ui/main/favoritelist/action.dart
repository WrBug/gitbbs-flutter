import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';

enum FavoriteListAction { updateData,refreshData }

class FavoriteListActionCreator {
  static Action updateDataAction(List<GitIssue> list) {
    return Action(FavoriteListAction.updateData, payload: list);
  }
  static Action refreshDataAction() {
    return Action(FavoriteListAction.refreshData);
  }
}
