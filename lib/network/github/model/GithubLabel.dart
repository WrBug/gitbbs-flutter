import 'package:fish_redux/fish_redux.dart';
import 'package:json_annotation/json_annotation.dart';

part 'GithubLabel.g.dart';

@JsonSerializable()
class GithubLabel implements Cloneable<GithubLabel>{
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

  @override
  GithubLabel clone() {
    return GithubLabel.fromJson(toJson());
  }
}
