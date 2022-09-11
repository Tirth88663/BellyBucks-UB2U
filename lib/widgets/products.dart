import 'package:bellybucks/controllers/cart_controllers.dart';
import 'package:bellybucks/controllers/product_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Products extends StatelessWidget {
  final productController = Get.put(ProductController());
  Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 500,
        child: ListView.builder(
          itemCount: productController.products.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductCard(index: index);
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final cartController = Get.put(CartController());
  final ProductController productController = Get.find();
  final int index;
  ProductCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(
            productController.products[index].imageUrl,
          ),
        ),
        Text(productController.products[index].name),
        Text("${productController.products[index].price}"),
        IconButton(
          onPressed: () {
            cartController.addProduct(productController.products[index]);
          },
          icon: const Icon(
            Icons.add_circle,
          ),
        )
      ],
    );
  }
}
