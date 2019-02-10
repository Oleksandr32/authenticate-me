import 'package:flutter/material.dart';

import 'package:password/password.dart';

import 'package:authenticate_me/model/User.dart';
import 'package:authenticate_me/pages/log_in_page.dart';
import 'package:authenticate_me/db/database.dart';

class SignUpPage extends StatefulWidget {
  static final route = "sign-up-page";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _validateUsername(String username) {
    if (username.isEmpty) {
      return 'Username is required.';
    } 

    return null;  
  }

  String _validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email is required.';
    }

    RegExp regex = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regex.hasMatch(email)) {
      return 'Incorrect email. Please try again.';
    }

    return null;
  }

  String _validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is required.';
    } else if (password.length < 8) {
      return 'Password should contains more 7 symbols.';
    } 

    return null;    
  }

  String _validateConfirmPassword(String password) {
    if (password.isEmpty) {
      return 'Confirm password is required.';
    } else if (password != _passwordController.text) {
      return 'Confirm password not equals password.';
    } 

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final title = Text(
      "Register Form",
      style: TextStyle(fontSize: 36.0),
    );

    final userName = TextFormField(
      autofocus: false,
      controller: _usernameController,
      validator: _validateUsername,
      decoration: InputDecoration(
        hintText: "User Name",
        contentPadding: EdgeInsets.all(16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),  
      ),
    );

  final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: _emailController,
      validator: _validateEmail,
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
      controller: _passwordController,
      validator: _validatePassword,
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
      validator: _validateConfirmPassword,
    );

    final signUpButton = ButtonTheme(
      height: 54.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child:  RaisedButton(
          color: Colors.lightBlue,
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              await _onRegisterButtonPressed();
              Navigator.of(context).pushNamed(LogInPage.route);
            }
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

  Future<void> _onRegisterButtonPressed() async {
    var db = DatabaseHelper();
    var user = User(
      _usernameController.text,
      _emailController.text,
      Password.hash(_passwordController.text, PBKDF2()),
    );
    await db.saveUser(user);
  }
}