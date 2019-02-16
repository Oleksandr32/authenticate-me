import 'package:flutter/material.dart';

import 'package:authenticate_me/model/User.dart';

class UserPage extends StatelessWidget {
  static final route = 'user-page';
  final User user;

  UserPage({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: 24.0,

    );

    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Id = ${user.id}", style: style),
              Text("Username = ${user.username}", style: style),
              Text("Email = ${user.email}", style: style),
              Text("Password = ${user.password}", style: style)
            ],
          ),
        ),
      ),
    );
  }
}