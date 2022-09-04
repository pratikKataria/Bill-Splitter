import 'package:bill_splitter/ui/core/signup/model/user_response.dart';

abstract class SplitBillView{
  void onError(String message);
  void onAllUserFetched(List<UserResponse> listOfUsers);
}
