import 'package:json_annotation/json_annotation.dart';

part 'GithubLabel.g.dart';

@JsonSerializable()
class GithubLabel {
  int id;
  @JsonKey(name: 'node_id')
  String nodeId;
  String url;
  String name;
  String color;
  @JsonKey(name: 'default')
  bool defaultLabel;

  factory GithubLabel.fromJson(Map<String, dynamic> json) =>
      _$GithubLabelFromJson(json);

  Map<String, dynamic> toJson() => _$GithubLabelToJson(this);

  GithubLabel();
}
