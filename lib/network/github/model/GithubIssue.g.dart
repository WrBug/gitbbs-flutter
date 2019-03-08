// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GithubIssue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubIssue _$GithubIssueFromJson(Map<String, dynamic> json) {
  return GithubIssue()
    ..url = json['url'] as String
    ..repositoryUrl = json['repository_url'] as String
    ..labelsUrl = json['labels_url'] as String
    ..commentsUrl = json['comments_url'] as String
    ..eventsUrl = json['events_url'] as String
    ..htmlUrl = json['html_url'] as String
    ..id = json['id'] as int
    ..nodeId = json['node_id'] as String
    ..number = json['number'] as int
    ..title = json['title'] as String
    ..user = json['user'] == null
        ? null
        : GithubUser.fromJson(json['user'] as Map<String, dynamic>)
    ..labels = (json['labels'] as List)
        ?.map((e) =>
            e == null ? null : GithubLabel.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..status = json['status'] as String
    ..locked = json['locked'] as bool
    ..assignee = json['assignee'] == null
        ? null
        : GithubUser.fromJson(json['assignee'] as Map<String, dynamic>)
    ..assignees = (json['assignees'] as List)
        ?.map((e) =>
            e == null ? null : GithubUser.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..milestone = json['milestone']
    ..comments = json['comments'] as int
    ..createAt = json['created_at'] as String
    ..updatedAt = json['updated_at'] as String
    ..closedAt = json['closed_at'] as String
    ..authorAssociation = json['author_association'] as String
    ..body = json['body'] as String
    ..closedBy = json['closed_by'] == null
        ? null
        : GithubUser.fromJson(json['closed_by'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GithubIssueToJson(GithubIssue instance) =>
    <String, dynamic>{
      'url': instance.url,
      'repository_url': instance.repositoryUrl,
      'labels_url': instance.labelsUrl,
      'comments_url': instance.commentsUrl,
      'events_url': instance.eventsUrl,
      'html_url': instance.htmlUrl,
      'id': instance.id,
      'node_id': instance.nodeId,
      'number': instance.number,
      'title': instance.title,
      'user': instance.user,
      'labels': instance.labels,
      'status': instance.status,
      'locked': instance.locked,
      'assignee': instance.assignee,
      'assignees': instance.assignees,
      'milestone': instance.milestone,
      'comments': instance.comments,
      'created_at': instance.createAt,
      'updated_at': instance.updatedAt,
      'closed_at': instance.closedAt,
      'author_association': instance.authorAssociation,
      'body': instance.body,
      'closed_by': instance.closedBy
    };
