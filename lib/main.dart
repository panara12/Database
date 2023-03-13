import 'package:database/add_user.dart';
import 'package:database/database.dart';
import 'package:database/user_list_page.dart';
import 'package:database/utils/edit_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    My_database().getDataFromUserTable();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: user_list_page(),
    );
  }
}
