import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';

class PageState extends Cloneable<PageState> {
  List<GitIssue> list = List();
  bool hasNext = false;

  @override
  PageState clone() {
    return PageState()
      ..list = List.of(list)
      ..hasNext = hasNext;
  }
}

PageState initState(Map<String, dynamic> args) {
  return PageState();
}
