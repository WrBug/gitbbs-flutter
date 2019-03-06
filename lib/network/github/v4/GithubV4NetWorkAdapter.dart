import 'dart:collection';

import 'package:gitbbs/network/IssueState.dart';
import 'package:gitbbs/network/Request.dart';
import 'package:gitbbs/network/github/v4/V4Request.dart';
import '../../GitNetworkRequestAdapter.dart';

class GithubV4NetWorkAdapter extends GitNetworkRequestAdapter {
  @override
  String getApiUrl() => 'https://api.github.com';

  @override
  Request getIssues(List<String> label, String creator, IssueState issueState,
      String after, int size) {
    String labels = label == null || label.isEmpty
        ? "null"
        : '["' + label.join('","') + '"]';
    String query = """
          {
      repository(owner: "$owner", name: "$repoName") {
        issues(first: $size,labels:$labels, states: [OPEN,CLOSED],orderBy:{field: CREATED_AT, direction: DESC},after:${after == null || after == '' ? "null" : '"$after"'}) {
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
        .replaceAll('\n', ' ');
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
}
