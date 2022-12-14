import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';
import '../models/purchase_model.dart';

class DbHelper {
  static const String collectionAdmin = 'Admins';
  static const String collectionCategory = 'Categories';
  static const String collectionProduct = 'Products';
  static const String collectionPurchase = 'Purchase';

  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<bool> isAdmin(String uid) async {
    final snapshot  = await _db.collection(collectionAdmin).doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> addNewCategory(CategoryModel categoryModel){
    final doc = _db.collection(collectionCategory).doc();
    categoryModel.id = doc.id;
    return doc.set(categoryModel.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories(){
    return _db.collection(collectionCategory).snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProduct(){
    return _db.collection(collectionProduct).snapshots();
  }

  static Future<void> addProduct(
      ProductModel productModel,
      PurchaseModel purchaseModel,
      String catId,
      num count
      ){
    final wb = _db.batch();
    final proDoc = _db.collection(collectionProduct).doc();
    final purDoc = _db.collection(collectionPurchase).doc();
    final catDoc = _db.collection(collectionCategory).doc(catId);
    productModel.id = proDoc.id;
    purchaseModel.id = purDoc.id;
    purchaseModel.productId = proDoc.id;
    wb.set(proDoc, productModel.toMap());
    wb.set(purDoc, purchaseModel.toMap());
    wb.update(catDoc, {categoryProductCount : count});
    return wb.commit();
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getProductById(String id) =>
      _db.collection(collectionProduct).doc(id).snapshots();

  static Future<void> updateProduct(String id, Map<String, dynamic> map) {
    return _db.collection(collectionProduct).doc(id)
        .update(map);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getPurchaseByProductId(String id) =>
      _db.collection(collectionPurchase)
          .where(purchaseProductId, isEqualTo: id)
          .snapshots();

  static Future<void> rePurchase(PurchaseModel purchaseModel, CategoryModel catModel, num stock) {
    final wb = _db.batch();
    final doc = _db.collection(collectionPurchase).doc();
    purchaseModel.id = doc.id;
    wb.set(doc, purchaseModel.toMap());
    final catDoc = _db.collection(collectionCategory).doc(catModel.id);
    wb.update(catDoc, {categoryProductCount : catModel.productCount});
    final proDoc = _db.collection(collectionProduct).doc(purchaseModel.productId);
    wb.update(proDoc, {productStock : (stock + purchaseModel.quantity)});
    return wb.commit();
  }
}