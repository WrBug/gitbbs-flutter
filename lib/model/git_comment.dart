import 'package:gitbbs/model/GitUser.dart';

abstract class GitComment {
  GitUser getAuthor();

  String getAuthorAssociation();

  String getCreatedAt();

  String getUpdatedAt();

  String getBody();

  String getCursor();

  void setFloor(int floor);

  int getFloor();

  bool viewerCanDelete;

  bool viewerCanUpdate;

  bool viewerDidAuthor;
}
