import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/GitUser.dart';
import 'package:json_annotation/json_annotation.dart';
import 'GithubUser.dart';
import 'GithubLabel.dart';

part 'GithubIssue.g.dart';

@JsonSerializable()
class GithubIssue implements GitIssue {
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

  @override
  GitUser getAuthor() {
    // TODO: implement getAuthor
    return user;
  }

  @override
  int getCommentsCount() {
    // TODO: implement getCommentsCount
    return comments;
  }

  @override
  String getClosedAt() {
    return closedAt;
  }

  @override
  String getCreateTime() {
    return createAt;
  }

  @override
  int getNumber() {
    return number;
  }

  @override
  String getTitle() {
    return title;
  }

  @override
  String getUpdateTime() {
    return updatedAt;
  }

  @override
  bool isClosed() {
    return closedAt == null || createAt == '';
  }

  @override
  bool isLocked() {
    return locked;
  }

  @override
  String getCursor() {
    return '';
  }

  @override
  GitIssue clone() {
    return GithubIssue.fromJson(toJson());
  }
}
