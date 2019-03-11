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

  int getCommentsCount();

  String getShowComments() {
    if (getCommentsCount() == null || getCommentsCount() == 0) {
      return '暂无评论';
    }
    return '${getCommentsCount().toString()} 条评论';
  }

  String getCreateTime();

  String getUpdateTime();

  String getCursor();

  void setMore(bool more) {}

  bool getMore() => false;

  String getBody();

  String getShowBody();
}
