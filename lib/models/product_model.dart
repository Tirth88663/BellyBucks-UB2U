class ProductModel {
  // String? key;
  String? name;
  double? price;
  String? imageUrl;

  ProductModel({
    // this.key,
    this.name,
    this.price,
    this.imageUrl,
  });

  factory ProductModel.fromMap(map) {
    return ProductModel(
      // key: map['key'],
      name: map['name'],
      price: map['price'],
      imageUrl: map['imageUrl'],
    );
  }
  //sending data to server
  Map<String, dynamic> toMap() {
    return {
      // 'key': key,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    };
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
  //     name: "watermealon",
  //     price: 4.00,
  //     imageUrl:
  //         "https://prod-waitrose-cdn.azureedge.net/media/images/products/2020/05/21876.jpg",
  //   )
  // ];
}
