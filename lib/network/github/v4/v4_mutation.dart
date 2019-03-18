import 'package:gitbbs/network/github/v4/v4_query.dart';

String deleteIssueMutation(String issueId) {
  return '''
  mutation {
  deleteIssue(input:{issueId:"$issueId"}){
      clientMutationId
    }
  }
  '''
      .replaceAll("\t", " ")
      .replaceAll(RegExp(r' +'), ' ');
}



String getAddCommentMutation(String issueId, String body) {
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

String getModifyCommentMutation(String commentId, String body) {
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

String getDeleteCommentMutation(String commentId) {
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