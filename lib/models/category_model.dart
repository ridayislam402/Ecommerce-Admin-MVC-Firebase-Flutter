const String categoryId = 'id';
const String categoryName = 'name';
const String categoryAvailable = 'available';
const String categoryProductCount = 'productCount';

class CategoryModel{
  String? id, name;
  num productCount;
  bool available;

  CategoryModel({this.id, this.name, this.productCount = 0, this.available = true});

  Map<String, dynamic> toMap(){
    return<String, dynamic>{
      categoryId : id,
      categoryName : name,
      categoryProductCount : productCount,
      categoryAvailable : available,
    };
  }
}