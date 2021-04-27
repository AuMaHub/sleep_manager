import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:sleep_manager/models/alarm_models.dart';

class AlarmManager {
  Future<bool> setAlarm(int alarmID, DateTime setTime) async {
    DateTime _now = DateTime.now();
    Duration _differenceTimes = setTime.difference(_now);

    if (_differenceTimes < Duration.zero) return false;

    try {
      await AndroidAlarmManager.initialize();
      await AndroidAlarmManager.periodic(
          _differenceTimes, alarmID, this.startAlarm);

      AlarmData alarm = AlarmData(
          alarmDescript: '',
          alarmID: alarmID,
          isActive: true,
          wakeUpTime: setTime);

      insertAlarm(alarm);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> cancelAlarm(int alarmID) async {
    try {
      await AndroidAlarmManager.initialize();
      await AndroidAlarmManager.cancel(alarmID);
      return true;
    } catch (e) {
      return false;
    }
  }

  void startAlarm() {
    // 로컬 노티스 및 알람노래
  }
}
