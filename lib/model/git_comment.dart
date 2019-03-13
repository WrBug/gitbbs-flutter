import 'package:gitbbs/model/GitUser.dart';

abstract class GitComment {
  String getId();

  GitUser getAuthor();

  String getAuthorAssociation();

  String getCreatedAt();

  String getUpdatedAt();

  void setBody(String body);

  String getBody();

  String getCursor();

  bool viewerCanDelete;

  bool viewerCanUpdate;

  bool viewerDidAuthor;

  bool isAuthor;

  Map<String, dynamic> toJson();
}
