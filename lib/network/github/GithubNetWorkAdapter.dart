//import 'dart:collection';
//
//import 'package:gitbbs/network/IssueState.dart';
//import 'package:gitbbs/network/Request.dart';
//import '../GitNetworkRequestAdapter.dart';
//
//class GithubNetWorkAdapter extends GitNetworkRequestAdapter {
//  @override
//  String getApiUrl() => 'https://api.github.com';
//
//  @override
//  Request getIssues(List<String> label, String creator, IssueState issueState,
//      DateTime since) {
//    var path = '/repos/$owner/$repoName/issues';
//    var map = HashMap<String, dynamic>();
//    map['state'] = toState(issueState);
//    if (creator != null && creator != '') {
//      map['creator'] = creator;
//    }
//    if (label != null && label.isNotEmpty) {
//      map['label'] = label.join(',');
//    }
//    if (since == null) {
//      since = DateTime.now().subtract(Duration(days: 2));
//    }
//    map['since'] = since.toIso8601String();
//    return Request(path, map, Method.GET);
//  }
//
//  @override
//  Request createIssue(String title, String body, String label) {
//    var path = "/repos/$owner/$repoName/issues";
//    var map = Map<String, dynamic>();
//    map['title'] = title;
//    map['body'] = body;
//    map['labels'] = [label];
//    return Request(path, map, Method.POST);
//  }
//
//  @override
//  Request getIssue(int number) {
//    var path = "/repos/$owner/$repoName/issues/$number";
//    return Request(path, null, Method.GET);
//  }
//
//  @override
//  Request getComments(int number) {
//    var path = "/repos/$owner/$repoName/issues/$number/comments";
//    return Request(path, null, Method.GET);
//  }
//
//  @override
//  Request doAuthenticated(String token) {
//    return Request('/user', null, Method.GET,
//        header: {"Authorization": 'token $token'});
//  }
//}
