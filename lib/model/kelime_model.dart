import 'package:kelime/db/database_provider.dart';
import 'package:sqflite/sqflite.dart';

class Kelime {
  int id;
  String turkce;
  String ingilizce;

  Kelime({this.id, this.turkce, this.ingilizce});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_TURKCE: turkce,
      DatabaseProvider.COLUMN_INGILIZCE: ingilizce,
    };
    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }
    return map;
  }

  Kelime.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    turkce = map[DatabaseProvider.COLUMN_TURKCE];
    ingilizce = map[DatabaseProvider.COLUMN_INGILIZCE];
  }
}
