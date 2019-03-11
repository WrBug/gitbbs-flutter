import 'package:gitbbs/constant/GitConstant.dart';
import 'package:gitbbs/network/IssueState.dart';

import 'Request.dart';

abstract class GitNetworkRequestAdapter {
  final owner = REPO_OWNER;
  final repoName = REPO_NAME;

  String getApiUrl();



  Request getMoreIssues(List<String> label, String creator,
      IssueState issueState, String before, String after, int size);

  Request createIssue(String title, String body, String label);

  Request getIssue(int number);

  Request getComments(int number,String before,int size);

  Request doAuthenticated(String token);
}
