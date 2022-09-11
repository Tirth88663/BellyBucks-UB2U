import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String name;
  final double price;
  final String imageUrl;

  const ProductModel({
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  static ProductModel fromsnapshot(DocumentSnapshot snap) {
    ProductModel product = ProductModel(
      name: snap['name'],
      price: snap['price'],
      imageUrl: snap['imageUrl'],
    );
    return product;
  }

  // static const List<ProductModel> products = [
  //   ProductModel(
  //     name: "apple",
  //     price: 2.00,
  //     imageUrl:
  //         "https://th.bing.com/th/id/OIP.hVjhVt5EiigNSJr1QK93AAHaIJ?pid=ImgDet&rs=1",
  //   ),
  //   ProductModel(
  //     name: "banana",
  //     price: 3.00,
  //     imageUrl:
  //         "https://th.bing.com/th/id/OIP.VWk3BpwznL_qitkaxUwFcAHaFe?pid=ImgDet&rs=1",
  //   ),
  //   ProductModel(
  //     name: "watermealon",
  //     price: 4.00,
  //     imageUrl:
  //         "https://prod-waitrose-cdn.azureedge.net/media/images/products/2020/05/21876.jpg",
  //   )
  // ];
}
