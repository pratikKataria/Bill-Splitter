import 'package:bill_splitter/ui/core/signup/model/user_response.dart';
import 'package:bill_splitter/ui/splitBill/split_bill_view.dart';
import 'package:firebase_database/firebase_database.dart';

class SplitBillPresenter {
  SplitBillView _v;
  final tag = "CorePresenter";
  List<UserResponse> listOfUsers = [];
  SplitBillPresenter(this._v);


}
