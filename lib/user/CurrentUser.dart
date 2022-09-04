import 'package:bill_splitter/ui/core/signup/model/user_response.dart';

class CurrentUser {
  UserResponse _userCredentials;
  bool _isLoggedIn;

  CurrentUser({
    UserResponse userCredentials,
    bool isLoggedIn,
  })  : _userCredentials = userCredentials,
        _isLoggedIn = isLoggedIn;

  bool get isLoggedIn => _isLoggedIn ?? false;

  UserResponse get userCredentials => _userCredentials;

  factory CurrentUser.fromMap(Map<String, dynamic> map) {
    return CurrentUser(userCredentials: UserResponse.fromJson(map['_userCredentials']), isLoggedIn: map['isLogin']);
  }

  Map<String, dynamic> toMap() {
    return {
      '_userCredentials': this.userCredentials?.toJson(),
      'isLogin': this.isLoggedIn,
    };
  }

  set userCredentials(UserResponse value) {
    _userCredentials = value;
  }

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
  }
}
