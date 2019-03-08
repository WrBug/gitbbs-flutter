import 'dart:convert';

import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/GitUser.dart';
import 'package:gitbbs/model/PagingData.dart';
import 'package:gitbbs/model/UserCacheManager.dart';
import 'package:gitbbs/network/GitHttpClient.dart';
import 'package:gitbbs/network/GitNetworkRequestAdapter.dart';
import 'package:gitbbs/network/IssueState.dart';
import 'package:gitbbs/network/github/GithubNetWorkAdapter.dart';
import 'package:gitbbs/network/github/model/GithubComment.dart';
import 'package:gitbbs/network/github/model/GithubIssue.dart';
import 'package:gitbbs/network/github/model/GithubLabel.dart';
import 'package:gitbbs/network/github/model/GithubUser.dart';
import 'package:gitbbs/network/github/model/GithubV4Issue.dart';
import 'package:gitbbs/network/github/v4/GithubV4NetWorkAdapter.dart';
import '../GitHttpRequest.dart';
import 'GithubApi.dart';

class GithubHttpRequest implements GitHttpRequest {
  GitHttpClient _client;
  GitNetworkRequestAdapter _adapter;
  static GithubHttpRequest _instance = GithubHttpRequest();

  GithubHttpRequest() {
    _adapter = GithubV4NetWorkAdapter();
    _client = GitHttpClient(_adapter.getApiUrl());
  }

  static getInstance() {
    return _instance;
  }

  @override
  Future<PagingData<GitIssue>> getMoreIssues(
      {List<String> label,
      String creator,
      IssueState state,
      String before,
      String after}) async {
    final size = 4;
    var response = await _client.execute(
        _adapter.getMoreIssues(label, creator, state, before, after, size));
    var issues = List<GitIssue>();
    List list = response.data['data']['repository']['issues']['edges'];
    list.forEach((map) {
      GithubV4Issue issue = GithubV4Issue();
      issue.cursor = map['cursor'];
      Map node = map['node'];
      issue.title = node['title'];
      issue.publishedAt = node['publishedAt'];
      issue.updatedAt = node['updatedAt'];
      issue.id = node['id'];
      issue.number = node['number'];
      issue.closed = node['closed'];
      issue.closedAt = node['closedAt'];
      issue.locked = node['locked'];
      GithubUser user = GithubUser();
      user.login = node['author']['login'];
      user.avatarUrl = node['author']['avatarUrl'];
      issue.author = user;
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
      issues.add(issue);
    });
    return PagingData(issues.length == size, issues);
  }

  @override
  getComments(int number) async {
    var response = await _client.execute(_adapter.getComments(number));
    List<GithubComment> list = List<GithubComment>();
    response.data.forEach((item) {
      list.add(GithubComment.fromJson(item));
    });
    return list;
  }

  @override
  getIssue(int number) async {
    var response = await _client.execute(_adapter.getIssue(number));
    return GithubIssue.fromJson(response.data);
  }

  @override
  Future<GitIssue> createIssue(String title, String body, String label) async {
    var response =
        await _client.execute(_adapter.createIssue(title, body, label));
    return GithubIssue.fromJson(response.data);
  }

  @override
  Future<GitUser> doAuthenticated(String token) async {
    var response = await _client.execute(_adapter.doAuthenticated(token));
    return GithubUser.fromJson(response.data);
  }

  @override
  Future<bool> signIn(String username, String password) async {
    var _githubApi = GithubApi();
    var str = await _githubApi.signIn(username, password);
    if (str == '') {
      return false;
    }
    UserCacheManager.saveToken(str);
    return true;
  }
}
