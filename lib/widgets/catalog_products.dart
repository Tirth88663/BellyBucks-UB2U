// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../controllers/cart_controllers.dart';
// import '../controllers/product_controller.dart';
//
// class CatalogProducts extends StatelessWidget {
//   CatalogProducts({Key? key}) : super(key: key);
//
//   final productController = Get.put(ProductController());
//
//   @override
//   Widget build(BuildContext context) {
//     print(productController.products.length);
//     return SizedBox(
//       height: 500,
//       child: ListView.builder(
//         itemCount: productController.products.length,
//         itemBuilder: (BuildContext context, int index) {
//           return CatalogProductCard(index: index);
//         },
//       ),
//     );
//   }
// }
//
// class CatalogProductCard extends StatelessWidget {
//   final cartController = Get.put(CartController());
//   final ProductController productController = Get.find();
//   final int index;
//   CatalogProductCard({Key? key, required this.index}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         CircleAvatar(
//           radius: 40,
//           backgroundImage: NetworkImage(
//             productController.products[index].imageUrl,
//           ),
//         ),
//         Text(productController.products[index].name),
//         Text("${productController.products[index].price}"),
//         IconButton(
//           onPressed: () {
//             cartController.addProduct(productController.products[index]);
//           },
//           icon: const Icon(
//             Icons.add_circle,
//           ),
//         )
//       ],
//     );
//   }
// }
