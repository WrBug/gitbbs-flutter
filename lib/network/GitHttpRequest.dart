import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/GitUser.dart';
import 'package:gitbbs/model/PagingData.dart';
import 'package:gitbbs/network/IssueState.dart';
import 'package:gitbbs/network/github/model/GithubComment.dart';
import 'package:gitbbs/network/github/model/GithubIssue.dart';

abstract class GitHttpRequest {
  Future<PagingData<GitIssue>> getIssues(
      {List<String> label, String creator, IssueState state, String after});

  Future<List<GithubComment>> getComments(int number);

  Future<GitIssue> getIssue(int number);

  Future<GitIssue> createIssue(String title, String body, String label);

  Future<GitUser> doAuthenticated(String token);

  Future<bool> signIn(String username, String password);
}
