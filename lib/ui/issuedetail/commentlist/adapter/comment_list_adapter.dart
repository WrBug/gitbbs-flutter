import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/network/github/model/GithubComment.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/adapter/comment_component.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/state.dart';

const TYPE_COMMENT = 'TYPE_COMMENT';

class CommentListAdapter extends DynamicFlowAdapter<CommentListState> {
  CommentListAdapter()
      : super(
          pool: <String, Component<Object>>{TYPE_COMMENT: CommentComponent()},
          connector: _IssueConnector(),
        );
}

class _IssueConnector implements Connector<CommentListState, List<ItemBean>> {
  @override
  List<ItemBean> get(CommentListState state) {
    return state.list.map<ItemBean>((comment) {
      return ItemBean(TYPE_COMMENT, comment);
    }).toList();
  }

  @override
  void set(CommentListState state, List<ItemBean> substate) {
    if (substate?.isNotEmpty == true) {
      List<GithubComment> list = List();
      substate.forEach((item) {
        if (item.type == TYPE_COMMENT) {
          list.add(item.data);
        }
      });
      state.list = list;
    } else {
      state.list = <GithubComment>[];
    }
  }
}
