import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/cachemanager/edit_text_cache_manager.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/network/github/model/label_info.dart';
import 'package:gitbbs/ui/editissue/action.dart';
import 'package:gitbbs/ui/editissue/bean/edit_issue_info.dart';
import 'package:gitbbs/ui/editissue/state.dart';
import 'package:gitbbs/ui/widget/loading.dart';
import 'package:markdown_editor/markdown_editor.dart';

Effect<EditIssueState> buildEffect() {
  return combineEffects(<Object, Effect<EditIssueState>>{
    Lifecycle.initState: _init,
  });
}

void _init(Action action, Context<EditIssueState> ctx) async {
//  var dialog = LoadingDialog.show(ctx.context);
  var text = await EditTextCacheManager.get(ctx.state.getCacheKey());
  if (text?.isNotEmpty == true) {
    ctx.dispatch(EditIssueActionCreator.onUpdateInitTextAction(text));
  }
  var labelInfo = await GitHttpRequest.getInstance().getLabelsConfig();
  var tags = <String>[];
  for (Labels label in labelInfo.labels) {
    if (label?.id?.toLowerCase() == toIssueTypeName(ctx.state.issueType)) {
      for (var tag in labelInfo.tags) {
        if (tag.level <= label.level) {
          tags.add(tag.name);
        }
      }
      break;
    }
  }
//  dialog.dismiss();
  ctx.dispatch(EditIssueActionCreator.updateTagsAction(tags));
}
