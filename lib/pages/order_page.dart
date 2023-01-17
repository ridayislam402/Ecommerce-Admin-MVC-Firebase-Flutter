import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';
import '../utils/contents.dart';

class OrderPage extends StatelessWidget {
  static const String routeName = '/order';
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, provider, child) => ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Today', style: Theme.of(context).textTheme.headline6,),
                    const Divider(height: 2, color: Colors.black,),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text('Total Order', style: TextStyle(color: Colors.grey),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${provider.getTotalOrderByDate(DateTime.now())}', style: const TextStyle(fontSize: 20),),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Total Sale', style: TextStyle(color: Colors.grey),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('$currencySymbol${provider.getTotalSaleByDate(DateTime.now())}', style: const TextStyle(fontSize: 20),),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                       },
                      child: const Text('View All'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Yesterday', style: Theme.of(context).textTheme.headline6,),
                    const Divider(height: 2, color: Colors.black,),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text('Total Order', style: TextStyle(color: Colors.grey),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${provider.getTotalOrderByDate(DateTime.now().subtract(const Duration(days: 1)))}', style: const TextStyle(fontSize: 20),),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Total Sale', style: TextStyle(color: Colors.grey),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('$currencySymbol${provider.getTotalSaleByDate(DateTime.now().subtract(const Duration(days: 1)))}', style: const TextStyle(fontSize: 20),),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {

                      },
                      child: const Text('View All'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Last 7 days', style: Theme.of(context).textTheme.headline6,),
                    const Divider(height: 2, color: Colors.black,),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text('Total Order', style: TextStyle(color: Colors.grey),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${provider.getTotalOrderByDateRange(DateTime.now().subtract(const Duration(days: 7)))}', style: const TextStyle(fontSize: 20),),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Total Sale', style: TextStyle(color: Colors.grey),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('$currencySymbol${provider.getTotalSaleByDateRange(DateTime.now().subtract(const Duration(days: 7)))}', style: const TextStyle(fontSize: 20),),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {

                      },
                      child: const Text('View All'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('This Month', style: Theme.of(context).textTheme.headline6,),
                    const Divider(height: 2, color: Colors.black,),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text('Total Order', style: TextStyle(color: Colors.grey),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${provider.getMonthlyOrders(DateTime.now()).length}', style: const TextStyle(fontSize: 20),),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Total Sale', style: TextStyle(color: Colors.grey),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('$currencySymbol${provider.getTotalSaleByMonth(DateTime.now())}', style: const TextStyle(fontSize: 20),),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {

                      },
                      child: const Text('View All'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('All Time', style: Theme.of(context).textTheme.headline6,),
                    const Divider(height: 2, color: Colors.black,),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text('Total Order', style: TextStyle(color: Colors.grey),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${provider.orderList.length}', style: const TextStyle(fontSize: 20),),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Total Sale', style: TextStyle(color: Colors.grey),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('$currencySymbol${provider.getAllTimeTotalSale()}', style: const TextStyle(fontSize: 20),),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {

                      },
                      child: const Text('View All'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
