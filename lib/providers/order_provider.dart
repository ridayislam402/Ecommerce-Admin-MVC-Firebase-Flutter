import 'package:ecom_admin/models/order_constants_model.dart';
import 'package:flutter/material.dart';

import '../db/db_helper.dart';

class OrderProvider extends ChangeNotifier{
  OrderConstantsModel orderConstantsModel = OrderConstantsModel();


  Future<void> getOrderConstants() async {
    DbHelper.getOrderConstants().listen((snapshot) {
      if(snapshot.exists) {
        orderConstantsModel = OrderConstantsModel.fromMap(snapshot.data()!);
        notifyListeners();
      }
    });

  }
}