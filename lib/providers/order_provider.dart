import 'package:ecom_admin/models/order_constants_model.dart';
import 'package:ecom_admin/models/order_model.dart';
import 'package:flutter/material.dart';

import '../db/db_helper.dart';
import '../models/cart_model.dart';
import '../utils/contents.dart';

class OrderProvider extends ChangeNotifier{
  List<OrderModel> orderList = [];
  List<CartModel> orderDetailsOfSpecificOrder = [];
  OrderConstantsModel orderConstantsModel = OrderConstantsModel();


  void getAllOrders() {
    DbHelper.getAllOrders().listen((event) {
      orderList = List.generate(event.docs.length, (index) =>
          OrderModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  void getOrderDetails(String orderId) async {
    final snapshot = await DbHelper.getOrderDetails(orderId);
    orderDetailsOfSpecificOrder =
        List.generate(snapshot.docs.length, (index) =>
            CartModel.fromMap(snapshot.docs[index].data()));
    notifyListeners();
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

  Future<void> addOrderConstants(OrderConstantsModel model) =>
      DbHelper.addOrderConstants(model);


  OrderModel getOrderById(String orderId) =>
      orderList.firstWhere((element) => element.orderId == orderId);



  Future<void> updateOrderStatus(String orderId, String status) {
    return DbHelper.updateOrderStatus(orderId, status);
  }

  List<OrderModel> getFilteredOrderList(OrderFilter filter) {
    var filteredList = <OrderModel>[];
    switch(filter) {
      case OrderFilter.TODAY:
        filteredList = orderList.where((element) =>
        element.orderDate.day == DateTime.now().day &&
            element.orderDate.month == DateTime.now().month &&
            element.orderDate.year == DateTime.now().year)
            .toList();
        break;
      case OrderFilter.YESTERDAY:
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        filteredList = orderList.where((element) =>
        element.orderDate.day == yesterday.day &&
            element.orderDate.month == yesterday.month &&
            element.orderDate.year == yesterday.year)
            .toList();
        break;
      case OrderFilter.SEVEN_DAYS:
        final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
        filteredList = orderList.where((element) =>
            element.orderDate.timestamp.toDate().isAfter(sevenDaysAgo))
            .toList();
        break;
      case OrderFilter.THIS_MONTH:
        filteredList = getMonthlyOrders(DateTime.now());
        break;
      case OrderFilter.ALL_TIME:
        filteredList = orderList;
        break;
    }
    return filteredList;
  }
}