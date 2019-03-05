import 'package:gitbbs/model/GitUser.dart';
import 'package:gitbbs/network/github/model/GithubComment.dart';
import 'package:gitbbs/network/github/model/GithubIssue.dart';

abstract class GitHttpRequest {
  Future<List<GithubComment>> getComments(int number);

  Future<GithubIssue> getIssue(int number);

  Future<GithubIssue> createIssue(String title, String body, String label);

  Future<GitUser> doAuthenticated(String token);

  Future<bool> signIn(String username, String password);
}
