import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/ui/favoritelist/adapter/favorite_component.dart';
import 'package:gitbbs/ui/favoritelist/state.dart';
import 'package:gitbbs/ui/issuedetail/commentlist/adapter/divide_component.dart';

const TYPE_ISSUE = 'TYPE_ISSUE';
const TYPE_DIVIDE = 'TYPE_DIVIDE';

class FavoriteListAdapter extends DynamicFlowAdapter<FavoriteListState> {
  FavoriteListAdapter()
      : super(
          pool: <String, Component<Object>>{
            TYPE_ISSUE: FavoriteComponent(),
            TYPE_DIVIDE: DivideComponent()
          },
          connector: _IssueConnector(),
        );
}

class _IssueConnector implements Connector<FavoriteListState, List<ItemBean>> {
  @override
  List<ItemBean> get(FavoriteListState state) {
    List<ItemBean> list = List();
    state.list.forEach((comment) {
      list.add(ItemBean(TYPE_ISSUE, comment));
      list.add(ItemBean(TYPE_DIVIDE, comment));
    });
    return list;
  }

  @override
  void set(FavoriteListState state, List<ItemBean> substate) {
    if (substate?.isNotEmpty == true) {
      List<GitIssue> list = List();
      substate.forEach((item) {
        if (item.type == TYPE_ISSUE) {
          list.add(item.data);
        }
      });
      state.list = list;
    } else {
      state.list = <GitIssue>[];
    }
  }
}
