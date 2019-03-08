import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';

class PageState extends Cloneable<PageState> {
  List<GitIssue> list = List();
  bool hasNext = false;
  List<GitIssue> progressingList = List();

  @override
  PageState clone() {
    return PageState()
      ..list = List.of(list)
      ..progressingList = List.of(progressingList)
      ..hasNext = hasNext;
  }
}

PageState initState(Map<String, dynamic> args) {
  return PageState();
}
