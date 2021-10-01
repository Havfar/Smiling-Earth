import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/bloc/login/bloc/bloc_login_bloc.dart';
import 'package:smiling_earth_frontend/bloc/login/login/bloc/login_bloc.dart';
import 'package:smiling_earth_frontend/bloc/login/login/bloc/login_form.dart';
import 'package:smiling_earth_frontend/bloc/login/repository/user_repository.dart';

class LogInPage extends StatefulWidget {
  LogInPage({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogInPage> {
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

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  LoginPage({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login | Home Hub'),
      ),
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: LoginForm(),
      ),
    );
  }
}
