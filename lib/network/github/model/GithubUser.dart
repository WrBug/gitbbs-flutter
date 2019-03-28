import 'package:gitbbs/model/GitUser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'GithubUser.g.dart';

@JsonSerializable()
class GithubV4User extends GitUser {
  String login;
  String id;
  String url;
  String avatarUrl;
  String bio;
  bool isSiteAdmin;
  String name;
  String company;
  String websiteUrl;
  String location;
  String email;
  int issuesCount;

  GithubV4User();

  factory GithubV4User.fromJson(Map<String, dynamic> json) =>
      _$GithubV4UserFromJson(json);

  Map<String, dynamic> toJson() => _$GithubV4UserToJson(this);

  @override
  String getAvatarUrl() {
    return avatarUrl;
  }

  @override
  String getName() {
    return name ?? login ?? '';
  }


  @override
  GitUser clone() {
    return GithubV4User.fromJson(toJson());
  }
}
