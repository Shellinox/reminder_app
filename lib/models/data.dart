import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

part 'data.g.dart';


final List<String> daysOfWeek = [
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday'
];
final List<String> activities = [
  'Wake up',
  'Go to gym',
  'Breakfast',
  'Meetings',
  'Lunch',
  'Quick nap',
  'Go to library',
  'Dinner',
  'Go to sleep'
];

@HiveType(typeId: 1)
class Task {

  @HiveField(0)
  final String task;

  @HiveField(1)
  final TimeOfDay time;

  @HiveField(2)
  final String day;

  Task({
    required this.task,
    required this.time,
    required this.day,
  });
}
