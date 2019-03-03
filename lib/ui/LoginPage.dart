import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  var _formKey = new GlobalKey<FormState>();
  var username = '';
  var password = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(left: 40, top: 60, right: 40, bottom: 20),
      child: Column(
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/github.png',
              width: 100,
            ),
          ),
          Padding(padding: EdgeInsets.fromLTRB(0,10,0,10)),
          Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'GITHUB账号'),
                    onChanged: (username) {
                      this.username = username;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10), labelText: '登录密码'),
                    onChanged: (password) {
                      this.password = password;
                    },
                    obscureText: true,
                  )
                ],
              )),
          Padding(padding: EdgeInsets.fromLTRB(0,10,0,10)),
          Row(
            children: <Widget>[
              Expanded(
                  child: RaisedButton(
                onPressed: () {
                  print(username);
                  print(password);
                },
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('登录'),
              ))
            ],
          )
        ],
      ),
    );
  }
}
