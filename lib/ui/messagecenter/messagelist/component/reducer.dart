import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/git_content_file.dart';
import 'package:gitbbs/network/github/model/github_message.dart';

Reducer<GithubMessage> buildReducer() {
  return asReducer(<Object, Reducer<GithubMessage>>{
  });
}


