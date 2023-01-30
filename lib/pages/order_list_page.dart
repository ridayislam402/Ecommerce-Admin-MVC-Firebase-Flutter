
import 'package:ecom_admin/pages/order_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';
import '../utils/contents.dart';
import '../utils/helper_function.dart';

class OrderListPage extends StatelessWidget {
  static const String routeName = '/order_list';

  const OrderListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderFilter = ModalRoute.of(context)!.settings.arguments as OrderFilter;
    final orderList = Provider.of<OrderProvider>(context, listen: false).getFilteredOrderList(orderFilter);
    return Scaffold(
      appBar: AppBar(title: const Text('Order List'),),
      body: ListView.builder(
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          final order = orderList[index];
          return ListTile(
            onTap: () => Navigator.pushNamed(context, OrderDetailsPage.routeName, arguments: order.orderId),
            title: Text(getFormattedDataTime(order.orderDate.timestamp.toDate(), 'dd/MM/yyyy hh:mm:ss a')),
            subtitle: Text(order.orderStatus),
            trailing: Text('$currencySymbol${order.grandTotal}'),
          );
        },
      )
    );
  }
}
