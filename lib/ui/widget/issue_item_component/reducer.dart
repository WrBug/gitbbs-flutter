import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';

Reducer<GitIssue> buildReducer() {
  return asReducer(<Object, Reducer<GitIssue>>{
  });
}


