// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_gist_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubGistFile _$GithubGistFileFromJson(Map<String, dynamic> json) {
  return GithubGistFile()
    ..content = json['content'] as String
    ..filename = json['filename'] as String;
}

Map<String, dynamic> _$GithubGistFileToJson(GithubGistFile instance) =>
    <String, dynamic>{
      'content': instance.content,
      'filename': instance.filename
    };
