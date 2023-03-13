import 'package:database/add_user.dart';
import 'package:database/database.dart';
import 'package:database/utils/edit_data.dart';
import 'package:flutter/material.dart';

import 'model/customer_model.dart';

class user_list_page extends StatefulWidget {
  @override
  State<user_list_page> createState() => _user_list_pageState();
}

class _user_list_pageState extends State<user_list_page> {
  My_database mydb = My_database();
  List<customer_model> localList = [];
  List<customer_model> searchList = [];
  bool isgetData = true;
  TextEditingController searchController = TextEditingController();
  bool isFavourite = true;

  @override
  void initState() {
    super.initState();
    My_database().copyPasteAssetFileToRoot().then(
      (value) {
        // // print("ok");
        // My_database().getDataFromUserTable();
        // userListFuture = My_database().getDataFromUserTable();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "User_list_page",
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => add_user(),
              ));
            },
            child: Container(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: FutureBuilder<List<customer_model>>(
        builder: (context, snapshot) {
          if (snapshot != null && snapshot.hasData) {
            // localList.addAll(snapshot.data!.toString());

            if (isgetData) {
              localList.addAll(snapshot.data!);
              searchList.addAll(localList);
            }
            isgetData = false;

            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      searchList.clear();
                      for (int i = 0; i < localList.length; i++) {
                        if (localList[i]
                            .first_name
                            .toLowerCase()
                            .contains(value.toLowerCase())) {
                          searchList.add(localList[i]);
                        }
                      }
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: 'Search here..',
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Card(
                                    shadowColor: Colors.black,
                                    elevation: 5,
                                    borderOnForeground: true,
                                    color: Colors.grey,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text(
                                                  searchList![index]
                                                      .first_name
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                            ),
                                          ),
                                          Expanded(
                                              child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) => edit_data(
                                                    searchList![index]),
                                              ));
                                            },
                                            child: Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                child:
                                                    Icon(Icons.chevron_right)),
                                          )),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                showAlertDialog(context, index);
                                              },
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Icon(Icons.delete,
                                                    color: Colors.redAccent,
                                                    size: 20),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  searchList[index]
                                                          .isFavourite =
                                                      !searchList[index]
                                                          .isFavourite;
                                                });
                                              },
                                              child: Icon(
                                                  searchList[index].isFavourite
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: Colors.red),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                              // Expanded(
                              //   child: Card(
                              //       color: Colors.grey,
                              //       child: Container(
                              //           padding: EdgeInsets.all(5),
                              //           alignment: Alignment.center,
                              //           child: Text(
                              //               snapshot.data![index].last_name.toString()))),
                              // ),
                            ],
                          ),
                        ],
                      );
                    },
                    itemCount: searchList!.length,
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text("no user found"),
            );
          }
        },
        future: isgetData ? My_database().getDataFromUserTable() : null,
      ),
    );
  }

  showAlertDialog(BuildContext context, index) {
    print(index);
    Widget okButton = TextButton(
      child: Text("Yes"),
      onPressed: () async {
        int deletedUserID = await My_database()
            .deleteUserFromTbl(searchList[index].customer_id);
        if (deletedUserID > 0) {
          searchList.removeAt(index);
          setState(() {});
          print(index);
        }
        Navigator.pop(context);
      },
    );

    Widget noButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text("No"),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Are you sure want to delete this user??"),
      actions: [okButton, noButton],
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
