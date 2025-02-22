
import 'package:color_extraction/db_color/color_entity.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DBColor extends GetxService {
  late Database dbBase;

  Future<DBColor> init() async {
    await createColorDB();
    return this;
  }

  createColorDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'color.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await createColorTable(db);
        });
  }

  createColorTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS color (id INTEGER PRIMARY KEY, createdTime TEXT, content TEXT)');
  }

  insertColor(ColorEntity entity) async {
    final id = await dbBase.insert('color', {
      'createdTime': entity.createdTime.toIso8601String(),
      'content': entity.content,
    });
    return id;
  }

  cleanColorData() async {
    await dbBase.delete('color');
  }

  Future<List<ColorEntity>> getColorAllData() async {
    var result = await dbBase.query('color', orderBy: 'createdTime DESC');
    return result.map((e) => ColorEntity.fromJson(e)).toList();
  }
}
