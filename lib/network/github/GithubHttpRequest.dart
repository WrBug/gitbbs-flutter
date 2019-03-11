import 'dart:convert';

import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/GitUser.dart';
import 'package:gitbbs/model/PagingData.dart';
import 'package:gitbbs/model/UserCacheManager.dart';
import 'package:gitbbs/model/db/gitissue_data_base.dart';
import 'package:gitbbs/model/git_comment.dart';
import 'package:gitbbs/model/issue_cache_manager.dart';
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
import 'package:gitbbs/network/github/v4/v4_convert.dart';
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
      GithubV4Issue issue = V4Convert.toIssue(map['node']);
      issue.cursor = map['cursor'];
      issues.add(issue);
    });
    GitIssueDataBase.createInstance().save(list: issues);
    return PagingData(issues.length == size, issues);
  }

  @override
  Future<PagingData<GitComment>> getComments(int number, String before) async {
    final size = 15;
    var response =
        await _client.execute(_adapter.getComments(number, before, size));
    List list =
        response.data['data']['repository']['issue']['comments']['edges'];
    var comments = list.map<GithubComment>((map) {
      var comment = V4Convert.toComment(map['node']);
      comment.cursor = map['cursor'];
      return comment;
    }).toList();
    return PagingData(comments.length == size, comments);
  }

  @override
  getIssue(int number) async {
    var response = await _client.execute(_adapter.getIssue(number));
    Map map = response.data['data']['repository']['issue'];
    var issue = V4Convert.toIssue(map);
    IssueCacheManager.saveCache(issue.getNumber(), issue.getBody());
    GitIssueDataBase.createInstance().save(gitIssue: issue);
    return issue;
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
