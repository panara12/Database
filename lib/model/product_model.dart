class product_model {
  late int _pro_id;
  late String _product_name;
  late int _supplier_id;
  late int _package;

  int get pro_id => _pro_id;

  set pro_id(int pro_id) {
    _pro_id = pro_id;
  }

  String get product_name => _product_name;

  set product_name(String product_name) {
    _product_name = product_name;
  }

  int get supplier_id => _supplier_id;

  set supplier_id(int supplier_id) {
    _supplier_id = supplier_id;
  }

  int get package => _package;

  set package(int package) {
    _package = package;
  }
}
