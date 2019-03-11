import 'dart:async';

import 'package:flutter/material.dart';

///  Action image button of markdown editor.
class ActionImage extends StatefulWidget {
  ActionImage({
    Key key,
    this.type,
    this.tap,
    this.imageSelect,
  }) : super(key: key);

  final ActionType type;
  final TapFinishCallback tap;
  final ImageSelectCallback imageSelect;

  @override
  ActionImageState createState() => ActionImageState();
}

class ActionImageState extends State<ActionImage> {
  String _getImagePath() {
    return _defaultImageAttributes
        .firstWhere((img) => img.type == widget.type)
        ?.path;
  }

  void _disposeAction() {
    var firstWhere =
        _defaultImageAttributes.firstWhere((img) => img.type == widget.type);
    if (widget.tap != null && firstWhere != null) {
      if (firstWhere.type == ActionType.image) {
        if (widget.imageSelect != null) {
          widget.imageSelect().then(
            (str) {
              print('Image select $str');
              if (str != null && str.isNotEmpty) {
                // 延迟执行它，现在不确定为什么没有执行成功
                // 它不是没有被执行，而是在[tap]方法中无法获取光标位置
                // 我怀疑跟界面切换有关，可能在选择图片后，[TextField]还未立即获得焦点。
                // 当然，这只是零时解决方案。
                Timer(const Duration(milliseconds: 1000), () {
                  widget.tap('![]($str)', 0);
                });
              }
            },
            onError: print,
          );
          return;
        }
      }
      widget.tap(firstWhere.text, firstWhere.positionReverse);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image(
        width: 30.0,
        height: 30.0,
        image: AssetImage(_getImagePath(), package: 'markdown_editor'),
      ),
      tooltip: _defaultImageAttributes
          .firstWhere((img) => img.type == widget.type)
          ?.tip,
      onPressed: _disposeAction,
    );
  }
}

const _defaultImageAttributes = <ImageAttributes>[
  ImageAttributes(
    type: ActionType.undo,
    path: 'images/undo_img.png',
    tip: '撤销',
  ),
  ImageAttributes(
    type: ActionType.redo,
    path: 'images/redo_img.png',
    tip: '恢复',
  ),
  ImageAttributes(
    type: ActionType.image,
    path: 'images/edit_img.png',
    text: '![]()',
    tip: '图片',
    positionReverse: 3,
  ),
  ImageAttributes(
    type: ActionType.link,
    path: 'images/link_img.png',
    text: '[]()',
    tip: '链接',
    positionReverse: 3,
  ),
  ImageAttributes(
    type: ActionType.fontBold,
    path: 'images/format_bold_img.png',
    text: '****',
    tip: '加粗',
    positionReverse: 2,
  ),
  ImageAttributes(
    type: ActionType.fontItalic,
    path: 'images/format_italic_img.png',
    text: '**',
    tip: '斜体',
    positionReverse: 1,
  ),
//  ImageAttributes(
//    type: ActionType.fontDeleteLine,
//    path: 'images/strikethrough_img.png',
//    text: '~~~~',
//    tip: '删除线',
//    positionReverse: 2,
//  ),
  ImageAttributes(
    type: ActionType.textQuote,
    path: 'images/format_quote_img.png',
    text: '\n>',
    tip: '文字引用',
    positionReverse: 0,
  ),
  ImageAttributes(
    type: ActionType.list,
    path: 'images/list_img.png',
    text: '\n- ',
    tip: '无序列表',
    positionReverse: 0,
  ),
  ImageAttributes(
    type: ActionType.h4,
    path: 'images/format_header_4_img.png',
    text: '\n#### ',
    tip: '四级标题',
    positionReverse: 0,
  ),
  ImageAttributes(
    type: ActionType.h5,
    path: 'images/format_header_5_img.png',
    text: '\n##### ',
    tip: '五级标题',
    positionReverse: 0,
  ),
  ImageAttributes(
    type: ActionType.h1,
    path: 'images/format_header_1_img.png',
    text: '\n# ',
    tip: '一级标题',
    positionReverse: 0,
  ),
  ImageAttributes(
    type: ActionType.h2,
    path: 'images/format_header_2_img.png',
    text: '\n## ',
    tip: '二级标题',
    positionReverse: 0,
  ),
  ImageAttributes(
    type: ActionType.h3,
    path: 'images/format_header_3_img.png',
    text: '\n### ',
    tip: '三级标题',
    positionReverse: 0,
  ),
];

enum ActionType {
  undo,
  redo,
  image,
  link,
  fontBold,
  fontItalic,
  fontDeleteLine,
  textQuote,
  list,
  h1,
  h2,
  h3,
  h4,
  h5,
}

class ImageAttributes {
  const ImageAttributes({
    this.tip = '',
    this.text,
    this.positionReverse,
    @required this.type,
    @required this.path,
  })  : assert(path != null),
        assert(type != null);

  final ActionType type;
  final String path;
  final String tip;
  final String text;
  final int positionReverse;
}

/// Call this method after clicking the [ActionImage] and completing a series of actions.
/// [text] Adding text.
/// [position] Cursor position that reverse order.
typedef TapFinishCallback(String text, int positionReverse);

/// Call this method after clicking the ImageAction.
/// return your select image path.
typedef Future<String> ImageSelectCallback();

