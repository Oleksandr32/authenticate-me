import 'package:flutter/material.dart';

import 'package:password/password.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

import 'package:authenticate_me/pages/sign_up_page.dart';
import 'package:authenticate_me/pages/user_page.dart';
import 'package:authenticate_me/pages/admin_page.dart';
import 'package:authenticate_me/db/database.dart';
import 'package:authenticate_me/model/User.dart';

class LogInPage extends StatefulWidget {
  static final route = "log-in-page";

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final User admin = User("admin", "admin", "admin");

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final image = Hero(
      tag: "image",
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 64.0,
        child: Image.asset("assets/login.png"),
      ),
    );

    final title = Text(
      "Authenticate Me",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32.0),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: "Email",
        contentPadding: EdgeInsets.all(16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),  
      ),
      controller: _emailController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Email is required.';
        }
        return null;
      },
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
      validator: (value) {
        if (value.isEmpty) {
          return 'Password is required.';
        }
        return null;
      },
    );

    final authenticateButton = ButtonTheme(
      height: 54.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: RaisedButton(
          color: Colors.lightBlue,
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              var email = _emailController.text;
              var password = _passwordController.text;
              if (email == admin.email && password == admin.password) {
                var localAuth = LocalAuthentication();
                try {
                  bool didAuthenticate = await localAuth.authenticateWithBiometrics(
                      localizedReason: 'Please confirm fingerprint that you are admin.');

                  if (didAuthenticate) {
                    _saveRecord(admin, 'Log in completed');
                    var users = await _getAllUsers();
                    var records = await _getAllRecords();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminPage(users: users, records: records),
                      ),
                    );
                    return;
                  }
                } on PlatformException catch (e) {
                  if (e.code == auth_error.notAvailable) {
                    _saveRecord(admin, 'Log in completed');
                    var users = await _getAllUsers();
                    var records = await _getAllRecords();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminPage(users: users, records: records),
                      ),
                    );
                    return;
                  }
                }
              }

              var user = await _onAuthenticatePressed();
              if (user == null) {
                _emailController.text = 'User with email \"$email\" is missing.';
                return;
              }
              
              if (!Password.verify(password, user.password)) {
                _saveRecord(user, 'Try Log in. Incorrect password: $password.');
                _passwordController.text = '';
                return;
              }

              _saveRecord(user, 'Log in completed');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserPage(user: user),
                ),
              );
            }
          },
          child: Text(
            "Authenticate", 
            style: TextStyle(color: Colors.white, fontSize: 16.0)
          ),
        ),
      ),
    );

    final signUpButton = FlatButton(
      onPressed: () { 
        Navigator.of(context).pushNamed(SignUpPage.route); 
      },
      child: Text(
        "First time in App? Please, sign up.",
        style: TextStyle(color: Colors.black45),
      ),
    );

    final form = Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          image,
          SizedBox(height: 8.0),
          title,        
          SizedBox(height: 24.0),
          email,
          SizedBox(height: 8.0),
          password,
          SizedBox(height: 24.0),
          authenticateButton,
          signUpButton
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text("Log in")),
      body: Container(
        padding: EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 0.0),
        child: form,
      )
      );
  }

  Future<User> _onAuthenticatePressed() async {
    var db = DatabaseHelper();
    var email = _emailController.text;
    var user =  await db.getUser(email);
    return user;
  }

  Future<List> _getAllUsers() async {
    var db = DatabaseHelper();
    var users =  await db.getAllUsers();
    return users;
  } 

  Future<void> _saveRecord(User user, String action) async {
    var db = DatabaseHelper();
    db.saveRecord(user, action);
  }

  Future<List> _getAllRecords() async {
    var db = DatabaseHelper();
    var records = await db.getAllRecords();
    return records;
  }
}