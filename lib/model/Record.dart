class Record {
  int _id;
  String _user;
  String _action;
  String _date;

  Record(this._user, this._action, this._date);

  int get id => _id;
  String get user => _user;
  String get action => _action;
  String get date => _date;

  Record.map(dynamic obj) {
    this._id = obj['id'];
    this._user = obj['user'];
    this._action = obj['action'];
    this._date = obj['date'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['user'] = _user;
    map['action'] = _action;
    map['date'] = _date;

    return map;
  }

  Record.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._user = map['user'];
    this._action = map['action'];
    this._date = map['date'];
  }
}