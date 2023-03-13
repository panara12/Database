class order_model {
  late int _order_id;
  late String _order_date;
  late int _customer_id;
  late int _total_ammount;

  int get order_id => _order_id;

  set order_id(int order_id) {
    _order_id = order_id;
  }

  String get order_date => _order_date;

  set order_date(String order_date) {
    _order_date = order_date;
  }

  int get customer_id => _customer_id;

  set customer_id(int customer_id) {
    _customer_id = customer_id;
  }

  int get total_ammount => _total_ammount;

  set total_ammount(int total_ammount) {
    _total_ammount = total_ammount;
  }
}
