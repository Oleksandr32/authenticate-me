import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  static final route = "log-in-page";

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
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

    final authenticateButton = ButtonTheme(
      height: 54.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
      child: RaisedButton(
        color: Colors.lightBlue,
        onPressed: () { Navigator.of(context).pushNamed("TODO"); },
        child: Text(
          "Authenticate", 
          style: TextStyle(color: Colors.white, fontSize: 16.0)
        ),
      ),
    );

    final signUpButton = FlatButton(
      onPressed: () { Navigator.of(context).pushNamed("TODO"); },
      child: Text(
        "First time in App? Please, sign up.",
        style: TextStyle(color: Colors.black45),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text("Log in")),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 24.0),
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
        ),
      );
  }
}