import 'dart:collection';

import 'package:gitbbs/network/IssueState.dart';
import 'package:gitbbs/network/Request.dart';
import 'package:gitbbs/network/github/v4/V4Request.dart';
import 'package:gitbbs/network/github/v4/v4_pre_view_request.dart';
import 'package:gitbbs/network/github/v4/v4_query.dart';
import '../../GitNetworkRequestAdapter.dart';

class GithubV4NetWorkAdapter extends GitNetworkRequestAdapter {
  @override
  String getApiUrl() => 'https://api.github.com';

  @override
  Request getMoreIssues(List<String> label, String creator,
      IssueState issueState, String before, String after, int size) {
    String query = getIssuesQuery(issueState, size,
        label: label, creator: creator, before: before, after: after);
    var map = {'query': query};
    return V4Request(map);
  }

  @override
  Request createIssue(String title, String body, String label) {
    var path = "/repos/$owner/$repoName/issues";
    var map = Map<String, dynamic>();
    map['title'] = title;
    map['body'] = body;
    map['labels'] = [label];
    return Request(path, map, Method.POST);
  }

  @override
  Request getIssue(int number) {
    String query = getIssueQuery(number);
    var map = {'query': query};
    return V4Request(map);
  }

  @override
  Request getComments(int number, String before, int size) {
    String query = getCommentsQuery(number, before, size);
    var map = {'query': query};
    return V4Request(map);
  }

  @override
  Request addComment(String issueId, String body) {
    String query = getAddCommentQuery(issueId, body);
    var map = {'query': query};
    return V4Request(map);
  }

  @override
  Request doAuthenticated(String token) {
    return Request('/user', null, Method.GET,
        header: {"Authorization": 'token $token'});
  }

  @override
  Request modifyComment(String commentId, String body) {
    String query = getModifyCommentQuery(commentId, body);
    var map = {'query': query};
    return V4PreViewRequest(map);
  }
}
