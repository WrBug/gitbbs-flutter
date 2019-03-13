// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GithubUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubV4User _$GithubV4UserFromJson(Map<String, dynamic> json) {
  return GithubV4User()
    ..login = json['login'] as String
    ..id = json['id'] as String
    ..url = json['url'] as String
    ..avatarUrl = json['avatarUrl'] as String
    ..bio = json['bio'] as String
    ..isSiteAdmin = json['isSiteAdmin'] as bool
    ..name = json['name'] as String
    ..company = json['company'] as String
    ..websiteUrl = json['websiteUrl'] as String
    ..location = json['location'] as String
    ..email = json['email'] as String;
}

Map<String, dynamic> _$GithubV4UserToJson(GithubV4User instance) =>
    <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'url': instance.url,
      'avatarUrl': instance.avatarUrl,
      'bio': instance.bio,
      'isSiteAdmin': instance.isSiteAdmin,
      'name': instance.name,
      'company': instance.company,
      'websiteUrl': instance.websiteUrl,
      'location': instance.location,
      'email': instance.email
    };
