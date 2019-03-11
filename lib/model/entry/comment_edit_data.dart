import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/git_comment.dart';

class CommentEditData {
  GitComment comment;
  GitIssue issue;
  Type type = Type.add;

  CommentEditData(this.issue, this.type, {this.comment});
}

enum Type { add, modify, reply }
