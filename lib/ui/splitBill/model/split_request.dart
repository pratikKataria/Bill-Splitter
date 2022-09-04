/// groupName : "Goa Trip"
/// createdby : "pratik"
/// groupTotal : 1231
/// splitPerHead : 150
/// totalPeople : 3
/// guestFriend : [{"name":"deepak","expenses":[{"label":"tea","cost":100,"qty":1}]}]

class SplitRequest {
  SplitRequest({
    String groupName,
    String createdby,
    num groupTotal,
    num splitPerHead,
    int totalPeople,
    List<GuestFriend> guestFriend,
  }) {
    _groupName = groupName;
    _createdby = createdby;
    _groupTotal = groupTotal;
    _splitPerHead = splitPerHead;
    _totalPeople = totalPeople;
    _guestFriend = guestFriend;
  }

  SplitRequest.fromJson(dynamic json) {
    _groupName = json['groupName'];
    _createdby = json['createdby'];
    _groupTotal = json['groupTotal'];
    _splitPerHead = json['splitPerHead'];
    _totalPeople = json['totalPeople'];
    if (json['guestFriend'] != null) {
      _guestFriend = [];
      json['guestFriend'].forEach((v) {
        _guestFriend.add(GuestFriend.fromJson(v));
      });
    }
  }

  String _groupName;
  String _createdby;
  num _groupTotal;
  num _splitPerHead;
  int _totalPeople;
  List<GuestFriend> _guestFriend;

  String get groupName => _groupName;

  String get createdby => _createdby;

  num get groupTotal => _groupTotal;

  num get splitPerHead => _splitPerHead;

  int get totalPeople => _totalPeople;

  List<GuestFriend> get guestFriend => _guestFriend;

  set groupName(String value) {
    _groupName = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['groupName'] = _groupName;
    map['createdby'] = _createdby;
    map['groupTotal'] = _groupTotal;
    map['splitPerHead'] = _splitPerHead;
    map['totalPeople'] = _totalPeople;
    if (_guestFriend != null) {
      map['guestFriend'] = _guestFriend.map((v) => v.toJson()).toList();
    }
    return map;
  }

  set createdby(String value) {
    _createdby = value;
  }

  set groupTotal(int value) {
    _groupTotal = value;
  }

  set splitPerHead(num value) {
    _splitPerHead = value;
  }

  set totalPeople(int value) {
    _totalPeople = value;
  }

  set guestFriend(List<GuestFriend> value) {
    _guestFriend = value;
  }
}

/// name : "deepak"
/// expenses : [{"label":"tea","cost":100,"qty":1}]

class GuestFriend {
  GuestFriend({
    String name,
    String uid,
    List<Expenses> expenses,
  }) {
    _name = name;
    _uid = uid;
    _expenses = expenses;
  }

  GuestFriend.fromJson(dynamic json) {
    _name = json['name'];
    _uid = json['uid'];
    if (json['expenses'] != null) {
      _expenses = [];
      json['expenses'].forEach((v) {
        _expenses.add(Expenses.fromJson(v));
      });
    }
  }

  String _name;
  String _uid;
  List<Expenses> _expenses = [];

  String get name => _name;

  String get uid => _uid;

  List<Expenses> get expenses => _expenses;

  set name(String value) {
    _name = value;
  }

  set uid(String value) {
    _uid = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['uid'] = _uid;
    if (_expenses != null) {
      map['expenses'] = _expenses.map((v) => v.toJson()).toList();
    }
    return map;
  }

  set expenses(List<Expenses> value) {
    _expenses = value;
  }
}

/// label : "tea"
/// cost : 100
/// qty : 1

class Expenses {
  Expenses({
    String label,
    int cost,
    int qty,
  }) {
    _label = label;
    _cost = cost;
    _qty = qty;
  }

  Expenses.fromJson(dynamic json) {
    _label = json['label'];
    _cost = json['cost'];
    _qty = json['qty'];
  }

  String _label;
  int _cost = 0;
  int _qty = 1;

  String get label => _label;

  int get cost => _cost ?? 0;

  int get qty => _qty ?? 1;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['label'] = _label;
    map['cost'] = _cost;
    map['qty'] = _qty;
    return map;
  }

  set qty(int value) {
    _qty = value;
  }

  set cost(int value) {
    _cost = value;
  }

  set label(String value) {
    _label = value;
  }
}
