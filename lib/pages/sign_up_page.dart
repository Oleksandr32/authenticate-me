import 'package:flutter/material.dart';

import 'package:authenticate_me/pages/log_in_page.dart';

class SignUpPage extends StatefulWidget {
  static final route = "sign-up-page";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final title = Text(
      "Register Form",
      style: TextStyle(fontSize: 36.0),
    );

    final userName = TextFormField(
      autofocus: false,
      decoration: InputDecoration(
        hintText: "User Name",
        contentPadding: EdgeInsets.all(16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),  
      ),
    );

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

    final confirmPassword = TextFormField(
      autofocus: false,
      obscureText: true,
      style: TextStyle(color: Colors.black, fontSize: 18.0),
      decoration: InputDecoration(
        hintText: "Confirm password",
        contentPadding: EdgeInsets.all(16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
      ),
    );

    final signUpButton = ButtonTheme(
      height: 54.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child:  RaisedButton(
          color: Colors.lightBlue,
          onPressed: () { 
            Navigator.of(context).pushNamed(LogInPage.route); 
          },
          child: Text(
            "Register", 
            style: TextStyle(color: Colors.white, fontSize: 16.0)
          ),
        ),
      )
    );

    final form = Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          title,
          SizedBox(height: 36.0),
          userName,
          SizedBox(height: 8.0),
          email,
          SizedBox(height: 8.0),
          password,
          SizedBox(height: 8.0),
          confirmPassword,    
          SizedBox(height: 24.0), 
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: signUpButton,
            ),
          ),
          SizedBox(height: 24.0), 
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text("Sign up")),
      body: Container(
        padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0.0),
        child: form,
      ),
    );
  }
}