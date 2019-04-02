import 'package:gitbbs/constant/GitConstant.dart';
import 'package:gitbbs/network/IssueState.dart';
import 'package:gitbbs/network/github/model/github_gist_file.dart';

import 'Request.dart';

abstract class GitNetworkRequestAdapter {
  final owner = data_repo_owner;
  final repoName = data_repo_name;

  String getApiUrl();

  Request getMoreIssues(List<String> label, String creator,
      IssueState issueState, String before, String after, int size);

  Request createIssue(String title, String body, List<String> label);

  Request deleteIssue(String issueId);

  Request getIssue(int number);

  Request getComments(int number, String before, int size);

  Request doAuthenticated(String token, String username);

  Request addComment(String issueId, String body);

  Request modifyComment(String commentId, String body);

  Request deleteComment(String commentId);

  Request getGists(String login);

  Request forkConfigGist();

  Request saveConfigGist(Map<String, GithubGistFile> map);

  Request starRepo(String owner, String repoName);

  Request getRepoFile(String path);

  Request getUserIssuesCount(String login);
}
