import 'package:gitbbs/network/Request.dart';

import '../GitNetworkRequestAdapter.dart';
import 'dart:convert';

class GitHubNetWorkAdapter extends GitNetworkRequestAdapter {
  @override
  String getApiUrl() => 'https://api.github.com';

  @override
  Request createIssue(String title, String body, String label) {
    var path = "/repos/$owner/$repoName/issues";
    var map = Map<String, dynamic>();
    map['title'] = title;
    map['body'] = body;
    map['assignees'] = [assignees];
    map['labels'] = [label];
    return Request(path, map, Method.POST, null);
  }

  @override
  Request getIssue(int number) {
    var path = "/repos/$owner/$repoName/issues/$number";
    return Request(path, null, Method.GET, null);
  }

  @override
  Request getComments(int number) {
    var path = "/repos/$owner/$repoName/issues/$number/comments";
    return Request(path, null, Method.GET, null);
  }

  @override
  Request doAuthenticated(String token) {
    return Request(
        '/user', null, Method.GET, {"Authorization": 'token $token'});
  }
}
