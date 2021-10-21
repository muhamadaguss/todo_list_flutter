import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/repositories/database_connection.dart';

class Repository {
  late DatabaseConnection _databaseConnection;

  Repository() {
    //initialize database connection
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  //Check if database is exist or not
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDataBase();
    return _database;
  }

  //Insert Data
  insertData(table, data) async {
    var connection = await database;
    return await connection!.insert(table, data);
  }

  //Read Data
  readData(table) async {
    var connection = await database;
    return await connection!.query(table);
  }

  //Read Data By Id
  readDataById(table, categoryId) async {
    var connection = await database;
    return await connection!.query(
      table,
      where: 'id=?',
      whereArgs: [categoryId],
    );
  }

  //Update Data
  updateData(table, data) async {
    var connection = await database;
    return await connection!.update(
      table,
      data,
      where: 'id=?',
      whereArgs: [
        data['id'],
      ],
    );
  }

  //Delete Data
  deleteData(table, categoryId) async {
    var connection = await database;
    return await connection!
        .rawDelete("DELETE FROM $table WHERE id = $categoryId");
  }
}
