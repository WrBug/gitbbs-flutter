import 'package:json_annotation/json_annotation.dart';

part 'github_gist.g.dart';

@JsonSerializable()
class GithubGist {
  String id;
  bool isPublic;
  String name;
  bool isFork;
  Map<String, String> files;

  GithubGist();

  factory GithubGist.fromJson(Map<String, dynamic> json) =>
      _$GithubGistFromJson(json);

  Map<String, dynamic> toJson() => _$GithubGistToJson(this);
}
