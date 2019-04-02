import 'package:flutter/material.dart';

class LoadingView extends StatefulWidget {
  final text;

  LoadingView({this.text = '请稍后'});

  @override
  State<StatefulWidget> createState() => _LoadingView();
}

class _LoadingView extends State<LoadingView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircularProgressIndicator(),
        Padding(
          padding: EdgeInsets.all(10),
        ),
        Text(widget.text)
      ],
    );
  }
}
