import 'package:gitbbs/model/GitUser.dart';
import 'package:gitbbs/model/git_comment.dart';
import 'package:json_annotation/json_annotation.dart';
import 'GithubUser.dart';

part 'GithubComment.g.dart';

@JsonSerializable()
class GithubComment implements GitComment {
  String url;
  @JsonKey(name: "html_url")
  String htmlUrl;
  @JsonKey(name: 'issue_url')
  String issueUrl;
  String id;
  @JsonKey(name: 'node_id')
  String nodeId;
  GithubUser user;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  @JsonKey(name: 'author_association')
  String authorAssociation;
  String body;
  String cursor;
  int floor;
  bool viewerCanUpdate;
  @override
  bool viewerCanDelete;

  @override
  bool viewerDidAuthor;

  GithubComment();

  factory GithubComment.fromJson(Map<String, dynamic> json) =>
      _$GithubCommentFromJson(json);

  Map<String, dynamic> toJson() => _$GithubCommentToJson(this);

  @override
  GitUser getAuthor() {
    return user;
  }

  @override
  String getAuthorAssociation() {
    return authorAssociation;
  }

  @override
  String getBody() {
    return body;
  }

  @override
  String getCreatedAt() {
    return createdAt;
  }

  @override
  String getUpdatedAt() {
    return updatedAt;
  }

  @override
  String getCursor() => cursor;


  @override
  String getId() => id;

  @override
  bool isAuthor;

  @override
  void setBody(String body) {
    this.body = body;
  }
}
