import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  static final route = "log-in-page";

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: "Email",
        contentPadding: EdgeInsets.all(16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),  
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      style: TextStyle(color: Colors.black, fontSize: 18.0),
      decoration: InputDecoration(
        hintText: "Password",
        contentPadding: EdgeInsets.all(16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text("Log In")),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              email,
              SizedBox(height: 8.0),
              password
            ],
          ),
        ),
      );
  }
}