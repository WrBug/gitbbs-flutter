// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GithubV4Issue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubV4Issue _$GithubV4IssueFromJson(Map<String, dynamic> json) {
  return GithubV4Issue()
    ..cursor = json['cursor'] as String
    ..title = json['title'] as String
    ..publishedAt = json['publishedAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..id = json['id'] as String
    ..number = json['number'] as int
    ..closed = json['closed'] as bool
    ..closedAt = json['closedAt'] as String
    ..locked = json['locked'] as bool
    ..author = json['author'] == null
        ? null
        : GithubUser.fromJson(json['author'] as Map<String, dynamic>)
    ..comments = json['comments'] as int
    ..labels = (json['labels'] as List)
        ?.map((e) =>
            e == null ? null : GithubLabel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$GithubV4IssueToJson(GithubV4Issue instance) =>
    <String, dynamic>{
      'cursor': instance.cursor,
      'title': instance.title,
      'publishedAt': instance.publishedAt,
      'updatedAt': instance.updatedAt,
      'id': instance.id,
      'number': instance.number,
      'closed': instance.closed,
      'closedAt': instance.closedAt,
      'locked': instance.locked,
      'author': instance.author,
      'comments': instance.comments,
      'labels': instance.labels
    };
