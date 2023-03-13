import 'package:database/database.dart';
import 'package:database/model/customer_model.dart';
import 'package:database/user_list_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';

class add_user extends StatefulWidget {
  @override
  State<add_user> createState() => _add_userState();
}

class _add_userState extends State<add_user> {
  My_database mydb = My_database();
  DateTime currentDate = DateTime.now();
  late customer_model model;
  final _formKey = GlobalKey<FormState>();
  bool isCity = true;
  TextEditingController name = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ADD USER"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                hintText: "Enter name ",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              child: FutureBuilder<List<customer_model>>(
                builder: (context, snapshot) {
                  if (snapshot != null && snapshot.hasData) {
                    if (isCity) {
                      model = snapshot.data![0];
                    }
                    ;
                    return DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        items: snapshot.data!
                            .map((item) => DropdownMenuItem<customer_model>(
                                  value: item,
                                  child: Text(item.city.toString()),
                                ))
                            .toList(),
                        value: model,
                        onChanged: (value) {
                          setState(() {
                            isCity = false;
                            model = value!;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                      ),
                    );
                  } else {
                    return Text("no user found");
                  }
                },
                future: isCity ? mydb.getDataFromUserTable() : null,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(currentDate.toString()),
                PrimaryButton(
                  title: "select date",
                  onPressed: () => _selectDate(context),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () => dataValidate(),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 50),
                child: Center(
                    child: Text(
                  "Submit",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        dispose();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Please Select City"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  dataValidate() async {
    if (_formKey.currentState!.validate()) {
      print(model.city);
      if (model.city == "select city") {
        showAlertDialog(context);
      } else {
        await mydb.insertDataIntoUsertable(
            name.text.toString(), "xyz", model.city.toString(), "9999999999");

        print({model.city.toString()});
        print({name.text.toString()});
        print({currentDate.toString()});
      }
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => user_list_page(),
      ));
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }
}
