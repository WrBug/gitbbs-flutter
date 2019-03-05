import 'package:gitbbs/model/GitUser.dart';
import 'package:gitbbs/model/UserCacheManager.dart';
import 'package:gitbbs/nativebirdge/MmkvChannel.dart';
import 'package:gitbbs/network/GitHttpClient.dart';
import 'package:gitbbs/network/github/model/GithubComment.dart';
import 'package:gitbbs/network/github/model/GithubIssue.dart';
import 'package:gitbbs/network/github/model/GithubUser.dart';
import '../GitHttpRequest.dart';
import 'GithubNetWorkAdapter.dart';
import 'GithubApi.dart';

class GithubHttpRequest implements GitHttpRequest {
  GitHttpClient _client;
  GithubNetWorkAdapter _adapter;
  static GithubHttpRequest _instance = GithubHttpRequest();

  GithubHttpRequest() {
    _adapter = GithubNetWorkAdapter();
    _client = GitHttpClient(_adapter.getApiUrl());
  }

  static getInstance() {
    return _instance;
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
  Future<GithubIssue> createIssue(
      String title, String body, String label) async {
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
