import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/cart_model.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffE5413F),
        title: Text(
          "All Products",
          style: GoogleFonts.poppins(),
        ),
        titleSpacing: 1.5,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            // var map = streamSnapshot.data?.docs;
            // productModels.clear();
            // map?.forEach((element) {
            //   var productModel = ProductModel.fromMap(map);
            //   productModels.add(productModel);
            // });
            return ListView.builder(
              shrinkWrap: true,
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                CartModel cartModel = CartModel();
                User? user = FirebaseAuth.instance.currentUser;
                final DocumentSnapshot data = streamSnapshot.data!.docs[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          data['imageUrl'],
                        )),
                    Text(data['name']),
                    Text("${data['price']}"),
                    IconButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .runTransaction((Transaction myTransaction) async {
                          myTransaction.delete(
                              streamSnapshot.data!.docs[index].reference);
                        });
                      },
                      icon: const Icon(
                        Icons.delete_rounded,
                      ),
                    )
                  ],
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(color: Color(0xffE5413F)),
          );
        },
      ),
    ));
  }
}
