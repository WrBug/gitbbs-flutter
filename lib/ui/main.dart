import 'package:flutter/material.dart';
import 'home.dart';
import 'package:gitbbs/network/github/GithubHttpRequest.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Gitbbs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var index = 0;
  final items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("主页")),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), title: Text("收藏")),
    BottomNavigationBarItem(icon: Icon(Icons.people), title: Text("我的"))
  ];
  final bodies = [HomePage(), Text("2"), Text("3")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        onTap: (index) {
          setState(() {
            this.index = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
      ),
      body: bodies[index],
    );
  }
}
