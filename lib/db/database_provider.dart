import 'package:kelime/model/kelime_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String KELIME_TABLO = "kelime";
  static const String COLUMN_ID = "id";
  static const String COLUMN_TURKCE = "turkce";
  static const String COLUMN_INGILIZCE = "ingilizce";

  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    print("Database getter called");

    if (_database != null) {
      return _database;
    } else {
      _database = await createDatabase();
      return _database;
    }
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(join(dbPath, 'kelime.db'), version: 1,
        onCreate: (Database database, int version) async {
      print("Creating kelime table");

      await database.execute(
          "CREATE TABLE $KELIME_TABLO($COLUMN_ID INTEGER PRIMARY KEY,$COLUMN_TURKCE VARCHAR(30),$COLUMN_INGILIZCE VARCHAR(30))");
    });
  }

  Future<List<Kelime>> getKelime() async {
    final db = await database;

    var kelimeler = await db.query(KELIME_TABLO,
        columns: [COLUMN_ID, COLUMN_TURKCE, COLUMN_INGILIZCE]);

    List<Kelime> kelimeList = List<Kelime>();
    kelimeler.forEach((anlikKelime) {
      Kelime kelime = Kelime.fromMap(anlikKelime);
      kelimeList.add(kelime);
    });
    return kelimeList;
  }

  Future<Kelime> insert(Kelime kelime) async {
    final db = await database;
    kelime.id = await db.insert(KELIME_TABLO, kelime.toMap());
    return kelime;
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(KELIME_TABLO, where: "id = ?", whereArgs: [id]);
  }

  Future<int> update(Kelime kelime) async {
    final db = await database;
    return await db.update(KELIME_TABLO, kelime.toMap(),
        where: "id = ?", whereArgs: [kelime.id]);
  }
}
