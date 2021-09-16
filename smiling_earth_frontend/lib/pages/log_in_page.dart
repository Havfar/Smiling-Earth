import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  LogInPage({Key? key}) : super(key: key);

  @override
  _logInState createState() => _logInState();
}

class _logInState extends State<LogInPage> {
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.only(top: 200),
          padding: EdgeInsets.all(20),
          child: Column(children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 40),
                child: Text(
                  "Log In",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                )),
            Expanded(
                child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.length < 6) {
                  return 'Enter at least 6 characters';
                } else {
                  return null;
                }
              },
              onSaved: (value) => setState(() => username = value!),
            )),
            Expanded(
                child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                hintText: 'Enter your password',
              ),
              validator: (value) {
                if (value!.length < 6) {
                  return 'Enter at least 6 characters';
                } else {
                  return null;
                }
              },
              onSaved: (value) => setState(() => password = value!),
            )),
            ElevatedButton(
                onPressed: () => print("login"), child: Text("Log in"))
          ])),
    );
  }
}
