import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoadingDialog extends Dialog {
  String text;

  LoadingDialog(this.context, {Key key, @required this.text}) : super(key: key);
  bool showing = false;
  BuildContext context;

  dismiss() {
    if (showing) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: new Center(
        //保证控件居中效果
        child: new SizedBox(
          width: 120.0,
          height: 120.0,
          child: new Container(
            decoration: ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new CircularProgressIndicator(
                  strokeWidth: 3,
                ),
                new Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: new Text(
                    text,
                    style: new TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static LoadingDialog show(BuildContext context, {String text = '请稍后'}) {
    var dialog = LoadingDialog(context, text: text);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          dialog.showing = true;
          return dialog;
        }).whenComplete(() {
      dialog.showing = false;
    });
    return dialog;
  }
}

Widget getLoadingView() {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Column(
      children: <Widget>[
        CircularProgressIndicator(),
        Padding(
          padding: EdgeInsets.all(10),
        ),
        Text('正在获取数据')
      ],
    ),
  );
}
