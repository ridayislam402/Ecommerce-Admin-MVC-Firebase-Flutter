import 'package:ecom_admin/db/db_helper.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';

class ProductProvider extends ChangeNotifier{
  List<CategoryModel> categoryList = [];


  Future<void> addCategory(String categoryName){
    final categoryModel = CategoryModel(name: categoryName);
    return DbHelper.addNewCategory(categoryModel);
  }
}