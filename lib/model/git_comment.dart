import 'package:gitbbs/model/GitUser.dart';

abstract class GitComment {
  String getId();

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

  bool isAuthor;


  Map<String, dynamic> toJson();
}
