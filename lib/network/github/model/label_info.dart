class LabelInfo {
  List<Tags> tags;
  List<Labels> labels;

  LabelInfo({this.tags, this.labels});

  LabelInfo.fromJson(Map<String, dynamic> json) {
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
    if (json['labels'] != null) {
      labels = new List<Labels>();
      json['labels'].forEach((v) {
        labels.add(new Labels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    if (this.labels != null) {
      data['labels'] = this.labels.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tags {
  String name;
  String desc;
  int level;

  Tags({this.name, this.desc, this.level});

  Tags.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    desc = json['desc'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['level'] = this.level;
    return data;
  }
}

class Labels {
  String id;
  String name;
  int level;

  Labels({this.id, this.name, this.level});

  Labels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['level'] = this.level;
    return data;
  }
}
