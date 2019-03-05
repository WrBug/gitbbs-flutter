import 'package:gitbbs/constant/GitConstant.dart';

import 'Request.dart';

abstract class GitNetworkRequestAdapter {
  final owner = REPO_OWNER;
  var assignees = REPO_ASSIGNEES;
  final repoName = REPO_NAME;

  String getApiUrl();

  Request createIssue(String title, String body, String label);

  Request getIssue(int number);

  Request getComments(int number);

  Request doAuthenticated(String token);
}
