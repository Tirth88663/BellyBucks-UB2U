import 'package:bellybucks/controllers/cart_controllers.dart';
import 'package:bellybucks/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: ProductModel.products.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(index: index);
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final cartController = Get.put(CartController());
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
            ProductModel.products[index].imageUrl,
          ),
        ),
        Text(ProductModel.products[index].name),
        Text("${ProductModel.products[index].price}"),
        IconButton(
          onPressed: () {
            cartController.addProduct(ProductModel.products[index]);
          },
          icon: const Icon(
            Icons.add_circle,
          ),
        )
      ],
    );
  }
}
