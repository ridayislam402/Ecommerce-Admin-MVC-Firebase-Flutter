import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getFormattedDataTime(DateTime dateTime, String pattern) =>
    DateFormat(pattern).format(dateTime);

showMsg(BuildContext context, String msg,) =>
    ScaffoldMessenger
        .of(context)
        .showSnackBar(SnackBar(content: Text(msg)));