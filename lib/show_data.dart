import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sql_demo/db.dart';

class ShowData extends StatefulWidget {
  @override
  _ShowDataState createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {

  DB db;
  List<Map> records;
  Duration lap;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Connect to DB
    db = new DB();
    db.connectToDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Data"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "${DB.list}"
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }


}
