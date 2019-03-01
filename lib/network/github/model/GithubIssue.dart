import 'package:json_annotation/json_annotation.dart';
import 'GithubUser.dart';
import 'GithubLabel.dart';

part 'GithubIssue.g.dart';

@JsonSerializable()
class GithubIssue {
  GithubIssue();

  String url;
  @JsonKey(name: 'repository_url')
  String repositoryUrl;
  @JsonKey(name: 'labels_url')
  String labelsUrl;
  @JsonKey(name: 'comments_url')
  String commentsUrl;
  @JsonKey(name: 'events_url')
  String eventsUrl;
  @JsonKey(name: 'html_url')
  String htmlUrl;
  int id;
  @JsonKey(name: 'node_id')
  String nodeId;
  int number;
  String title;
  GithubUser user;
  List<GithubLabel> labels;
  String status;
  bool locked;
  GithubUser assignee;
  List<GithubUser> assignees;
  var milestone;
  int comments;
  @JsonKey(name: 'created_at')
  String createAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  @JsonKey(name: 'closed_at')
  String closedAt;
  @JsonKey(name: 'author_association')
  String authorAssociation;
  String body;
  @JsonKey(name: 'closed_by')
  String closedBy;

  factory GithubIssue.fromJson(Map<String, dynamic> json) =>
      _$GithubIssueFromJson(json);

  Map<String, dynamic> toJson() => _$GithubIssueToJson(this);
}
