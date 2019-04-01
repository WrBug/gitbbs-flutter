import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/git_content_file.dart';
import 'package:gitbbs/network/github/model/github_message.dart';
import 'package:gitbbs/ui/messagecenter/messagelist/component/component.dart';
import 'package:gitbbs/ui/messagecenter/messagelist/state.dart';
import 'package:gitbbs/ui/messagecenter/messagelist/component/divide_component.dart';

const TYPE_CONTENT = 'content';
const TYPE_DIVIDE = 'divide';

class MessageListAdapter extends DynamicFlowAdapter<MessageListPageState> {
  MessageListAdapter()
      : super(
          pool: <String, Component<Object>>{
            TYPE_CONTENT: MessageComponent(),
            TYPE_DIVIDE: DivideComponent(),
          },
          connector: _IssueConnector(),
        );
}

class _IssueConnector
    implements Connector<MessageListPageState, List<ItemBean>> {
  @override
  List<ItemBean> get(MessageListPageState state) {
    if (state.list?.isNotEmpty == true) {
      List<ItemBean> list = List();
      state.list.forEach((issue) {
        list.add(ItemBean(TYPE_DIVIDE, null));
        list.add(ItemBean(TYPE_CONTENT, issue));
      });
      list.removeAt(0);
      return list;
    } else {
      return <ItemBean>[];
    }
  }

  @override
  void set(MessageListPageState state, List<ItemBean> substate) {
    if (substate?.isNotEmpty == true) {
      List<GithubMessage> list = List();
      substate.forEach((item) {
        if (item.type == TYPE_CONTENT) {
          list.add(item.data);
        }
      });
      state.list = list;
    } else {
      state.list = <GithubMessage>[];
    }
  }
}
