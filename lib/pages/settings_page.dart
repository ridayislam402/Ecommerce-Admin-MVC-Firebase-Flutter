import 'package:ecom_admin/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/contents.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = '/setting';
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Settings'),),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          Consumer<OrderProvider>(builder: (context, provider, _) => Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Settings', style: Theme.of(context).textTheme.headline6,),
                  const Divider(height: 1.5, color: Colors.black,),
                  Text('Delivery Charge: $currencySymbol ${provider.orderConstantsModel.deliveryCharge}'),
                  Text('Discount: ${provider.orderConstantsModel.discount}%'),
                  Text('VAT: ${provider.orderConstantsModel.vat}%'),
                ],
              ),
            ),
          ),)
        ],
      ),
    );
  }
}
