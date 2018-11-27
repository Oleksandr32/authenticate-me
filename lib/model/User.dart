class User {
  int _id;
  String _username;
  String _email;
  String _password;

  User(this._id, this._username, this._email, this._password);

  int get id => _id;
  String get username => _username;
  String get email => _email;
  String get password => _password;

  User.map(dynamic obj) {
    this._id = obj['id'];
    this._username = obj['username'];
    this._email = obj['email'];
    this._password = obj['password'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = _id;
    map['username'] = _username;
    map['email'] = _email;
    map['password'] = _password;

    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._username = map['username'];
    this._email = map['email'];
    this._password = map['password'];
  }
}