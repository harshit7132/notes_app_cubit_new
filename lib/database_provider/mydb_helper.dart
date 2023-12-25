import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyDBHelper {
  var NOTE_TABLE = "note";
  var COLUM_NOTE_ID = "note_id";
  var COLUM_NOTE_TITLE = "title";
  var COLUM_NOTE_DESC = "desc";

  Future<Database> openDB() async {
    var mDirectory = await getApplicationDocumentsDirectory();
    await mDirectory.create(recursive: true);
    var dbpath = "$mDirectory/notedb.db";

    return await openDatabase(dbpath, version: 1, onCreate: (db, version) {
      var createTableQuery =
          "create table $NOTE_TABLE ($COLUM_NOTE_ID integer primary key autoincrement, $COLUM_NOTE_TITLE text, $COLUM_NOTE_DESC text)";
      db.execute(createTableQuery);
    });
  }

  Future<bool> addNote(String title, String desc) async {
    var db = await openDB();

    var Check = await db
        .insert(NOTE_TABLE, {COLUM_NOTE_TITLE: title, COLUM_NOTE_DESC: desc});
    return Check > 0;
  }

  Future<List<Map<String, dynamic>>> fetchAllNotes() async {
    var db = await openDB();
    List<Map<String, dynamic>> notes = await db.query(NOTE_TABLE);
    return notes;
  }

  Future<bool> updateNotes(int id, String title, String desc) async {
    var db = await openDB();
    var chack = await db.update(
        NOTE_TABLE, {COLUM_NOTE_TITLE: title, COLUM_NOTE_DESC: desc},
        where: "$COLUM_NOTE_ID = $id");
    return chack > 0;
  }

  Future<bool> deletNotes(int id) async {
    var db = await openDB();
    var check = await db
        .delete(NOTE_TABLE, where: "$COLUM_NOTE_ID = ?", whereArgs: ["$id"]);
    return check > 0;
  }
}
