import 'package:flutter/material.dart';
import 'package:gitbbs/model/GitIssue.dart';

class CommentListData{
  GitIssue issue;
  GlobalKey<ScaffoldState> scaffoldKey;

  CommentListData(this.issue, this.scaffoldKey);

}