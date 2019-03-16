import 'dart:convert';

import 'package:gitbbs/network/github/model/GithubComment.dart';
import 'package:gitbbs/network/github/model/GithubLabel.dart';
import 'package:gitbbs/network/github/model/GithubUser.dart';
import 'package:gitbbs/network/github/model/GithubV4Issue.dart';

class V4Convert {
  static GithubV4Issue toIssue(Map node) {
    GithubV4Issue issue = GithubV4Issue();
    issue.title = node['title'];
    issue.publishedAt = node['publishedAt'];
    issue.updatedAt = node['updatedAt'];
    issue.id = node['id'];
    issue.number = node['number'];
    issue.closed = node['closed'];
    issue.body = node['body'];
    issue.bodyText = node['bodyText'];
    issue.closedAt = node['closedAt'];
    issue.locked = node['locked'];
    GithubV4User user = GithubV4User();
    user.login = node['author']['login'];
    user.avatarUrl = node['author']['avatarUrl'];
    issue.author = user;
    issue.isAuthor = node['viewerDidAuthor'];
    issue.comments = node['comments']['totalCount'];
    List<GithubLabel> labels = new List();
    for (Map value in node['labels']['edges']) {
      value = value['node'];
      GithubLabel label = GithubLabel();
      label.name = value['name'];
      label.id = int.parse(
          String.fromCharCodes(base64.decode(value['id'])).split(':')[0]);
      label.url = value['url'];
      label.color = value['color'];
      label.defaultLabel = value['isDefault'];
      labels.add(label);
    }
    issue.labels = labels;
    return issue;
  }

  static GithubComment toComment(Map node) {
    GithubV4User user = GithubV4User();
    user.login = node['author']['login'];
    user.avatarUrl = node['author']['avatarUrl'];
    GithubComment comment = GithubComment()
      ..user = user
      ..authorAssociation = node['authorAssociation']
      ..id = node['id']
      ..url = node['url']
      ..createdAt = node['createdAt']
      ..updatedAt = node['lastEditedAt']
      ..viewerCanDelete = node['viewerCanDelete']
      ..viewerCanUpdate = node['viewerCanUpdate']
      ..viewerDidAuthor = node['viewerDidAuthor']
      ..isAuthor = node['viewerDidAuthor']
      ..body = node['body'];
    return comment;
  }
}
