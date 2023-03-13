


class order_item_model {
  late int _order_item_id;
  late int _quantity;
  late int _product_id;
  late int _order_id;

  int get order_item_id => _order_item_id;

  set order_item_id(int order_item_id) {
    _order_item_id = order_item_id;
  }

  int get product_id => _product_id;

  set product_id(int product_id) {
    _product_id = product_id;
  }

  int get order_id => _order_id;

  set order_id(int order_id) {
    _order_id = order_id;
  }

  int get quantity => _quantity;

  set quantity(int quantity) {
    _quantity = quantity;
  }
}
