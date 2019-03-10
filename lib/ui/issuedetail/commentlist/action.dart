import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/network/github/model/GithubComment.dart';

enum CommentListAction { update }

class CommentListActionCreator {
  static Action updateAction(List<GithubComment> list) {
    return Action(CommentListAction.update, payload: list);
  }
}
