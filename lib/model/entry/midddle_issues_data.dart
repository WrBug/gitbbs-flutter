import 'package:gitbbs/model/GitIssue.dart';

class MiddleIssuesData {
  GitIssue beforeIssue;
  GitIssue afterIssue;
  bool refreshing = false;
  MiddleIssuesData(this.beforeIssue, this.afterIssue,
      {this.refreshing = false});
}
