import 'package:bill_splitter/ui/core/signup/model/user_response.dart';
import 'package:bill_splitter/ui/splitBill/model/split_request.dart';
import 'package:bill_splitter/ui/splitBill/split_bill_view.dart';
import 'package:bill_splitter/user/AuthUser.dart';
import 'package:bill_splitter/util/Dialogs.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class SplitBillPresenter {
  SplitBillView _v;
  final tag = "CorePresenter";

  SplitBillPresenter(this._v);

  Future<void> getAllUsers(BuildContext context) async {
    final ref = FirebaseDatabase.instance.ref();
    // Dialogs.showLoader(context, "Getting user list", "Users");
    ref.child('Users/').get().then((value) async {
      // await Future.delayed(Duration(milliseconds: 600), () => Dialogs.hideLoader(context));
      List<UserResponse> listOfUsers = [];
      Map map = value.value;
      map.forEach((key, value) => listOfUsers.add(UserResponse.fromJson(value)));

      String uid = (await AuthUser().getCurrentUser()).userCredentials.uid;
      listOfUsers.removeWhere((element) => element.uid == uid);
      _v.onAllUserFetched(listOfUsers);
      print(listOfUsers);
    }).onError((error, stackTrace) async {
      // await Future.delayed(Duration(milliseconds: 600), () => Dialogs.hideLoader(context));
      print('No data available.');
    });
  }

  Future<void> createGroup(BuildContext context, SplitRequest request) async {
    String uid = (await AuthUser().getCurrentUser()).userCredentials.uid;
    String gid = idGenerator();

    DatabaseReference ref = FirebaseDatabase.instance.ref("Groups/$uid/$gid");

    List<DatabaseReference> refList = [];
    Dialogs.showLoader(context, "Creating Group", "Groups");
    request.guestFriend.forEach((element) {
      if (element.uid != null) {
        refList.add(FirebaseDatabase.instance.ref("Groups/${element.uid}/$gid"));
      }
    });

    refList.forEach((element) {
      element.set(request.toJson());
    });

    ref.set(request.toJson()).then((value) async {
      await Future.delayed(Duration(milliseconds: 600), () => Dialogs.hideLoader(context));
      Navigator.pop(context);
    }).onError((error, stackTrace) {});
  }

  String idGenerator() {
    final now = DateTime.now();
    return "guid-${now.microsecondsSinceEpoch.toString()}";
  }
}
