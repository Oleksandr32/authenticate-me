import 'package:flutter/material.dart';

import 'package:authenticate_me/pages/log_in_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder> {
    LogInPage.route: (context) => LogInPage()
  };

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Authenticate Me',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new LogInPage(),
      routes: routes,
    );
  }
}