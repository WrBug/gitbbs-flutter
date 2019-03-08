import 'package:gitbbs/model/GitUser.dart';
import 'package:fish_redux/fish_redux.dart';

abstract class GitIssue implements Cloneable<GitIssue> {
  String getTitle();

  int getNumber();

  bool isClosed();

  String getClosedAt();

  bool isLocked();

  GitUser getAuthor();

  int getCommentsCount();

  String getCreateTime();

  String getUpdateTime();

  String getCursor();

  void setMore(bool more);

  bool getMore();


  String getBody();

  String getShowBody();
}
