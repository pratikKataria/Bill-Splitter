import 'package:bill_splitter/ui/core/signup/model/user_response.dart';
import 'package:firebase_database/firebase_database.dart';

import 'home_view.dart';

class HomePresenter {
  HomeView _v;
  final tag = "CorePresenter";
  List<UserResponse> listOfUsers = [];

  HomePresenter(this._v);

}
