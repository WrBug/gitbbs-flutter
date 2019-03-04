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
  getComments(int number, Function callback) {
    _client.execute(_adapter.getComments(number)).then((response) {
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
    _client.execute(_adapter.getIssue(number)).then((response) {
      callback(GithubIssue.fromJson(response.data));
    }).catchError((err) {
      callback(false, '');
    });
  }

  @override
  createIssue(String title, String body, String label, Function callback) {
    _client.execute(_adapter.createIssue(title, body, label)).then((response) {
      callback(GithubIssue.fromJson(response.data));
    }).catchError((err) {
      callback(false, '');
    });
  }

  @override
  doAuthenticated(String token, Function callback) {
    _client.execute(_adapter.doAuthenticated(token)).then((response) {
      callback(true, GithubUser.fromJson(response.data));
      _client.setToken(token);
    }).catchError((err) {
      callback(false, '');
    });
  }

  @override
  signIn(String username, String password, Function callback) {
    var _githubApi = GithubApi();
    _githubApi.signIn(username, password).then((str) {
      if (str == '') {
        callback(false);
        return;
      }
      MmkvChannel.getInstance().saveToken(str);
      callback(true, str);
    }).catchError((err) {
      callback(false);
    });
  }
}
