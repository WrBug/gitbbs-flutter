import 'Request.dart';

abstract class GitNetworkRequestAdapter {
  final owner="wrbug";
  var assignees = "wrbug";

  final repoName = "gitbbstest";

  String getApiUrl();

  Request createIssue(String title, String body, String label);

  Request getIssue(int number);


  Request getComments(int number);

}
