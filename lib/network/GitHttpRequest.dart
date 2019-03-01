import 'github/model/GithubComment.dart';

abstract class GitHttpRequest {
  getComments(int number, Function callback);

  getIssue(int number, Function callback);

  createIssue(String title, String body, String label, Function callback);
}
