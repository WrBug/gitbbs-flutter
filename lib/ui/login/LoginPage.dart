import 'package:flutter/material.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/network/github/GithubHttpRequest.dart';

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPageContent(),
    );
  }

}

class LoginPageContent extends StatefulWidget {
  final GitHttpRequest request = GithubHttpRequest.getInstance();

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPageContent> {
  var _formKey = new GlobalKey<FormState>();
  var username = '';
  var password = '';
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 40, top: 60, right: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/github.png',
                width: 100,
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'GITHUB用户名'),
                      onChanged: (username) {
                        this.username = username;
                      },
                      controller: usernameController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelText: '登录密码'),
                      onChanged: (password) {
                        this.password = password;
                      },
                      controller: passwordController,
                      obscureText: true,
                    )
                  ],
                )),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
            Row(
              children: <Widget>[
                Expanded(
                    child: RaisedButton(
                  onPressed: () {
                    if (usernameController.text == '') {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('GITHUB用户名不得为空')));
                      return;
                    }
                    if (passwordController.text == '') {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('GITHUB密码不得为空')));
                      return;
                    }
                    widget.request.signIn(username, password,
                        (success, result) {
                      print('登录状态：' + success.toString() + ":" + result);
                    });
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text('登录'),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
