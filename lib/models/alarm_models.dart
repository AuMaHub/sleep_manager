import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AlarmData {
  final int alarmID;
  String alarmDescript;
  DateTime wakeUpTime;
  bool isActive;

  AlarmData({this.alarmID, this.alarmDescript, this.isActive, this.wakeUpTime});

  // dog를 Map으로 변환합니다. key는 데이터베이스 컬럼 명과 동일해야 합니다.
  Map<String, dynamic> toMap() {
    return {
      'alarmID': alarmID,
      'alarmDescript': alarmDescript,
      'wakeUpTime': wakeUpTime,
      'isActive': isActive,
    };
  }
}

// 데이터베이스에 dog를 추가하는 함수를 정의합니다.
Future<void> insertAlarm(AlarmData alarm) async {
  // 데이터베이스를 열고 참조 값을 얻습니다.
  final Future<Database> database = openDatabase(
    // 데이터베이스 경로를 지정합니다. 참고: `path` 패키지의 `join` 함수를 사용하는 것이
    // 각 플랫폼 별로 경로가 제대로 생성됐는지 보장할 수 있는 가장 좋은 방법입니다.
    join(await getDatabasesPath(), 'alarm_database.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE alarmSet(alarmID INTEGER PRIMARY KEY, alarmDescript TEXT, wakeUpTime INTEGER, isActive TEXT)');
    },
    version: 1,
  );

  // 데이터베이스 reference를 얻습니다.
  final Database db = await database;

  await db.insert(
    'alarmSet',
    alarm.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
