import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/constants.dart';
import 'package:reminder_app/models/data.dart';
import 'package:reminder_app/providers/task_provider.dart';
import 'package:reminder_app/widgets/custom_button.dart';

class SetReminderScreen extends StatefulWidget {
  const SetReminderScreen({super.key});

  @override
  State<SetReminderScreen> createState() => _SetReminderScreenState();
}

class _SetReminderScreenState extends State<SetReminderScreen> {
  String selectedActivity = activities.first;
  String selectedDay = daysOfWeek.first;
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<SetTask>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reminder App",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Set Reminder ⏰",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Constants().primaryColor,
                ),
                child: DropdownButtonFormField(
                  iconEnabledColor: Constants().secondaryTextColor,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                          color: Constants().secondaryTextColor, fontSize: 17),
                      label: const Text("Activity"),
                      border: InputBorder.none),
                  value: selectedActivity,
                  items:
                      activities.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    selectedActivity = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Constants().primaryColor,
                ),
                child: DropdownButtonFormField(
                  iconEnabledColor: Constants().secondaryTextColor,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                          color: Constants().secondaryTextColor, fontSize: 17),
                      label: const Text("Day"),
                      border: InputBorder.none),
                  value: selectedDay,
                  items:
                      daysOfWeek.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    selectedDay = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  final TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    setState(() {
                      selectedTime = time;
                    });
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Constants().primaryColor,
                  ),
                  width: double.infinity,
                  height: 85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Time",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      Text(
                        "${selectedTime.hourOfPeriod}:${selectedTime.minute} ${selectedTime.period.name.toUpperCase()}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                  onPressed: () {
                    taskProvider.addTask(
                      Task(
                          task: selectedActivity,
                          time: selectedTime,
                          day: selectedDay),
                    );
                    taskProvider.setAlarm(
                        taskProvider.getDateTime(selectedDay, selectedTime),
                        selectedActivity);
                    taskProvider.updateData();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Reminder is set successfully"),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  title: "Set reminder"),
            ],
          ),
        ),
      ),
    );
  }
}
