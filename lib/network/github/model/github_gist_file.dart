import 'package:json_annotation/json_annotation.dart';

part 'github_gist_file.g.dart';

@JsonSerializable()
class GithubGistFile {
  String content;
  String filename;

  GithubGistFile();

  factory GithubGistFile.fromJson(Map<String, dynamic> json) =>
      _$GithubGistFileFromJson(json);

  Map<String, dynamic> toJson() => _$GithubGistFileToJson(this);
}
