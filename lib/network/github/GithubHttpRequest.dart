import 'package:gitbbs/network/Request.dart';
import 'package:gitbbs/network/github/model/GithubComment.dart';
import 'package:gitbbs/network/github/model/GithubIssue.dart';
import '../GitHttpRequest.dart';
import 'GitHubNetWorkAdapter.dart';
import 'package:dio/dio.dart';

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
      callback(list);
    });
  }

  @override
  getIssue(int number, Function callback) {
    client.execute(adapter.getIssue(number)).then((response) {
      callback(GithubIssue.fromJson(response.data));
    });
  }

  @override
  createIssue(String title, String body, String label, Function callback) {
    client.execute(adapter.createIssue(title, body, label)).then((response) {
      callback(GithubIssue.fromJson(response.data));
    });
  }
}

class GitHttpClient {
  Dio dio;
  String baseUrl;

  GitHttpClient(this.baseUrl) {
    dio = Dio(
        BaseOptions(baseUrl: baseUrl, headers: {'Authorization': 'token xxx'}));
  }

  Future<Response> execute(Request request) async {
    if (request.method == Method.GET) {
      var response =
          await dio.get(request.path, queryParameters: request.params);
      return response;
    } else {
      var response = await dio.post(request.path, data: request.params);
      return response;
    }
  }
}
