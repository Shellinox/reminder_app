import 'package:flutter/material.dart';

Future customDialog(
    {required BuildContext context,
    required String title,
    required String content,
    required List<Widget> actions}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: actions,
        );
      });
}
