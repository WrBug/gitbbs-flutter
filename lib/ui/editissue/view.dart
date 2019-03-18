import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/model/cachemanager/edit_text_cache_manager.dart';
import 'package:gitbbs/network/image_helper.dart';
import 'package:gitbbs/ui/editissue/action.dart';
import 'package:gitbbs/ui/editissue/bean/edit_issue_info.dart';
import 'package:gitbbs/ui/editissue/state.dart';
import 'package:gitbbs/ui/markdownhelp/markdown_help_page.dart';
import 'package:gitbbs/ui/widget/selectable_tags.dart';
import 'package:markdown_editor/markdown_editor.dart';

Widget buildView(
    EditIssueState state, Dispatch dispatch, ViewService viewService) {
  var titlePrefix = state.editType == IssueEditType.add ? '新建' : '编辑';
  var title =
      titlePrefix + (state.issueType == IssueType.article ? '文章' : '提问');
  return Scaffold(
    key: state.scaffoldKey,
    appBar: AppBar(
      title: Text(title),
      actions: _actionsBuild(state, dispatch, viewService),
    ),
    body: _bodyBuild(state, dispatch, viewService),
  );
}

_actionsBuild(
    EditIssueState state, Dispatch dispatch, ViewService viewService) {
  return <Widget>[
    Center(
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Text(state.getCurrentPage() == PageType.editor ? '预览' : '编辑',
              style: TextStyle(fontSize: 16)),
        ),
        onTap: () {
          dispatch(EditIssueActionCreator.togglePageTypeAction());
        },
      ),
    ),
    Center(
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Text(
            '提交',
            style: TextStyle(fontSize: 16),
          ),
        ),
        onTap: () {
          dispatch(EditIssueActionCreator.saveIssueAction());
        },
      ),
    ),
    Center(
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Text('帮助', style: TextStyle(fontSize: 16)),
        ),
        onTap: () {
          Navigator.of(viewService.context).push(
              MaterialPageRoute(builder: (context) => MarkdownHelpPage()));
        },
      ),
    ),
  ];
}

Widget _bodyBuild(
    EditIssueState state, Dispatch dispatch, ViewService viewService) {
  return Container(
      child: Padding(
    padding: EdgeInsets.all(10),
    child: _contentBuild(state, dispatch, viewService),
  ));
}

_contentBuild(
    EditIssueState state, Dispatch dispatch, ViewService viewService) {
  return MarkdownEditor(
    key: state.mdKey,
    header: <Widget>[
      TextField(
        controller: state.titleController,
        maxLength: 32,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10), labelText: '标题'),
      ),
      _labelBuild(state, dispatch, viewService),
    ],
    tabChange: (type) {
//      dispatch(EditCommentActionCreator.pageTypeChangedAction());
    },
    imageSelect: () async =>
        await ImageHelper.pickAndUpload(viewService.context),
    textChange: () {
      EditTextCacheManager.save(
          state.getCacheKey(), state.mdKey.currentState.getMarkDownText().text);
    },
    initText: state?.initText?.isNotEmpty == true
        ? state.initText
        : state.editType == IssueEditType.modify ? state.issue.body ?? "" : "",
    padding: const EdgeInsets.all(10),
  );
}

Widget _labelBuild(
    EditIssueState state, Dispatch dispatch, ViewService viewService) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
        Text(
          '标签（可选）',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
        SelectableTags(
          tags: state.tags,
          color: Color.fromARGB(0xff, 0xee, 0xee, 0xee),
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          alignment: MainAxisAlignment.start,
          borderRadius: BorderRadius.circular(3),
          borderSide: BorderSide(color: Colors.transparent, width: 0),
          textColor: Colors.black54,
          backgroundContainer: Colors.transparent,
          activeColor: Theme.of(viewService.context).primaryColor,
          textActiveColor: Colors.white,
          onPressed: (tag) {
            print(tag);
          },
        ),
        Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
        Text(
          '内容',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
      ]);
}
