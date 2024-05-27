import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/constants.dart';
import 'package:reminder_app/providers/task_provider.dart';
import 'package:reminder_app/shared_widgets/custom_dialog.dart';

class CustomContainer extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final TimeOfDay time;
  final int index;
  const CustomContainer(
      {super.key,
      required this.title,
      required this.content,
      required this.icon,
      required this.time,
      required this.index});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<SetTask>(context);
    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Constants().primaryColor,
      ),
      width: double.infinity,
      height: 85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content,
                    style: TextStyle(
                        color: Constants().primaryTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Text(
                        "${time.hourOfPeriod}:${time.minute} ${time.period.name.toUpperCase()}",
                        style: TextStyle(
                          color: Constants().secondaryTextColor,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          color: Constants().secondaryTextColor,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              IconButton(
                onPressed: () {
                  customDialog(
                      context: context,
                      title: "Delete?",
                      content: "Are you sure you want to delete this task?",
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Constants().primaryColor),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            taskProvider.removeTask(index);
                            Alarm.stop(index+1);
                            taskProvider.updateData();
                            
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Confirm",
                            style: TextStyle(color: Constants().primaryColor),
                          ),
                        ),
                      ]);
                },
                icon: Icon(
                  icon,
                  color: Constants().primaryTextColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
