import 'package:gitbbs/network/GitHttpClient.dart';
import 'package:gitbbs/network/github/model/GithubComment.dart';
import 'package:gitbbs/network/github/model/GithubIssue.dart';
import 'package:gitbbs/network/github/model/GithubUser.dart';
import '../GitHttpRequest.dart';
import 'GitHubNetWorkAdapter.dart';

class GithubHttpRequest implements GitHttpRequest {
  GitHttpClient client;
  GitHubNetWorkAdapter adapter;

  GithubHttpRequest() {
    adapter = GitHubNetWorkAdapter();
    client = GitHttpClient(adapter.getApiUrl());
  }

  @override
  getComments(int number, Function callback) {
    client.execute(adapter.getComments(number)).then((response) {
      List<GithubComment> list = List<GithubComment>();
      response.data.forEach((item) {
        list.add(GithubComment.fromJson(item));
      });
      callback(true, list);
    }).catchError((err) {
      callback(false, '');
    });
  }

  @override
  getIssue(int number, Function callback) {
    client.execute(adapter.getIssue(number)).then((response) {
      callback(GithubIssue.fromJson(response.data));
    }).catchError((err) {
      callback(false, '');
    });
  }

  @override
  createIssue(String title, String body, String label, Function callback) {
    client.execute(adapter.createIssue(title, body, label)).then((response) {
      callback(GithubIssue.fromJson(response.data));
    }).catchError((err) {
      callback(false, '');
    });
  }

  @override
  doAuthenticated(String token, Function callback) {
    client.execute(adapter.doAuthenticated(token)).then((response) {
      callback(true, GithubUser.fromJson(response.data));
      client.setToken(token);
    }).catchError((err) {
      callback(false, '');
    });
  }
}
