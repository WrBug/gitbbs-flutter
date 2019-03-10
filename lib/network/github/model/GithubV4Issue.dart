import 'dart:convert';

import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/GitUser.dart';
import 'package:gitbbs/network/github/model/GithubLabel.dart';
import 'package:gitbbs/network/github/model/GithubUser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'GithubV4Issue.g.dart';

@JsonSerializable()
class GithubV4Issue extends GitIssue {
  GithubV4Issue();

  String cursor;
  String title;
  String publishedAt;
  String updatedAt;
  String id;
  int number;
  bool closed;
  String closedAt;
  bool locked;
  GithubUser author;
  int comments;
  List<GithubLabel> labels;
  bool hasMore;
  String body;
  @JsonKey(name: 'bodyHTML')
  String bodyHtml;

  @override
  GitUser getAuthor() {
    return author;
  }

  @override
  String getClosedAt() {
    return closedAt;
  }

  @override
  int getCommentsCount() {
    return comments;
  }


  @override
  String getCreateTime() {
    return publishedAt;
  }

  @override
  int getNumber() {
    return number;
  }

  @override
  String getTitle() {
    return title;
  }

  @override
  String getUpdateTime() {
    return updatedAt;
  }

  @override
  bool isClosed() {
    return closed;
  }

  @override
  bool isLocked() {
    return locked;
  }

  @override
  String getCursor() {
    return cursor;
  }

  factory GithubV4Issue.fromJson(Map<String, dynamic> json) =>
      _$GithubV4IssueFromJson(json);

  Map<String, dynamic> toJson() => _$GithubV4IssueToJson(this);

  @override
  GitIssue clone() {
    return GithubV4Issue.fromJson(jsonDecode(jsonEncode(this)));
  }

  @override
  void setMore(bool more) {
    hasMore = more;
  }

  @override
  bool getMore() {
    return hasMore == null ? false : hasMore;
  }

  @override
  String getBody() {
    return body;
  }

  @override
  String getShowBody() {
    return bodyHtml;
  }
}
