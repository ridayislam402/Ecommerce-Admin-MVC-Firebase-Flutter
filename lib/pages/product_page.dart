import 'package:ecom_admin/pages/new_product_page.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  static const String routeName = '/product';
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product'),),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushNamed(context, NewProductPage.routeName);
      },
      child: Icon(Icons.add),),
      body: Consumer<ProductProvider>(builder: (context, provider, child) =>
        provider.productList.isEmpty?
        Text('No item found')
        :ListView.builder(
            itemCount: provider.productList.length,
            itemBuilder: (context, index) {
              final products = provider.productList[index];
              return ListTile(
                title: Text(products.name!),
                trailing: Text('stock : ${products.stock}'),
              );
            },),)
    );
  }
}
