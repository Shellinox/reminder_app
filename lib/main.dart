import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/constants.dart';
import 'package:reminder_app/models/data.dart';
import 'package:reminder_app/providers/task_provider.dart';
import 'package:reminder_app/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
  await Hive.openBox("taskBox");
  await Alarm.init();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SetTask(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Reminder App',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontSize: 18,
              color: Constants().primaryTextColor,
            ),
          ),
          timePickerTheme: TimePickerThemeData(
            hourMinuteColor: Constants().primaryColor,
            dayPeriodColor: Constants().primaryColor,
            dialHandColor: Constants().primaryColor,
            cancelButtonStyle: TextButton.styleFrom(
                foregroundColor: Constants().primaryTextColor),
            confirmButtonStyle: TextButton.styleFrom(
                foregroundColor: Constants().primaryTextColor),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Constants().primaryColor),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
