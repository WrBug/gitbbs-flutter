// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GithubLabel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubLabel _$GithubLabelFromJson(Map<String, dynamic> json) {
  return GithubLabel()
    ..id = json['id'] as int
    ..nodeId = json['node_id'] as String
    ..url = json['url'] as String
    ..name = json['name'] as String
    ..color = json['color'] as String
    ..defaultLabel = json['default'] as bool;
}

Map<String, dynamic> _$GithubLabelToJson(GithubLabel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'node_id': instance.nodeId,
      'url': instance.url,
      'name': instance.name,
      'color': instance.color,
      'default': instance.defaultLabel
    };
