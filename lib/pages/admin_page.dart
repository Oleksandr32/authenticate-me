import 'package:flutter/material.dart';

import 'package:authenticate_me/pages/user_page.dart';
import 'package:authenticate_me/model/User.dart';
import 'package:authenticate_me/model/Record.dart';

class AdminPage extends StatelessWidget {
  final List<User> users;
  final List<Record> records;

  AdminPage({Key key, @required this.users, @required this.records}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersListView = ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(users[index].username),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserPage(user: users[index]),
              ),
            );
          },
        );
      },
    );

    final recordsListView = ListView.builder(
      itemCount: records.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
           Text('${records[index].user}'),
           Text('Action: ${records[index].action}'),
           Text('Date: ${records[index].date}'),
           Divider(height: 4.0, color: Colors.blueGrey),
          ],
        );
      },
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Admin Page'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.people)),
              Tab(icon: Icon(Icons.security)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            usersListView,
            recordsListView
          ],
        ),
      ),
    );
  }
}