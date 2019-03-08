import 'dart:collection';

import 'package:gitbbs/network/IssueState.dart';
import 'package:gitbbs/network/Request.dart';
import 'package:gitbbs/network/github/v4/V4Request.dart';
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
    var path = "/repos/$owner/$repoName/issues/$number";
    return Request(path, null, Method.GET);
  }

  @override
  Request getComments(int number) {
    var path = "/repos/$owner/$repoName/issues/$number/comments";
    return Request(path, null, Method.GET);
  }

  @override
  Request doAuthenticated(String token) {
    return Request('/user', null, Method.GET,
        header: {"Authorization": 'token $token'});
  }

  String getIssuesQuery(IssueState issueState, int size,
      {List<String> label, String creator, String before, String after}) {
    String labels = label == null || label.isEmpty
        ? "null"
        : '["' + label.join('","') + '"]';
    String states = '[OPEN,CLOSED]';
    if (issueState == IssueState.OPEN) {
      states = '[OPEN]';
    } else if (issueState == IssueState.CLOSED) {
      states = '[CLOSED]';
    }
    String beforeStr = 'null';
    if (before != null && before != '') {
      beforeStr = '"$before"';
    }
    String afterStr = 'null';
    if (after != null && after != '') {
      afterStr = '"$after"';
    }
    return """
          {
      repository(owner: "$owner", name: "$repoName") {
        issues(first: $size,labels:$labels, states: $states,orderBy:{field: CREATED_AT, direction: DESC},before:$beforeStr,after:$afterStr) {
          edges {
            cursor
            node {
              title
              publishedAt
              updatedAt
              id
              number
              closed
              closedAt
              locked
              author{
                login
                avatarUrl
              }
              comments{
                totalCount
              }
              labels(first:100) {
                edges {
                  node {
                    name
                    id
                    url
                    color
                    isDefault
                  }
                }
              }
            }
          }
        }
      }
    }
    """
        .replaceAll("\t", " ")
        .replaceAll('\n', ' ')
        .replaceAll(RegExp(r' +'), ' ');
  }
}
