import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  var size = 100;

  @override
  State<StatefulWidget> createState() => _HomeTab();
}

class _HomeTab extends State<HomeTab> {
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
