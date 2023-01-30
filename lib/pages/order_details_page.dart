import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../customwidgets/order_status_view.dart';
import '../models/order_model.dart';
import '../providers/order_provider.dart';
import '../utils/contents.dart';
import '../utils/helper_function.dart';

class OrderDetailsPage extends StatelessWidget {
  static const String routeName = '/order_details';

  const OrderDetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final orderId = ModalRoute.of(context)!.settings.arguments as String;
    final orderModel = orderProvider.getOrderById(orderId);
    orderProvider.getOrderDetails(orderModel.orderId!);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Products',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          productSection(orderProvider),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Order Details',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          orderDetailsSection(orderProvider, orderModel),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Order Status',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          OrderStatusView(
            status: orderModel.orderStatus,
            onStatusChanged: (status) {
              EasyLoading.show(status: 'Updating status');
              orderProvider.updateOrderStatus(orderId, status)
              .then((value) {
                EasyLoading.dismiss();
                showMsg(context, 'Updated');
              })
              .catchError((error) {
                EasyLoading.dismiss();
              });
            },
          ),
        ],
      ),
    );
  }

  Card productSection(OrderProvider orderProvider) {
    return Card(
      elevation: 5,
      child: Column(
        children: orderProvider.orderDetailsOfSpecificOrder
            .map((cartM) => ListTile(
                  dense: true,
                  title: Text(cartM.productName!),
                  trailing: Text(
                      '${cartM.quantity}x$currencySymbol${cartM.salePrice}'),
                ))
            .toList(),
      ),
    );
  }

  Widget orderDetailsSection(
      OrderProvider orderProvider, OrderModel orderModel) {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          ListTile(
            title: const Text('Discount'),
            trailing: Text('${orderModel.discount}%'),
          ),
          ListTile(
            title: const Text('VAT'),
            trailing: Text('${orderModel.vat}%'),
          ),
          ListTile(
            title: const Text('Delivery Charge'),
            trailing: Text('${orderModel.deliveryCharge}%'),
          ),
          ListTile(
            title: const Text('Grand Total'),
            trailing: Text('$currencySymbol${orderModel.grandTotal}%'),
          ),
        ],
      ),
    );
  }

  Widget orderStatusSection(
      OrderProvider orderProvider, OrderModel orderModel) {
    return Card(
      elevation: 5,
      child: Column(),
    );
  }
}
