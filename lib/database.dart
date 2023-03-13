import 'dart:io';
import 'package:database/model/customer_model.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class My_database {
  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'database_demo.db');
    return await openDatabase(
      databasePath,
    );
  }

  Future<void> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "database_demo.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data =
          await rootBundle.load(join('assets/database', 'database_demo.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await new File(path).writeAsBytes(bytes);
    }
  }

  Future<void> insertDataIntoUsertable(
      String first_name, String last_name, String city, String phone) async {
    Database db = await initDatabase();
    Map<String, Object> map = Map();
    map['first_name'] = first_name;
    map['last_name'] = last_name;
    map['city'] = city;
    map['phone'] = phone;
    db.insert('customer', map);
  }

  Future<void> editFromUserTable(int customer_id, String first_name,
      String last_name, String city, String phone) async {
    Database db = await initDatabase();
    Map<String, Object> map = Map();
    map['first_name'] = first_name;
    map['last_name'] = last_name;
    map['city'] = city;
    map['phone'] = phone;
    if (customer_id != -1) {
      await db.update('customer', map,
          where: 'customer_id=?', whereArgs: [customer_id]);
    } else
      db.insert('customer', map);

  }

  Future<List<customer_model>> getDataFromUserTable() async {
    List<customer_model> customer_list = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> data =
        await db.rawQuery('select * from customer');

    customer_model model = customer_model();
    model.first_name = "first name";
    model.last_name = "last name";
    model.customer_id = 0;
    model.city = "select city";
    model.phone = -1;
    customer_list.add(model);

    for (int i = 0; i < data.length; i++) {
      customer_model model = customer_model();
      model.first_name = data[i]['first_name'].toString();
      model.last_name = data[i]['last_name'].toString();
      model.customer_id = data[i]['customer_id'] as int;
      model.city = data[i]['city'].toString();
      model.phone = data[i]['phone'] as int;

      customer_list.add(model);
    }
    print("${data.length}");
    return customer_list;
  }

  Future<int> deleteUserFromTbl(int customer_id) async {
    Database db = await initDatabase();
    Map<String, Object?> map = Map();
    map['customer_id'] = customer_id;
    return db
        .delete('customer', where: "customer_id = ?", whereArgs: [customer_id]);
  }
}
