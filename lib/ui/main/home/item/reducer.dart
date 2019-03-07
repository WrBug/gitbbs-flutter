import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/ui/main/home/inner_action.dart';
import 'package:gitbbs/ui/main/home/page_state.dart';

Reducer<GitIssue> buildReducer() {
  return asReducer(<Object, Reducer<GitIssue>>{
  });
}


