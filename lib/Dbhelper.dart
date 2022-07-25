import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dbhelper{
 Future<Database> creatdatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'login.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE Loginpage (id INTEGER PRIMARY KEY AUTOINCREMENT, firstname TEXT,email TEXT,phone TEXT,cpassword TEXT,gender TEXT,languge TEXT,city TEXT,date TEXT)');
        });

    return database;

  }
}