import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_admin/models/product_model.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../utils/contents.dart';
import '../utils/helper_function.dart';

class ProductDetailsPage extends StatelessWidget {
  static const String routeName = '/product_details';

  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pid = ModalRoute
        .of(context)!
        .settings
        .arguments as String;
    final provider = Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('Product Details'),
        ),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: provider.getProductById(pid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final product = ProductModel.fromMap(snapshot.data!.data()!);
              provider.getPurchaseByProduct(pid);
              return ListView(
                children: [
                  FadeInImage.assetNetwork(
                    placeholder: 'images/placeholder.png',
                    image: product.imageUrl,
                    fadeInCurve: Curves.bounceInOut,
                    fadeInDuration: const Duration(seconds: 3),
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          _showRepurchaseBottomSheet(context, (price, qty, dt) {
                            EasyLoading.show(status: 'Please wait...');
                            provider
                                .rePurchase(
                                pid, price, qty, dt, product.category!,
                                product.stock)
                                .then((value) {
                              EasyLoading.dismiss(animation: true);
                              Navigator.pop(context);
                            }).catchError((error) {
                              EasyLoading.dismiss(animation: true);
                              showMsg(context, 'Could not save');
                              throw error;
                            });
                          });
                        },
                        child: const Text('Re-Purchase'),
                      ),
                      TextButton(
                        onPressed: () {
                          _showPurchaseHistoryBottomSheet(context, provider);
                        },
                        child: const Text('Purchase History'),
                      ),
                    ],
                  ),
                  ListTile(
                    title: Text(product.name!),
                    trailing: IconButton(
                      onPressed: () {
                        showUpdateDialog(
                          context: context, desc: product.name, onSave: (value) {
                          provider.updateProduct(product.id!, productName, value);
                          },);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                  ListTile(
                    title: Text(
                        'Sale Price: $currencySymbol${product.salesPrice}'),
                    trailing: IconButton(
                      onPressed: () {
                        showUpdateDialog(
                          context: context, desc: product.salesPrice.toString(),
                          onSave: (value) {
                          provider.updateProduct(product.id!, productSalesPrice, num.parse(value));
                        },);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                  ListTile(
                    title: const Text('Product Description'),
                    subtitle: Text(product.description ?? 'Not Available'),
                    trailing: IconButton(
                      onPressed: () {
                        showUpdateDialog(
                          context: context, desc: product.description!, onSave: (value) {
                          provider.updateProduct(product.id!, productDescription, value);
                        },);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                  SwitchListTile(
                    title: const Text('Available'),
                    value: product.available,
                    onChanged: (value) {
                      provider.updateProduct(
                          product.id!, productAvailable, value);
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Featured'),
                    value: product.featured,
                    onChanged: (value) {
                      provider.updateProduct(
                          product.id!, productFeatured, value);
                    },
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  void _showPurchaseHistoryBottomSheet(BuildContext context,
      ProductProvider provider) {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          ListView.builder(
            itemCount: provider.purchaseListOfSpecificProduct.length,
            itemBuilder: (context, index) {
              final purModel = provider.purchaseListOfSpecificProduct[index];
              return ListTile(
                //textColor: Colors.blue,
                title: Text(getFormattedDataTime(
                    purModel.dateModel.timestamp.toDate(), 'dd/MM/yyyy')),
                subtitle: Text('Quantity: ${purModel.quantity}'),
                trailing: Text(
                    'Purchase Price: $currencySymbol${purModel.price}'),
              );
            },
          ),);
  }

  void _showRepurchaseBottomSheet(BuildContext context,
      Function(num price, num qt, DateTime dt) onSave) {
    final qController = TextEditingController();
    final pController = TextEditingController();
    ValueNotifier<DateTime> _dateTimeNotifier = ValueNotifier(DateTime.now());
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) =>
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 70,),
                TextField(
                  controller: pController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: 'Purchase Price'
                  ),
                ),
                const SizedBox(height: 10,),
                TextField(
                  controller: qController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: 'Quantity'
                  ),
                ),
                Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
                          _dateTimeNotifier.value = await _selectDate(context);
                        },
                        child: const Text('Select purchase Date'),
                      ),
                      Chip(
                        label: ValueListenableBuilder(
                          valueListenable: _dateTimeNotifier,
                          builder: (context, value, child) =>
                              Text(
                                  getFormattedDataTime(value, 'dd/MM/yyyy')
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    onSave(num.parse(pController.text),
                        num.parse(qController.text), _dateTimeNotifier.value);
                    //Navigator.pop(context);
                  },
                  child: const Text('Re-Purchase'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ));
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime.now());

    if (selectedDate != null) {
      return selectedDate;
    }
    return DateTime.now();
  }
}
