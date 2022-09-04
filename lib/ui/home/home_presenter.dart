import 'package:bill_splitter/ui/core/signup/model/user_response.dart';
import 'package:firebase_database/firebase_database.dart';

import 'home_view.dart';

class HomePresenter {
  HomeView _v;
  final tag = "CorePresenter";

  HomePresenter(this._v);

  List<UserResponse> listOfUsers = [];

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
