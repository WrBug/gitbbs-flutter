import 'package:gitbbs/constant/GitConstant.dart';
import 'package:gitbbs/network/IssueState.dart';

String getIssuesQuery(IssueState issueState, int size,
    {List<String> label, String creator, String before, String after}) {
  String labels =
      label == null || label.isEmpty ? "null" : '["' + label.join('","') + '"]';
  String states = '[OPEN,CLOSED]';
  if (issueState == IssueState.OPEN) {
    states = '[OPEN]';
  } else if (issueState == IssueState.CLOSED) {
    states = '[CLOSED]';
  }
  String beforeStr = 'null';
  if (before != null && before != '') {
    beforeStr = '"$before"';
  }
  String afterStr = 'null';
  if (after != null && after != '') {
    afterStr = '"$after"';
  }
  return """
          {
      repository(owner: "$REPO_OWNER", name: "$REPO_NAME") {
        issues(first: $size,labels:$labels, states: $states,orderBy:{field: CREATED_AT, direction: DESC},before:$beforeStr,after:$afterStr) {
          edges {
            cursor
            node {
              ${_getIssueContent()}
            }
          }
        }
      }
    }
    """
      .replaceAll("\t", " ")
      .replaceAll('\n', ' ')
      .replaceAll(RegExp(r' +'), ' ');
}

String getIssueQuery(int number) {
  return '''
    {
  repository(owner: "$REPO_OWNER", name: "$REPO_NAME") {
    issue(number:$number){
        ${_getIssueContent(fields: ['body', 'bodyText'])}
    }
  }
}

    '''
      .replaceAll("\t", " ")
      .replaceAll('\n', ' ')
      .replaceAll(RegExp(r' +'), ' ');
}

String _getIssueContent({List<String> fields}) {
  return '''
    title
    publishedAt
    updatedAt
    id
    number
    closed
    ${fields == null ? "" : fields.join('\n')}
    closedAt
    locked
    author{
      login
      avatarUrl
    }
    comments{
      totalCount
    }
    labels(first:100) {
      edges {
        node {
          name
          id
          url
          color
          isDefault
        }
      }
    }
    ''';
}

String getCommentsQuery(int number, String before, int size) {
  String cursor = 'null';
  if (before != null && before != '') {
    cursor = '"$before"';
  }
  return '''
{
  repository(owner: "$REPO_OWNER", name: "$REPO_NAME") {
    issue(number:$number){
      comments(last:$size,before:$cursor){
        edges{
          ${getCommentEdge()}
        }
      }
    }
  }
}

'''
      .replaceAll("\t", " ")
      .replaceAll('\n', ' ')
      .replaceAll(RegExp(r' +'), ' ');
}

String getCommentEdge() {
  return '''
            cursor
          node{
            author{
              avatarUrl
              login
            }
            authorAssociation
            id
            url
            createdAt
            lastEditedAt
            body
            viewerCanUpdate
            viewerCanDelete
            viewerDidAuthor
          }
  ''';
}

String getAddCommentQuery(String issueId, String body) {
  return '''
  mutation {
  addComment(input:{subjectId:"$issueId",body:"$body"}){
      commentEdge{
           ${getCommentEdge()}
      }
    }
  }
  '''
      .replaceAll("\t", " ")
      .replaceAll(RegExp(r' +'), ' ');
}

String getModifyCommentQuery(String commentId, String body) {
  return '''
  mutation {
  updateIssueComment(input:{id:"$commentId",body:"$body"}){
      clientMutationId
    }
  }
  '''
      .replaceAll("\t", " ")
      .replaceAll(RegExp(r' +'), ' ');
}

String getDeleteCommentQuery(String commentId) {
  return '''
  mutation {
  deleteIssueComment(input:{id:"$commentId"}){
      commentEdge{
           clientMutationId
      }
    }
  }
  '''
      .replaceAll("\t", " ")
      .replaceAll(RegExp(r' +'), ' ');
}

String getUserQuery(String username) {
  return '''
  {
  user(login:"$username"){
    id
    url
    avatarUrl
    url
    isSiteAdmin
    name
    company
    websiteUrl
    location
    email
    bio
    gists(first:100,){
  nodes{
    isPublic
    name
    description
    isFork
    files{
      name
      text
    }
  }
}
  }
}

  '''
      .replaceAll("\t", " ")
      .replaceAll(RegExp(r' +'), ' ');
}

String getGistsQuery(String login) {
  return '''
    {
    user(login:"$login"){
      gists(first:100,){
        nodes{
          isPublic
          name
          description
          isFork
          files{
            name
            text
          }
        }
      }
    }
  }
  '''
      .replaceAll("\t", " ")
      .replaceAll(RegExp(r' +'), ' ');
}
