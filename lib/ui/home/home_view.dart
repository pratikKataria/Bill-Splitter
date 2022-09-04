import 'package:bill_splitter/ui/core/signup/model/user_response.dart';
import 'package:bill_splitter/ui/splitBill/model/split_request.dart';

abstract class HomeView {
  void onError(String message);
  void onAllGroupsFetched(List<SplitRequest> listOfUsers);
}
