import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/ui/userissues/state.dart';
import 'package:gitbbs/ui/widget/issue_item_component/component.dart';
import 'package:gitbbs/ui/widget/issue_item_component/divide_component.dart';
import 'package:gitbbs/ui/widget/issue_item_component/header_component.dart';

const TYPE_HEADER = 'header';
const TYPE_ISSUE = 'issue';
const TYPE_DIVIDE = 'divide';
const TYPE_CLICK_TO_LOAD_MIDDLE = 'loadMiddle';

class UserIssueListAdapter extends DynamicFlowAdapter<UserIssuesPageState> {
  UserIssueListAdapter()
      : super(
          pool: <String, Component<Object>>{
            TYPE_ISSUE: IssueComponent(),
            TYPE_DIVIDE: DivideComponent(),
            TYPE_HEADER: HeaderComponent(),
          },
          connector: _IssueConnector(),
        );
}

class _IssueConnector
    implements Connector<UserIssuesPageState, List<ItemBean>> {
  @override
  List<ItemBean> get(UserIssuesPageState state) {
    if (state.list?.isNotEmpty == true) {
      List<ItemBean> list = List();
      state.list.forEach((issue) {
        list.add(ItemBean(TYPE_DIVIDE, null));
        list.add(ItemBean(TYPE_ISSUE, issue));
      });
      list.removeAt(0);
      list.insert(0, ItemBean(TYPE_HEADER, null));
      return list;
    } else {
      return <ItemBean>[];
    }
  }

  @override
  void set(UserIssuesPageState state, List<ItemBean> substate) {
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
