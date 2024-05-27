import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:reminder_app/models/data.dart';

class SetTask extends ChangeNotifier {
  final taskBox = Hive.box("taskBox");

  List tasks = [];

  void addTask(Task task) {
    tasks.add(task);
    notifyListeners();
  }

  void removeTask(int index) {
    tasks.removeAt(index);
    notifyListeners();
  }

  List loadData() {
    tasks = taskBox.get("TASKS");
    return tasks;
  }

  void updateData() {
    taskBox.put("TASKS", tasks);
  }

  DateTime getDateTime(String selectedDay, TimeOfDay timeOfDay) {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday;

    int targetWeekday;
    switch (selectedDay.toLowerCase()) {
      case 'monday':
        targetWeekday = DateTime.monday;
        break;
      case 'tuesday':
        targetWeekday = DateTime.tuesday;
        break;
      case 'wednesday':
        targetWeekday = DateTime.wednesday;
        break;
      case 'thursday':
        targetWeekday = DateTime.thursday;
        break;
      case 'friday':
        targetWeekday = DateTime.friday;
        break;
      case 'saturday':
        targetWeekday = DateTime.saturday;
        break;
      case 'sunday':
        targetWeekday = DateTime.sunday;
        break;
      default:
        throw ArgumentError("Invalid weekday: $selectedDay");
    }

    int daysDifference = (targetWeekday - currentWeekday) % 7;
    if (daysDifference < 0) {
      daysDifference += 7;
    }

    DateTime nextWeekday = now.add(Duration(days: daysDifference));
    return DateTime(nextWeekday.year, nextWeekday.month, nextWeekday.day,
        timeOfDay.hour, timeOfDay.minute);
  }

  void setAlarm(DateTime dateTime, String title, int index) async {
    final alarmSettings = AlarmSettings(
        id: index,
        dateTime: dateTime,
        assetAudioPath: 'assets/alarm.mp3',
        notificationTitle: 'Reminder',
        notificationBody: title,
        enableNotificationOnKill: true,
        androidFullScreenIntent: true);
    await Alarm.set(alarmSettings: alarmSettings);
  }
}
