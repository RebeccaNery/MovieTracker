import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper{
  Future<Database> initDB() async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'filmes.db');
    return await openDatabase(path, onCreate: (db, version){
      const sql="CREATE TABLE contatos("
          "_id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "nome TEXT,"
          "email TEXT)";
      db.execute(sql);
    }, version:1);
  }
}