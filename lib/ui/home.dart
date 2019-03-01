import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  var size = 100;

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Text("$index");
          },
          itemCount: widget.size,
        ),
        onRefresh: () async {
          setState(() {
            widget.size += 10;
          });
        });
  }
}
