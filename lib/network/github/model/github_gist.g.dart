// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_gist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubGist _$GithubGistFromJson(Map<String, dynamic> json) {
  return GithubGist()
    ..isPublic = json['isPublic'] as bool
    ..name = json['name'] as String
    ..isFork = json['isFork'] as bool
    ..files = (json['files'] as Map<String, dynamic>)
        ?.map((k, e) => MapEntry(k, e as String));
}

Map<String, dynamic> _$GithubGistToJson(GithubGist instance) =>
    <String, dynamic>{
      'isPublic': instance.isPublic,
      'name': instance.name,
      'isFork': instance.isFork,
      'files': instance.files
    };
