import 'package:flutter/material.dart';
import 'package:markdown_editor/action.dart';
import 'package:markdown_editor/edit_perform.dart';

class MdEditor extends StatefulWidget {
  MdEditor(
      {Key key,
      this.titleStyle,
      this.padding = const EdgeInsets.all(0.0),
      this.initTitle,
      this.initText,
      this.hintTitle,
      this.hintText,
      this.imageSelect,
      this.textChange,
      this.header})
      : super(key: key);

  final TextStyle titleStyle;
  final EdgeInsetsGeometry padding;
  final String initTitle;
  final String initText;
  final String hintTitle;
  final String hintText;
  final List<Widget> header;

  /// see [ImageSelectCallback]
  final ImageSelectCallback imageSelect;

  final VoidCallback textChange;

  @override
  State<StatefulWidget> createState() => MdEditorState();
}

class MdEditorState extends State<MdEditor> {
  final _titleEditingController = TextEditingController(text: '');
  final _textEditingController = TextEditingController(text: '');
  var _editPerform;
  var _maxLines = 7;

  String getTitle() {
    return _titleEditingController.value.text;
  }

  String getText() {
    return _textEditingController.value.text;
  }

  void setText(String newText) {
    _textEditingController.text = newText;
  }

  @override
  void initState() {
    super.initState();
    if (widget.initText != null && widget.initText.isNotEmpty) _maxLines = null;
    _titleEditingController.text = widget.initTitle ?? '';
    _textEditingController.text = widget.initText ?? '';

    _editPerform = EditPerform(
      _textEditingController,
      initText: _textEditingController.text,
    );
  }

  void _disposeText(String text, int index) {
    if (_textEditingController.selection.base.offset < 0) {
      print(
          'WRAN: The value is ${_textEditingController.selection.base.offset}');
      return;
    }
    var startText = _textEditingController.text
        .substring(0, _textEditingController.selection.base.offset);
    var endText = _textEditingController.text
        .substring(_textEditingController.selection.base.offset);

    var str = startText + text + endText;
    _textEditingController.value = TextEditingValue(
        text: str,
        selection: TextSelection.collapsed(
            offset: startText.length + text.length - index));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: widget.padding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildContent(),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            child: Ink(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black54
                    : Color(0xFFF0F0F0),
                boxShadow: [
                  BoxShadow(color: const Color(0xAAF0F0F0)),
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    ActionImage(
                      type: ActionType.undo,
                      tap: (s, i) {
                        _editPerform.undo();
                      },
                    ),
                    ActionImage(
                      type: ActionType.redo,
                      tap: (s, i) {
                        _editPerform.redo();
                      },
                    ),
                    ActionImage(
                      type: ActionType.image,
                      tap: _disposeText,
                      imageSelect: widget.imageSelect,
                    ),
                    ActionImage(
                      type: ActionType.link,
                      tap: _disposeText,
                    ),
                    ActionImage(
                      type: ActionType.fontBold,
                      tap: _disposeText,
                    ),
                    ActionImage(
                      type: ActionType.fontItalic,
                      tap: _disposeText,
                    ),
                    ActionImage(
                      type: ActionType.textQuote,
                      tap: _disposeText,
                    ),
                    ActionImage(
                      type: ActionType.h4,
                      tap: _disposeText,
                    ),
                    ActionImage(
                      type: ActionType.h5,
                      tap: _disposeText,
                    ),
                    ActionImage(
                      type: ActionType.h1,
                      tap: _disposeText,
                    ),
                    ActionImage(
                      type: ActionType.h2,
                      tap: _disposeText,
                    ),
                    ActionImage(
                      type: ActionType.h3,
                      tap: _disposeText,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildContent() {
    List<Widget> content = [];
    if (widget.header != null) {
      content.addAll(widget.header);
    }
    content.add(TextField(
      maxLines: _maxLines,
      controller: _textEditingController,
      onChanged: (text) {
        _editPerform.change(text);
        if (_maxLines != null && text != null && text.length > _maxLines) {
          setState(() {
            _maxLines = null;
          });
        }

        if (widget.textChange != null) widget.textChange();
      },
      decoration: InputDecoration(
        hintText: widget.hintText ?? '请输入内容，支持markdown，左滑可以预览',
        border: InputBorder.none,
      ),
    ));
    return content;
  }
}
