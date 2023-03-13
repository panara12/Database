class supplier_model {
  late int _sup_id;
  late int _phone_number;
  late String _city;
  late int _contact_name;
  late String _company_name;

  int get sup_id => _sup_id;

  set sup_id(int sup_id) {
    _sup_id = sup_id;
  }

  String get company_name => _company_name;

  set company_name(String company_name) {
    _company_name = company_name;
  }

  int get contact_name => _contact_name;

  set contact_name(int contact_name) {
    _contact_name = contact_name;
  }

  String get city => _city;

  set city(String city) {
    _city = city;
  }

  int get phone_number => _phone_number;

  set phone_number(int phone_number) {
    _phone_number = phone_number;
  }
}
