import 'package:sqflite/sqflite.dart';
import 'package:tracelog_app/models/location_entry.dart';

class DatabaseService {
  static const String _databaseName = 'locationHistoryList.db';
  static const String _tableName = 'location_history';
  static const int _version = 1;

  Future<void> createTable(Database database) async {
    await database.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY,
        street TEXT,
        latitude REAL,
        longitude REAL,
        accuracy REAL,
        recordAt TEXT,
        isAutoTracked INTEGER
      )
''');
  }

  Future<Database> _initializedDb() async {
    return openDatabase(
      _databaseName,
      version: _version,
      onCreate: (Database database, int version) async {
        await createTable(database);
      },
    );
  }

  Future<int> insertItem(LocationEntry location) async {
    final db = await _initializedDb();
    final data = location.toJson();
    final id = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  Future<List<LocationEntry>> getAllItems() async {
    final db = await _initializedDb();
    final results = await db.query(_tableName, orderBy: 'id DESC');
    return results.map((result) => LocationEntry.fromJson(result)).toList();
  }
}
