import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static final DataBaseHelper _instance = new DataBaseHelper.internal();
  factory DataBaseHelper() => _instance;
  static Database _db;
  final String dbName = "MockDB";
  final String tableName = "user";
  DataBaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDataBase();
    return _db;
  }

  initDataBase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "$dbName.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    //Create a table USER
    await db.execute(
        "CREATE TABLE $tableName (tuserid integer primary key autoincrement,firstname text,lastname text,email text,mobnum integer,userrole text,userid text UNIQUE,password text)");
  }

  Future<bool> insert(Map<String, dynamic> dataMap) async {
    var dbClient = await db;
    try {
      await dbClient.insert(tableName, dataMap,
          conflictAlgorithm: ConflictAlgorithm.ignore);
    } catch (e) {
      print(e);
    }
    return true;
  }

  Future<List<Map<String, dynamic>>> fetchUserData(
      {String loginid, String pswd}) async {
    var dbClient = await db;
    return await dbClient.query(tableName,
        where: "userid = '" + loginid + "' and password = '" + pswd + "' ");
  }

  Future<List<Map<String, dynamic>>> fetchUserDetail(String uniqid) async {
    var dbClient = await db;
    return await dbClient.query(tableName,
        where: "tuserid = '" + uniqid + "' ");
  }
}
