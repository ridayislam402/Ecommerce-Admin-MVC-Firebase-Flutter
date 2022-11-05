import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_admin/models/date_model.dart';
import 'package:ecom_admin/models/product_model.dart';
import 'package:ecom_admin/models/purchase_model.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../utils/helper_function.dart';

class NewProductPage extends StatefulWidget {
  static const String routeName = '/newproduct';

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  String? _category;
  late ProductProvider _productProvider;

  // const NewProductPage({Key? key}) : super(key: key);
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productSalePriceController = TextEditingController();
  final productPurchasePriceController = TextEditingController();
  final productQuantityController = TextEditingController();

  final formkey = GlobalKey<FormState>();
  DateTime? _productPurchaseDate;
  String? _localImagePath;
  ImageSource _imageSource = ImageSource.camera;

  @override
  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context,listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    productNameController.dispose();
    productDescriptionController.dispose();
    productSalePriceController.dispose();
    productPurchasePriceController.dispose();
    productQuantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Product'),
        actions: [
          TextButton(onPressed: _saveProduct
          , child: Text('Save',
            style: TextStyle(color: Colors.white)))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: productNameController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Product Name'),
                    prefixIcon: Icon(Icons.email),
                    filled: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: productPurchasePriceController,
                      decoration: const InputDecoration(
                          labelText: 'Purchase price',
                          prefixIcon: Icon(Icons.attach_money),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: productSalePriceController,
                      decoration: const InputDecoration(
                          labelText: 'Sale price',
                          prefixIcon: Icon(Icons.price_change),
                          border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: productQuantityController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Quantity',
                        prefixIcon: Icon(Icons.production_quantity_limits),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Consumer<ProductProvider>(
                          builder: (context, provider, child) =>
                              DropdownButtonFormField(
                            hint: Text('Select'),
                            icon: Icon(Icons.arrow_drop_down),
                            value: _category,
                            items: provider.categoryList
                                .map((model) => DropdownMenuItem<String>(
                                    value: model.name, child: Text(model.name!)))
                                .toList(),
                            onChanged: (val) {
                              _category = val;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                controller: productDescriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Product Description',
                  prefixIcon: Icon(Icons.description),
                ),
                minLines: 2,
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty!';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () => _selectDate(),
                        child: Text('Select purchase Date')),
                    Chip(
                        label: Text(_productPurchaseDate == null
                            ? 'No Data Chosen'
                            : getFormattedDataTime(
                                _productPurchaseDate!, 'dd/MM/yyyy')))
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: _localImagePath == null
                          ? const Icon(
                              Icons.photo,
                              size: 110,
                            )
                          : Image.file(
                              File(_localImagePath!),
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          _imageSource = ImageSource.camera;
                          _getImage();
                        },
                        icon: Icon(Icons.camera),
                        label: Text('Camera'),
                      ),
                      SizedBox(width: 10,),
                      TextButton.icon(
                        onPressed: () {
                          
                        },
                        icon: Icon(Icons.photo),
                        label: Text('Gallery'),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _selectDate() async {
    final selectDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2030),
    );

    if (selectDate != null) {
      setState(() {
        _productPurchaseDate = selectDate;
      });
    }
  }

  void _getImage() async{
    final selectedImage = await ImagePicker().pickImage(source: _imageSource,imageQuality: 75);
    if(selectedImage != null){
      setState(() {
        _localImagePath = selectedImage.path;
      });
    }
  }

  void _saveProduct() async{
    if(_localImagePath == null){
      showMsg(context, 'Please select a purchase date');
    }
    if(_localImagePath == null){
      showMsg(context, 'Please select an image');
    }

    if(formkey.currentState!.validate()){
      EasyLoading.show(status: 'loading...');
      final imageUrl = await _productProvider.uploadImage(_localImagePath!);
      final productModel = ProductModel(
        name: productNameController.text,
        category: _category!,
        description: productDescriptionController.text,
        salesPrice: num.parse(productSalePriceController.text),
        stock: num.parse(productQuantityController.text),
        imageUrl: imageUrl,
      );
      final purchaseModel = PurchaseModel(
        dateModel: DateModel(
          timestamp: Timestamp.fromDate(_productPurchaseDate!),
          day: _productPurchaseDate!.day,
          month: _productPurchaseDate!.month,
          year: _productPurchaseDate!.year,
        ),
        price: num.parse(productPurchasePriceController.text),
        quantity: num.parse(productQuantityController.text),
      );
      _productProvider.addNewProduct(productModel, purchaseModel)
          .then((value) {
        EasyLoading.dismiss();
        _resetFields();
      }).catchError((){});
    }
  }

  void _resetFields() {
    setState(() {
      productNameController.clear();
      productDescriptionController.clear();
      productPurchasePriceController.clear();
      productSalePriceController.clear();
      productQuantityController.clear();
      _category = null;
      _productPurchaseDate = null;
      _localImagePath = null;
    });
  }
}
