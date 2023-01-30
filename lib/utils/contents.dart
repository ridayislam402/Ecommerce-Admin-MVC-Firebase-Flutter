import 'package:flutter/material.dart';
const String currencySymbol = '৳';
const Color appBarColor = Color.fromARGB(255, 11, 11, 44);

abstract class OrderStatus {
  static const String pending = 'Pending';
  static const String processing = 'Processing';
  static const String delivered = 'Delivered';
  static const String cancelled = 'Cancelled';
}

enum OrderFilter {
  TODAY, YESTERDAY, SEVEN_DAYS, THIS_MONTH, ALL_TIME
}
