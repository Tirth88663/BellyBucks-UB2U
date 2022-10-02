class CategoryModel {
  List? categoryList;

  CategoryModel({this.categoryList});

  factory CategoryModel.fromMap(map) {
    return CategoryModel(
      categoryList: map['categoryList'],
    );
  }
}
