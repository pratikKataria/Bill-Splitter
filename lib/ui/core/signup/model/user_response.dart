/// password : "123456"
/// name : "John"
/// email : "k@gmail.com"

class UserResponse {
  UserResponse.fromJson(dynamic json) {
    _password = json['password'];
    _name = json['name'];
    _email = json['email'];
    _uid = json['uid'];
  }

  String _password;
  String _name;
  String _email;
  String _uid;

  String get password => _password;

  String get name => _name;

  String get email => _email;

  String get uid => _uid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['password'] = _password;
    map['name'] = _name;
    map['email'] = _email;
    map['uid'] = _uid;
    return map;
  }

  set uid(String value) {
    _uid = value;
  }

  set email(String value) {
    _email = value;
  }

  set name(String value) {
    _name = value;
  }

  set password(String value) {
    _password = value;
  }

  UserResponse();

}
