import 'package:flutter_alarm_s4/data/alarm.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {

  static final _databaseName = "alarm_app.db";
  static final _databaseVersion = 1;
  static final alarmTable = "alarm_app";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if(_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, _databaseName);
    return await openDatabase(path, version:  _databaseVersion, onCreate: _onCreate,
        onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $alarmTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      alarm_date_apm INTEGER DEFAULT 0, 
      alarm_date_time INTEGER DEFAULT 0,
      alarm_title String,
      alarm_memo String,
      alarm_days String,
      alarm_enable INTEGER DEFAULT 0
    )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  //알람 입력, 수정, 불러오기

  Future<int> insertAlarm(Alarm alarm) async {

    Database? db = await instance.database;

    if(alarm.alarm_id == null) {
      Map<String, dynamic> row = {
        "alarm_date_apm" : alarm.alarm_date_apm,
        "alarm_date_time" : alarm.alarm_date_time,
        "alarm_title" : alarm.alarm_title,
        "alarm_memo" : alarm.alarm_memo,
        "alarm_days" : alarm.alarm_days,
        "alarm_enable" : alarm.alarm_enable,
      };

      return await db!.insert(alarmTable, row);

    }else {
      Map<String, dynamic> row = {
        "alarm_id" : alarm.alarm_id,
        "alarm_date_apm" : alarm.alarm_date_apm,
        "alarm_date_time" : alarm.alarm_date_time,
        "alarm_title" : alarm.alarm_title,
        "alarm_memo" : alarm.alarm_memo,
        "alarm_days" : alarm.alarm_days,
        "alarm_enable" : alarm.alarm_enable,
      };

      return await db!.update(alarmTable, row, where: "id = ?", whereArgs: [alarm.alarm_id]);
    }
  }

  Future<List<Alarm>> getAllAlarm() async {

    Database? db = await instance.database;
    List<Alarm> alarms = [];

    var queries = await db?.query(alarmTable);

    if(queries!.isNotEmpty){

      for(var q in queries) {
        alarms.add (Alarm(
          alarm_id: int.parse(q["alarm_id"].toString()),
          alarm_date_apm:  int.parse( q['alarm_date_apm'].toString()),
          alarm_date_time: int.parse(q["alarm_date_time"].toString()),
          alarm_title: q["alarm_title"].toString(),
          alarm_memo: q["alarm_memo"].toString(),
          alarm_days: q["alarm_days"].toString(),
          alarm_enable: int.parse(q["alarm_enable"].toString()),
        ));
      }
    }

    return alarms;
  }

  Future<List<Alarm>> getTodoByDate(int date) async {
    Database? db = await instance.database;
    List<Alarm> alarms = [];

    var queries = await db!.query(alarmTable, where: "date = ?", whereArgs: [date]);

    for(var q in queries) {
      alarms.add ( Alarm(
        alarm_id: int.parse(q["alarm_id"].toString()),
        alarm_date_apm:  int.parse( q['alarm_date_apm'].toString()),
        alarm_date_time: int.parse(q["alarm_date_time"].toString()),
        alarm_title: q["alarm_title"].toString(),
        alarm_memo: q["alarm_memo"].toString(),
        alarm_days: q["alarm_days"].toString(),
        alarm_enable: int.parse(q["alarm_enable"].toString()),
      ));
    }
    return alarms;
  }

}