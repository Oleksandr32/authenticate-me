import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:authenticate_me/model/User.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static final tableName = 'users';
  static final idColumnName = 'id';
  static final usernameColumnName = 'username';
  static final emailColumnName = 'email';
  static final paswordColumnName = 'password';

  static Database _db;
  // super user that has more feature
  static User _admin = User(0, "admin", "admin", "admin");

  DatabaseHelper._internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'users.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
  
    await this.saveUser(_admin);

    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $tableName('
        + '$idColumnName INTEGER PRIMARY KEY,' 
        + ' $usernameColumnName TEXT,' 
        + ' $emailColumnName TEXT,'
        + ' $paswordColumnName TEXT)'
    );
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableName, user.toMap());
    return result;
  }

  Future<User> getUser(String email) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(
      tableName,
      columns: [idColumnName, usernameColumnName, emailColumnName, paswordColumnName],
      where: '$email = ?',
      whereArgs: [email]
    );

    if (result.isEmpty) {
      return null;
    }

    return User.fromMap(result.first);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}