class customer_model {
  late String _first_name;
  late String _last_name;
  late int _phone;
  late String _city;
  late int _customer_id;
  late bool _isFavourite = false;

  bool get isFavourite => _isFavourite;

  set isFavourite(bool isFavourite) {
    _isFavourite = isFavourite;
  }

  String get first_name => _first_name;

  set first_name(String first_name) {
    _first_name = first_name;
  }

  String get last_name => _last_name;

  set last_name(String last_name) {
    _last_name = last_name;
  }

  int get customer_id => _customer_id;

  set customer_id(int customer_id) {
    _customer_id = customer_id;
  }

  String get city => _city;

  set city(String city) {
    _city = city;
  }

  int get phone => _phone;

  set phone(int phone) {
    _phone = phone;
  }
}
