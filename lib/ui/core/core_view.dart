import 'package:bill_splitter/ui/core/signup/model/user_response.dart';

abstract class CoreView {
  void onNewUserCreated(UserResponse r);
  void onError(String message);
}
