import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'userToken.dart';

class DBhelper {
  Database? _database;

  //create or get instance
  Future<Database> get dbInstance async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initDB();
      return _database!;
    }
  }

  initDB() async {
    // Directory document = await getApplicationDocumentsDirectory();
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'user.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE tokenUser(id INTEGER PRIMARY KEY, token TEXT)");
      },
      version: 1,
    );
  }

  // Future<void> insertToken(User user) async {
  //   final db = await dbInstance;
  //   await db.insert(
  //     'tokenUser',
  //     user.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }
  Future<void> insertToken(User user) async {
    final db = await dbInstance;
    await db.transaction((txn) async {
      int rowsAffected = await txn.rawUpdate(
        'INSERT OR REPLACE INTO tokenUser (id, token) VALUES (?, ?)',
        [user.id, user.token],
      );
      print('Rows affected: $rowsAffected');
    });
  }

  Future<List<User>> getToken() async {
    final db = await dbInstance;
    // final List<Map<String, dynamic>> maps = await db.query('tokenUser');
    // return maps[0];
    final maps = await db
        .query("tokenUser"); //query all the rows in a table as an array of maps
    return List.generate(maps.length, (i) {
      //create a list of memos
      return User(
        id: maps[i]['id'] as int,
        token: maps[i]['token'] as String,
      );
    });
  }

  Future<void> deleteToken() async {
    final db = await dbInstance;
    await db.delete('tokenUser');
  }
}
