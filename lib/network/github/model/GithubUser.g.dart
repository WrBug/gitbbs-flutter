// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GithubUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubUser _$GithubUserFromJson(Map<String, dynamic> json) {
  return GithubUser()
    ..login = json['login'] as String
    ..id = json['id'] as int
    ..nodeId = json['node_id'] as String
    ..avatarUrl = json['avatar_url'] as String
    ..url = json['url'] as String
    ..htmlUrl = json['html_url'] as String
    ..followersUrl = json['followers_url'] as String
    ..followingUrl = json['following_url'] as String
    ..gistsUrl = json['gists_url'] as String
    ..starredUrl = json['starred_url'] as String
    ..subscriptionsUrl = json['subscriptions_url'] as String
    ..organizationsUrl = json['organizations_url'] as String
    ..reposUrl = json['repos_url'] as String
    ..eventsUrl = json['events_url'] as String
    ..receivedEventsUrl = json['received_events_url'] as String
    ..siteAdmin = json['site_admin'] as bool
    ..type = json['type'] as String
    ..name = json['name'] as String
    ..company = json['company'] as String
    ..blog = json['blog'] as String
    ..location = json['location'] as String
    ..email = json['email'] as String
    ..hireable = json['hireable'] as bool
    ..bio = json['bio'] as String
    ..publicRepos = json['public_repos'] as int
    ..following = json['following'] as int
    ..followers = json['followers'] as int
    ..diskUsage = json['disk_usage'] as int;
}

Map<String, dynamic> _$GithubUserToJson(GithubUser instance) =>
    <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'node_id': instance.nodeId,
      'avatar_url': instance.avatarUrl,
      'url': instance.url,
      'html_url': instance.htmlUrl,
      'followers_url': instance.followersUrl,
      'following_url': instance.followingUrl,
      'gists_url': instance.gistsUrl,
      'starred_url': instance.starredUrl,
      'subscriptions_url': instance.subscriptionsUrl,
      'organizations_url': instance.organizationsUrl,
      'repos_url': instance.reposUrl,
      'events_url': instance.eventsUrl,
      'received_events_url': instance.receivedEventsUrl,
      'site_admin': instance.siteAdmin,
      'type': instance.type,
      'name': instance.name,
      'company': instance.company,
      'blog': instance.blog,
      'location': instance.location,
      'email': instance.email,
      'hireable': instance.hireable,
      'bio': instance.bio,
      'public_repos': instance.publicRepos,
      'following': instance.following,
      'followers': instance.followers,
      'disk_usage': instance.diskUsage
    };
