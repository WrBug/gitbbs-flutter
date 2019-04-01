class GithubMessage {
  String title;
  String fileName;
  String path;
  int date;

  GithubMessage({this.title, this.fileName, this.path, this.date});

  GithubMessage.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    fileName = json['fileName'];
    path = json['path'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['fileName'] = this.fileName;
    data['path'] = this.path;
    data['date'] = this.date;
    return data;
  }
}
