import 'package:ecom_admin/pages/new_product_page.dart';
import 'package:flutter/material.dart';

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
      body: Column(),
    );
  }
}
