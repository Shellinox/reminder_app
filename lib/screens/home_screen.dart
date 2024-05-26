import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/providers/task_provider.dart';
import 'package:reminder_app/screens/set_reminder_screen.dart';
import 'package:reminder_app/widgets/custom_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var taskBox = Hive.box("taskBox");
    final taskProvider = Provider.of<SetTask>(context);
    final tasks = taskBox.get("TASKS") == null ? [] : taskProvider.loadData();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Alarm.stop(26);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SetReminderScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Tasks"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: tasks.isEmpty
            ? const Center(
                child: Text(
                  "No reminders yet. Tap on the + button to add a reminder",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
              )
            : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return CustomContainer(
                    title: task.day,
                    content: task.task,
                    icon: Icons.delete,
                    time: task.time,
                    index: index,
                  );
                },
              ),
      ),
    );
  }
}
