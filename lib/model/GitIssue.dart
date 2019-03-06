import 'package:gitbbs/model/GitUser.dart';

abstract class GitIssue {
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
}
