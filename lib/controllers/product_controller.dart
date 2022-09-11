import 'package:bellybucks/models/product_model.dart';
import 'package:bellybucks/services/firestore_db.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final products = <ProductModel>[].obs;

  @override
  void onInit() {
    products.bindStream(FirestoreDB().getAllProducts());
    super.onInit();
  }
}
