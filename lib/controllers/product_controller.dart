// import 'package:bellybucks/models/product_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
//
// class ProductController extends GetxController {
//   final products = <ProductModel>[].obs;
//
//   @override
//   void onInit() {
//     products.bindStream(FirestoreDB().getAllProducts());
//     super.onInit();
//   }
// }
//
// class FirestoreDB {
//   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//   Stream<List<ProductModel>> getAllProducts() {
//     return _firebaseFirestore
//         .collection('products')
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs
//           .map((doc) => ProductModel.fromsnapshot(doc))
//           .toList();
//     });
//   }
// }
