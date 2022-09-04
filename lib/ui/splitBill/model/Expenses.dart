/// title : ""
/// qty : 1
/// price : 12
/// uid : ""

class Expenses {
  Expenses({
      String title, 
      int qty, 
      int price, 
      String uid,}){
    _title = title;
    _qty = qty;
    _price = price;
    _uid = uid;
}

  Expenses.fromJson(dynamic json) {
    _title = json['title'];
    _qty = json['qty'];
    _price = json['price'];
    _uid = json['uid'];
  }
  String _title;
  int _qty;
  int _price;
  String _uid;

  String get title => _title;
  int get qty => _qty??1;
  int get price => _price??0;
  String get uid => _uid;


  set title(String value) {
    _title = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['qty'] = _qty;
    map['price'] = _price;
    map['uid'] = _uid;
    return map;
  }

  set qty(int value) {
    _qty = value;
  }

  set price(int value) {
    _price = value;
  }

  set uid(String value) {
    _uid = value;
  }
}