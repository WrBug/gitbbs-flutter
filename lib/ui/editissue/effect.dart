import 'package:fish_redux/fish_redux.dart';
import 'package:gitbbs/model/cachemanager/edit_text_cache_manager.dart';
import 'package:gitbbs/model/event/refresh_list_event.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/network/github/model/label_info.dart';
import 'package:gitbbs/ui/editissue/action.dart';
import 'package:gitbbs/ui/editissue/bean/edit_issue_info.dart';
import 'package:gitbbs/ui/editissue/state.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/ui/login/login.dart';
import 'package:gitbbs/ui/widget/loading.dart';
import 'package:gitbbs/ui/widget/selectable_tags.dart';
import 'package:gitbbs/util/disk_lru_cache.dart';
import 'package:gitbbs/util/event_bus_helper.dart';
import 'dart:convert';

Effect<EditIssueState> buildEffect() {
  return combineEffects(<Object, Effect<EditIssueState>>{
    Lifecycle.initState: _init,
    EditIssueAction.saveIssue: _saveIssue,
    EditIssueAction.submitIssue: _submitIssue
  });
}

void _init(Action action, Context<EditIssueState> ctx) async {
//  var dialog = LoadingDialog.show(ctx.context);

  var text = await EditTextCacheManager.get(ctx.state.getCacheKey());
  if (text?.isNotEmpty == true) {
    ctx.dispatch(EditIssueActionCreator.onUpdateInitTextAction(text));
  }
  var json = await DiskLruCache.getDefault().get("labelInfo");
  LabelInfo labelInfo;
  if (json?.isNotEmpty == true) {
    labelInfo = LabelInfo.fromJson(jsonDecode(json));
    _showLabel(labelInfo, ctx);
  }
  labelInfo = await GitHttpRequest.getInstance().getLabelsConfig();
  _showLabel(labelInfo, ctx);
  DiskLruCache.getDefault().put("labelInfo", jsonEncode(labelInfo));
}

void _showLabel(LabelInfo labelInfo, Context<EditIssueState> ctx) {
  var tags = <Tag>[];
  var existTags = <String>[];
  var map = Map<String, Tag>();
  if (ctx.state.issue?.labels != null) {
    for (var label in ctx.state.issue.labels) {
      existTags.add(label.name);
      var tag = Tag(title: label.name, active: true);
      tags.add(tag);
      map[tag.title] = tag;
    }
  }
  for (Labels label in labelInfo.labels) {
    if (label?.id?.toLowerCase() == toIssueTypeName(ctx.state.issueType)) {
      for (var tag in labelInfo.tags) {
        if ((tag.level <= label.level) && (!existTags.contains(tag.name))) {
          var tag1 = Tag(title: tag.name, active: false);
          tags.add(tag1);
          map[tag1.title] = tag1;
        }
      }
      break;
    }
  }
  if (ctx.state.tags?.isNotEmpty == true) {
    for (var tag in ctx.state.tags) {
      if (map.containsKey(tag.title)) {
        map[tag.title].active = tag.active;
      }
    }
  }
  ctx.dispatch(EditIssueActionCreator.updateTagsAction(tags));
}

void _saveIssue(Action action, Context<EditIssueState> ctx) async {
  var title = ctx.state.titleController.text;
  if (title == '') {
    ctx.state.scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text('标题不得为空')));
    return;
  }
  var content = ctx.state.mdKey.currentState.getMarkDownText().text;
  if (content == '') {
    ctx.state.scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text('内容不得为空')));
    return;
  }
  showDialog(
      context: ctx.context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('提示'),
          content: Text('是否发布文章？'),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('取消')),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ctx.dispatch(EditIssueActionCreator.submitIssueAction());
                },
                child: Text('确定')),
          ],
        );
      });
}

void _submitIssue(Action action, Context<EditIssueState> ctx) async {
  var dialog = LoadingDialog.show(ctx.context);
  var title = ctx.state.titleController.text;
  var content = ctx.state.mdKey.currentState.getMarkDownText().text;
  var labels = ctx.state.tags
      .where((tag) => tag.active)
      .map((tag) => tag.title)
      .toList();
  bool success =
      await GitHttpRequest.getInstance().createIssue(title, content, labels);
  dialog.dismiss();
  if (success) {
    Navigator.of(ctx.context).pop();
    EventBusHelper.fire(RefreshIssueEvent());
    return;
  }
  ctx.state.scaffoldKey.currentState
      .showSnackBar(SnackBar(content: Text('发布失败，请重试')));
}
