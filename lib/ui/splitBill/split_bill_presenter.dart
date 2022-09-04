import 'package:bill_splitter/ui/core/signup/model/user_response.dart';
import 'package:bill_splitter/ui/splitBill/model/split_request.dart';
import 'package:bill_splitter/ui/splitBill/split_bill_view.dart';
import 'package:bill_splitter/user/AuthUser.dart';
import 'package:firebase_database/firebase_database.dart';

class SplitBillPresenter {
  SplitBillView _v;
  final tag = "CorePresenter";

  SplitBillPresenter(this._v);

  Future<void> getAllUsers() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('Users/').get();
    List<UserResponse> listOfUsers = [];
    if (snapshot.exists) {
      Map map = snapshot.value;
      map.forEach((key, value) => listOfUsers.add(UserResponse.fromJson(value)));

      String uid = (await AuthUser().getCurrentUser()).userCredentials.uid;
      listOfUsers.removeWhere((element) => element.uid == uid);
      _v.onAllUserFetched(listOfUsers);
      print(listOfUsers);
    } else {
      print('No data available.');
    }
  }

  Future<void> createGroup(SplitRequest request) async {
    String uid = (await AuthUser().getCurrentUser()).userCredentials.uid;
    String gid = idGenerator();

    DatabaseReference ref = FirebaseDatabase.instance.ref("Groups/$uid/$gid");

    List<DatabaseReference> refList = [];
    request.guestFriend.forEach((element) {
       if (element.uid != null) {
         refList.add(FirebaseDatabase.instance.ref("Groups/${element.uid}/$gid"));
       }
    });

    refList.forEach((element) {
      element.set(request.toJson());
    });

    ref.set(request.toJson())
        .then((value) {})
        .onError((error, stackTrace) {});
  }

  String idGenerator() {
    final now = DateTime.now();
    return "guid-${now.microsecondsSinceEpoch.toString()}";
  }
}
