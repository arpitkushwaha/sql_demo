import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB{

  var databasesPath;
  String path;
  Database database;
  int lastID;
  static List<Map> list;

  void connectToDB() async
  {
    // Get a location using getDatabasesPath
    databasesPath = await getDatabasesPath();
    path = join(databasesPath, 'demo.db');

// Delete the database
    //await deleteDatabase(path);

// open the database
    database = await openDatabase(path, version: 1,
      // onCreate: (Database db, int version) async {
      // When creating the db, create the table
      // await db.execute(
      //     'CREATE TABLE User (id INTEGER PRIMARY KEY, name TEXT, rollno TEXT)');
      //}
    );




// Update some record
//     int count = await database.rawUpdate(
//         'UPDATE Test SET name = ?, value = ? WHERE name = ?',
//         ['updated name', '9876', 'some name']);
//     print('updated: $count');

//   assert(const DeepCollectionEquality().equals(list, expectedList));

// Count the records
//     count = Sqflite
//         .firstIntValue(await database.rawQuery('SELECT COUNT(*) FROM Test'));
//   assert(count == 2);

// Delete a record
//   count = await database
//       .rawDelete('DELETE FROM Test WHERE name = ?', ['another name']);
//   assert(count == 1);

  }

  Future<List<Map>> getRecords() async
  {
    // Get the records
    list = await database.rawQuery('SELECT * FROM User');
    print(list);
    return list;
  }

  void insert(String name, String rollno) async
  {
    // Insert some records in a transaction
    lastID = await getLastID(); lastID++;
    await database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO User(id, name, rollno) VALUES($lastID, "$name", "$rollno")');
      print('inserted: $id1');
    });
  }

  Future<int> getLastID() async
  {
    //Get Last Inserted ID
    List<Map> listOfLastInsertedID = await database.rawQuery('SELECT * FROM User ORDER BY id DESC LIMIT 1');
    lastID = listOfLastInsertedID.elementAt(0).values.elementAt(0);
    return lastID;
  }

  void closeDB() async
  {
    // Close the database
    await database.close();
  }
}