import 'package:gitbbs/network/Request.dart';

import '../GitNetworkRequestAdapter.dart';
import 'dart:convert';

class GitHubNetWorkAdapter extends GitNetworkRequestAdapter {
  @override
  String getApiUrl() => 'https://api.github.com';

  @override
  Request createIssue(String title, String body, String label) {
    var path = "/repos/$owner/$repoName/issues";
    var map = Map();
    map['title'] = title;
    map['body'] = body;
    map['assignees'] = [assignees];
    map['labels'] = [label];
    return Request(path, map, Method.POST);
  }

  @override
  Request getIssue(int number) {
    var path = "/repos/$owner/$repoName/issues/$number";
    return Request(path, null, Method.GET);
  }

  @override
  Request getComments(int number) {
    var path = "/repos/$owner/$repoName/issues/$number/comments";
    return Request(path, null, Method.GET);
  }
}
