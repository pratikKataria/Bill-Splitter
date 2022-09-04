import 'package:bill_splitter/ui/core/signup/model/user_response.dart';
import 'package:bill_splitter/ui/splitBill/model/split_request.dart';
import 'package:bill_splitter/user/AuthUser.dart';
import 'package:firebase_database/firebase_database.dart';

import 'home_view.dart';

class HomePresenter {
  HomeView _v;
  final tag = "CorePresenter";
  List<UserResponse> listOfUsers = [];

  HomePresenter(this._v);

  Future<void> getAllGroups() async {
    final ref = FirebaseDatabase.instance.ref();
    String uid = (await AuthUser().getCurrentUser()).userCredentials.uid;

    final snapshot = await ref.child('Groups/$uid').get();
    List<SplitRequest> listOfUsers = [];
    if (snapshot.exists) {
      Map map = snapshot.value;
      map.forEach((key, value) => listOfUsers.add(SplitRequest.fromJson(value)));

      _v.onAllGroupsFetched(listOfUsers);
      print(listOfUsers);
    } else {
      print('No data available.');
    }
  }

}
