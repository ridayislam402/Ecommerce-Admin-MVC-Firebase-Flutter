import 'package:ecom_admin/models/order_constants_model.dart';
import 'package:ecom_admin/models/order_model.dart';
import 'package:flutter/material.dart';

import '../db/db_helper.dart';

class OrderProvider extends ChangeNotifier{
  List<OrderModel> orderList = [];
  OrderConstantsModel orderConstantsModel = OrderConstantsModel();


  void getAllOrders() {
    DbHelper.getAllOrders().listen((event) {
      orderList = List.generate(event.docs.length, (index) =>
          OrderModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  Future<void> getOrderConstants() async {
    DbHelper.getOrderConstants().listen((snapshot) {
      if(snapshot.exists) {
        orderConstantsModel = OrderConstantsModel.fromMap(snapshot.data()!);
        notifyListeners();
      }
    });

  }

  num getTotalOrderByDate(DateTime dateTime) {
    final filteredList = orderList.where((element) =>
    element.orderDate.day == dateTime.day &&
        element.orderDate.month == dateTime.month &&
        element.orderDate.year == dateTime.year)
        .toList();
    return filteredList.length;
  }

  num getTotalSaleByDate(DateTime dateTime) {
    num total = 0;
    final filteredList = orderList.where((element) =>
    element.orderDate.day == dateTime.day &&
        element.orderDate.month == dateTime.month &&
        element.orderDate.year == dateTime.year)
        .toList();
    for(var order in filteredList) {
      total += order.grandTotal;
    }
    return total.round();
  }

  num getTotalOrderByDateRange(DateTime dateTime) {
    final filteredList = orderList.where((element) =>
        element.orderDate.timestamp.toDate().isAfter(dateTime))
        .toList();
    return filteredList.length;
  }

  num getTotalSaleByDateRange(DateTime dateTime) {
    num total = 0;
    final filteredList = orderList.where((element) =>
        element.orderDate.timestamp.toDate().isAfter(dateTime))
        .toList();
    for(var order in filteredList) {
      total += order.grandTotal;
    }
    return total.round();
  }

  List<OrderModel> getMonthlyOrders(DateTime dateTime) {
    final filteredList = orderList.where((element) =>
    element.orderDate.month == dateTime.month &&
        element.orderDate.year == dateTime.year)
        .toList();
    return filteredList;
  }

  num getTotalSaleByMonth(DateTime dateTime) {
    num total = 0;
    final filteredList = getMonthlyOrders(dateTime);
    for(var order in filteredList) {
      total += order.grandTotal;
    }
    return total.round();
  }

  num getAllTimeTotalSale() {
    num total = 0;
    for(var order in orderList) {
      total += order.grandTotal;
    }
    return total.round();
  }
}