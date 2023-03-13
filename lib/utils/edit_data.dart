import 'package:database/database.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../model/customer_model.dart';
import '../user_list_page.dart';

class edit_data extends StatefulWidget {
  customer_model? customer_id;

  edit_data(this.customer_id);

  @override
  State<edit_data> createState() => _edit_dataState();
}

class _edit_dataState extends State<edit_data> {
  TextEditingController first_name = TextEditingController();

  TextEditingController last_name = TextEditingController();

  TextEditingController mobile_number = TextEditingController();

  bool isCity = true;

  My_database mydb = My_database();

  late customer_model model;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    first_name.text =
        (widget.customer_id == null ? '' : widget.customer_id!.first_name);
    last_name.text =
        (widget.customer_id == null ? '' : widget.customer_id!.last_name);
    mobile_number.text = (widget.customer_id == null
        ? ''
        : widget.customer_id!.phone.toString());
  }

  // int getDropDownSelectedPosition(){}
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Data",
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(children: [
            SizedBox(
              height: 30,
            ),
            Container(
              // color: Colors.grey,

              width: double.infinity,
              child: Column(
                children: [
                  // Text(model.customer_id}"),
                  Text("Enter First Name", style: TextStyle(fontSize: 18)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      controller: first_name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                  )
                ],
              ),
            ),
            Container(
              // color: Colors.grey,
              height: 100,
              width: double.infinity,
              child: Column(
                children: [
                  Text("Enter Last Name", style: TextStyle(fontSize: 18)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      controller: last_name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                  )
                ],
              ),
            ),
            Container(
              //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              width: double.infinity,
              child: FutureBuilder<List<customer_model>>(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (isCity) {
                      model = snapshot.data![0];
                    }
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
            Container(
              // color: Colors.grey,
              height: 100,
              width: double.infinity,
              child: Column(
                children: [
                  Text("Enter Mobile Number", style: TextStyle(fontSize: 18)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      controller: mobile_number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                  )
                ],
              ),
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
          ]),
        ),
      ),
    ));
  }

  dataValidate() async {
    if (_formKey.currentState!.validate()) {
      print(model.city);
      if (model.city == "select city") {
        showAlertDialog(context);
      } else {
        await mydb.editFromUserTable(
            widget.customer_id!.customer_id,
            first_name.text.toString(),
            last_name.text.toString(),
            model.city.toString(),
            mobile_number.text);
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

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {},
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
}
