import 'package:json_annotation/json_annotation.dart';
import 'GithubUser.dart';

part 'GithubComment.g.dart';

@JsonSerializable()
class GithubComment {
  String url;
  @JsonKey(name: "html_url")
  String htmlUrl;
  @JsonKey(name: 'issue_url')
  String issueUrl;
  int id;
  @JsonKey(name: 'node_id')
  String nodeId;
  GithubUser user;
  @JsonKey(name: 'created_at')
  String createAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  @JsonKey(name: 'author_association')
  String authorAssociation;
  String body;

  GithubComment();

  factory GithubComment.fromJson(Map<String, dynamic> json) =>
      _$GithubCommentFromJson(json);

  Map<String, dynamic> toJson() => _$GithubCommentToJson(this);
}
