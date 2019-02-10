import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:authenticate_me/model/User.dart';
import 'package:authenticate_me/model/Record.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  // users TABLE
  static final userTableName = 'users';
  static final userIdColumnName = 'id';
  static final usernameColumnName = 'username';
  static final emailColumnName = 'email';
  static final paswordColumnName = 'password';

  // audit record TABLE
  static final recordTableName = 'records';
  static final recordIdColumnName = 'id';
  static final userColumnName = 'user';
  static final actionColumnName = 'action';
  static final dateColumnName = 'date';

  static Database _db;
  // super user that has more feature
  static User _admin = User("admin", "admin", "admin");

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
  
    //await this.saveUser(_admin);

    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $userTableName($userIdColumnName INTEGER PRIMARY KEY, $usernameColumnName TEXT, $emailColumnName TEXT, $paswordColumnName TEXT)'
    );
    await db.execute(
      'CREATE TABLE $recordTableName($recordIdColumnName INTEGER PRIMARY KEY, $userColumnName TEXT, $actionColumnName TEXT, $dateColumnName TEXT)'
    );
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    var result = await dbClient.insert(userTableName, user.toMap());
    saveRecord(user, 'Register');

    return result;
  }

  Future<User> getUser(String email) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(
      userTableName,
      columns: [userIdColumnName, usernameColumnName, emailColumnName, paswordColumnName],
      where: '$emailColumnName = ?',
      whereArgs: [email]
    );

    if (result.isEmpty) {
      saveRecord(User('unknown', email, 'unknown'), 'Try to Log in. Incorrect email.');
      return null;
    }
    
    var user = User.fromMap(result.first);
    saveRecord(user, 'Log in');

    return user;
  }

  Future<List<User>> getAllUsers() async {
    var dbClient = await db;
    var result = await dbClient.query(
      userTableName, 
      columns: [userIdColumnName, usernameColumnName, emailColumnName, paswordColumnName]
    );

    return result.map((f) => User.fromMap(f)).toList();
  }

  Future<void> saveRecord(User user, String action) async {
    var dbClient = await db;
    var record = Record(
      user.toString(),
      action,
      DateTime.now().toString()
    );
    await dbClient.insert(recordTableName, record.toMap());
  }

  Future<List<Record>> getAllRecords() async {
    var dbClient = await db;
    var result = await dbClient.query(
      recordTableName,
      columns: [recordIdColumnName, userColumnName, actionColumnName, dateColumnName]
    );

    return result.map((f) => Record.fromMap(f)).toList();
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}