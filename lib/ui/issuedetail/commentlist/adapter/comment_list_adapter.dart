import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/git_comment.dart';
import 'package:gitbbs/network/github/model/GithubComment.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/adapter/comment_component.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/adapter/divide_component.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/state.dart';

const TYPE_COMMENT = 'TYPE_COMMENT';
const TYPE_DIVIDE = 'TYPE_DIVIDE';

class CommentListAdapter extends DynamicFlowAdapter<CommentListState> {
  CommentListAdapter()
      : super(
          pool: <String, Component<Object>>{
            TYPE_COMMENT: CommentComponent(),
            TYPE_DIVIDE: DivideComponent()
          },
          connector: _IssueConnector(),
        );
}

class _IssueConnector implements Connector<CommentListState, List<ItemBean>> {
  @override
  List<ItemBean> get(CommentListState state) {
    List<ItemBean> list = List();
    state.list.forEach((comment) {
      list.add(ItemBean(TYPE_COMMENT, comment));
      list.add(ItemBean(TYPE_DIVIDE, comment));
    });
    return list;
  }

  @override
  void set(CommentListState state, List<ItemBean> substate) {
    if (substate?.isNotEmpty == true) {
      List<GitComment> list = List();
      substate.forEach((item) {
        if (item.type == TYPE_COMMENT) {
          list.add(item.data);
        }
      });
      state.list = list;
    } else {
      state.list = <GitComment>[];
    }
  }
}
