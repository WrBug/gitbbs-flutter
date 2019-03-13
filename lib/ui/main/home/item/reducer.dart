import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/event/comments_count_changed_event.dart';

Reducer<GitIssue> buildReducer() {
  return asReducer(<Object, Reducer<GitIssue>>{
  });
}


