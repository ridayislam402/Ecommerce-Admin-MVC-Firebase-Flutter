import 'package:ecom_admin/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  static const String routeName = '/category';

  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCategoryDialog(context);
        },
        child: Icon(Icons.add),
      ),
      body: Consumer<ProductProvider>(builder: (context, provider, child) =>
      provider.categoryList.isEmpty ?
      Text('No item found') :
      ListView.builder(
        itemCount: provider.categoryList.length,
        itemBuilder: (context, index) {
          final category = provider.categoryList[index];
          return ListTile(
            title: Text('${category.name} (${category.productCount})'),
          );
        },
      ),),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ADD CATEGORY'),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: 'Enter new category',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text('Close'),
          ),
          TextButton(onPressed: () {
            if(nameController.text.isEmpty) return;
            Navigator.pop(context);
            Provider.of<ProductProvider>(context, listen: false).addCategory(nameController.text);
          }, child: Text('ADD'))
        ],
      )
    );
  }
}
