import 'package:bill_splitter/ui/core/signup/model/user_response.dart';
import 'package:firebase_database/firebase_database.dart';

import 'core_view.dart';

class CorePresenter {
  CoreView _v;
  final tag = "CorePresenter";

  CorePresenter(this._v);

  List<UserResponse> listOfUsers = [];

  Future<void> loginUser(String email) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('Users/').get();
    listOfUsers.clear();
    if (snapshot.exists) {
      Map map = snapshot.value;
      map.forEach((key, value) {
        listOfUsers.add(UserResponse.fromJson(value));
      });
      print(listOfUsers);

      for (UserResponse response in listOfUsers) {
        if (response.email == email) {
          _v.onNewUserCreated(response);
          break;
        }
      }
      _v.onError("No data available.");
    } else {
      _v.onError("No data available.");
      print('No data available.');
    }
  }

  Future<void> getAllUsers() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('Users/').get();
    if (snapshot.exists) {
      Map map = snapshot.value;
      map.forEach((key, value) {
        listOfUsers.add(UserResponse.fromJson(value));
      });
      print(listOfUsers);
    } else {
      print('No data available.');
    }
  }

  Future<void> createUser(String name, String email, String password) async {
    String uid = idGenerator();
    DatabaseReference ref = FirebaseDatabase.instance.ref("Users/$uid");

    bool isNewUser = true;
    for (UserResponse response in listOfUsers) {
      if (response.email == email) {
        isNewUser = false;
      }
    }

    if (isNewUser) {
      ref.set({
        "name": name,
        "email": email,
        "password": password,
        "uid": uid,
      }).then((value) {
        UserResponse r = UserResponse()
          ..uid = uid
          ..name = name
          ..email = email
          ..password = password;

        _v.onNewUserCreated(r);
      }).onError((error, stackTrace) {});
    } else {
      _v.onError("Already a user, try different email");
    }
  }

  String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }
}
