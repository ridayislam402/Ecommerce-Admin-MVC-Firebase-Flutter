import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getFormattedDataTime(DateTime dateTime, String pattern) =>
    DateFormat(pattern).format(dateTime);

showMsg(BuildContext context, String msg,) =>
    ScaffoldMessenger
        .of(context)
        .showSnackBar(SnackBar(content: Text(msg)));

void showUpdateDialog({
  required BuildContext context,
  required String desc,
  required Function(String) onSave,
}) {
  final _descController = TextEditingController();
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Update $desc'),
      content: Padding(
        padding: EdgeInsets.all(8),
        child: TextField(
          controller: _descController,
          decoration: InputDecoration(
            hintText: 'Enter New $desc',
            filled: true,
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text('Cancel')),
        ElevatedButton(onPressed: () {
          if(_descController.text.isEmpty)return;
          final value = _descController.text;
          onSave(value);
          Navigator.pop(context);
        }, child: Text('Update'))
      ],
    ),
  );
}