import 'package:gitbbs/model/GitUser.dart';
import 'package:fish_redux/fish_redux.dart';

abstract class GitIssue implements Cloneable<GitIssue> {

  String getId();
  String getTitle();

  int getNumber();

  bool isClosed();

  String getClosedAt();

  bool isLocked();

  GitUser getAuthor();

  int comments;
  String getShowComments() {
    if (comments == null || comments == 0) {
      return '暂无评论';
    }
    return '${comments.toString()} 条评论';
  }

  String getCreateTime();

  String getUpdateTime();

  String getCursor();

  void setMore(bool more) {}

  bool getMore() => false;

  String getBody();

  String getShowBody();
}
