import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/PagingData.dart';
import 'package:gitbbs/model/git_comment.dart';
import 'package:gitbbs/network/github/model/GithubComment.dart';

enum CommentListAction {
  refresh,
  onRefreshed,
  loadMore,
  onMoreLoaded,
  editComment,
  replyComment,
  queryDeleteComment,
  deleteComment,
  onCommentDeleted
}

class CommentListActionCreator {
  static Action refreshAction() {
    return Action(CommentListAction.refresh);
  }

  static Action refreshedAction(PagingData<GitComment> data) {
    return Action(CommentListAction.onRefreshed, payload: data);
  }

  static Action loadMoreAction() {
    return Action(CommentListAction.loadMore);
  }

  static Action onMoreLoadedAction(PagingData<GitComment> data) {
    return Action(CommentListAction.onMoreLoaded, payload: data);
  }

  static Action editCommentAction(GitComment comment) {
    return Action(CommentListAction.editComment, payload: comment);
  }

  static Action replyCommentAction(GitComment comment) {
    return Action(CommentListAction.replyComment, payload: comment);
  }

  static Action queryDeleteCommentAction(GitComment comment) {
    return Action(CommentListAction.queryDeleteComment, payload: comment);
  }

  static Action deleteCommentAction(GitComment comment) {
    return Action(CommentListAction.deleteComment, payload: comment);
  }

  static Action onCommentDeletedAction(GitComment comment) {
    return Action(CommentListAction.onCommentDeleted, payload: comment);
  }
}
