import 'package:flutter/material.dart';
import 'package:gitbbs/ui/login/LoginPage.dart';
import 'package:gitbbs/ui/main/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    BottomNavigationBarItem(
        icon: Icon(Icons.question_answer), title: Text("问答")),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), title: Text("收藏")),
    BottomNavigationBarItem(icon: Icon(Icons.face), title: Text("我的"))
  ];
  final bodies = [HomePage(), Text("2"), Text("3"), Text('')];

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
