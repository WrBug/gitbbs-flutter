// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GithubComment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubComment _$GithubCommentFromJson(Map<String, dynamic> json) {
  return GithubComment()
    ..url = json['url'] as String
    ..htmlUrl = json['html_url'] as String
    ..issueUrl = json['issue_url'] as String
    ..id = json['id'] as int
    ..nodeId = json['node_id'] as String
    ..user = json['user'] == null
        ? null
        : GithubUser.fromJson(json['user'] as Map<String, dynamic>)
    ..createdAt = json['created_at'] as String
    ..updatedAt = json['updated_at'] as String
    ..authorAssociation = json['author_association'] as String
    ..body = json['body'] as String
    ..cursor = json['cursor'] as String;
}

Map<String, dynamic> _$GithubCommentToJson(GithubComment instance) =>
    <String, dynamic>{
      'url': instance.url,
      'html_url': instance.htmlUrl,
      'issue_url': instance.issueUrl,
      'id': instance.id,
      'node_id': instance.nodeId,
      'user': instance.user,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'author_association': instance.authorAssociation,
      'body': instance.body,
      'cursor': instance.cursor
    };
