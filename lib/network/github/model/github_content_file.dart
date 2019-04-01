import 'package:gitbbs/model/git_content_file.dart';

class GitHubContentFile implements GitContentFile {
  String name;
  String path;
  String sha;
  int size;
  String url;
  String htmlUrl;
  String gitUrl;
  String downloadUrl;
  String type;

  GitHubContentFile(
      {this.name,
      this.path,
      this.sha,
      this.size,
      this.url,
      this.htmlUrl,
      this.gitUrl,
      this.downloadUrl,
      this.type});

  GitHubContentFile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    path = json['path'];
    sha = json['sha'];
    size = json['size'];
    url = json['url'];
    htmlUrl = json['html_url'];
    gitUrl = json['git_url'];
    downloadUrl = json['download_url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['path'] = this.path;
    data['sha'] = this.sha;
    data['size'] = this.size;
    data['url'] = this.url;
    data['html_url'] = this.htmlUrl;
    data['git_url'] = this.gitUrl;
    data['download_url'] = this.downloadUrl;
    data['type'] = this.type;
    return data;
  }

  @override
  String getName() => name;

  @override
  String getPath() => path;
}
