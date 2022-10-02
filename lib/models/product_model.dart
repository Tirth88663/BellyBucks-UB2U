class ProductModel {
  // String? key;
  String? name;
  int? price;
  String? imageUrl;
  String? category;

  ProductModel({
    // this.key,
    this.name,
    this.price,
    this.imageUrl,
    this.category,
  });

  factory ProductModel.fromMap(map) {
    return ProductModel(
      // key: map['key'],
      name: map['name'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      category: map['category'],
    );
  }
  //sending data to server
  Map<String, dynamic> toMap() {
    return {
      // 'key': key,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      "searchKeywords": setSearchParam(name!, category),
    };
  }

  setSearchParam(String name, category) {
    List<String> caseSearchList = [];
    String temp = " ";
    caseSearchList.add(temp);
    temp = "";
    for (int i = 0; i < name.length; i++) {
      temp = temp + name[i];
      caseSearchList.add(temp);
    }
    temp = "";
    for (int i = 0; i < category.length; i++) {
      temp = temp + category[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }
}

// static ProductModel fromsnapshot(DocumentSnapshot snap) {
//   ProductModel product = ProductModel(
//     name: snap['name'],
//     price: snap['price'],
//     imageUrl: snap['imageUrl'],
//   );
//   return product;
// }

// static const List<Product> products = [
//   Product(
//     name: "apple",
//     price: 2.00,
//     imageUrl:
//         "https://th.bing.com/th/id/OIP.hVjhVt5EiigNSJr1QK93AAHaIJ?pid=ImgDet&rs=1",
//   ),
//   Product(
//     name: "banana",
//     price: 3.00,
//     imageUrl:
//         "https://th.bing.com/th/id/OIP.VWk3BpwznL_qitkaxUwFcAHaFe?pid=ImgDet&rs=1",
//   ),
//   Product(
//     name: "watermelon",
//     price: 4.00,
//     imageUrl:
//         "https://prod-waitrose-cdn.azureedge.net/media/images/products/2020/05/21876.jpg",
//   )
// ];
