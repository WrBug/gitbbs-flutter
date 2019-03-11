import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/PagingData.dart';
import 'package:gitbbs/model/git_comment.dart';
import 'package:gitbbs/network/github/model/GithubComment.dart';

enum CommentListAction { update, editComment, replyComment }

class CommentListActionCreator {
  static Action updateAction(PagingData<GitComment> data) {
    return Action(CommentListAction.update, payload: data);
  }

  static Action editCommentAction(GitComment comment) {
    return Action(CommentListAction.editComment, payload: comment);
  }

  static Action replyCommentAction(GitComment comment) {
    return Action(CommentListAction.replyComment, payload: comment);
  }
}
