import 'package:gitbbs/model/GitIssue.dart';

class EditIssueInfo {
  GitIssue issue;
  IssueType issueType;
  IssueEditType editType;

  EditIssueInfo(
    this.issueType,
    this.editType,
    this.issue,
  );
}

enum IssueType { article, question }

String toIssueTypeName(IssueType type) {
  switch (type) {
    case IssueType.article:
      {
        return 'article';
      }
    case IssueType.question:
      {
        return 'question';
      }
  }
  return '';
}

enum IssueEditType { add, modify }
