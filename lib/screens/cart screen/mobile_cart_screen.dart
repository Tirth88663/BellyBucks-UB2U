import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/cart_model.dart';

final key = GlobalKey<_MobileCartScreenState>();

class MobileCartScreen extends StatefulWidget {
  const MobileCartScreen({Key? key}) : super(key: key);
  @override
  State<MobileCartScreen> createState() => _MobileCartScreenState();
}

class _MobileCartScreenState extends State<MobileCartScreen> {
  static int? total;
  int? get tirth => total;
  @override
  void initState() {
    Timer(const Duration(seconds: 1), () {
      print("This code executes after 1 seconds");
      setState(() {});
    });
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffE5413F),
        title: Text(
          "Cart Screen",
          style: GoogleFonts.poppins(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('${FirebaseAuth.instance.currentUser?.uid}')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              int cartTotal = 0;
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    CartModel cartModel = CartModel();
                    User? user = FirebaseAuth.instance.currentUser;
                    final DocumentSnapshot data =
                        streamSnapshot.data!.docs[index];
                    cartTotal +=
                        (data['price'] as int) * (data['quantity'] as int);
                    total = cartTotal;
                    int quantity = data['quantity'];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(data['imageUrl']),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(data['name']),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: Text("${data['price']} ₹"),
                          ),
                          IconButton(
                            onPressed: () async {
                              if (quantity == 1) {
                                await FirebaseFirestore.instance.runTransaction(
                                    (Transaction myTransaction) async {
                                  myTransaction.delete(streamSnapshot
                                      .data!.docs[index].reference);
                                  setState(() {});
                                });
                                setState(() {});
                              } else {
                                quantity -= 1;
                                cartModel.name = data['name'];
                                cartModel.price = data['price'];
                                cartModel.imageUrl = data['imageUrl'];
                                cartModel.quantity = quantity;
                                await FirebaseFirestore.instance
                                    .collection("${user?.uid}")
                                    .doc(data['name'])
                                    .set(cartModel.toMap());
                                setState(() {});
                              }
                            },
                            icon: const Icon(Icons.remove_circle),
                          ),
                          Text('$quantity'),
                          IconButton(
                            onPressed: () async {
                              quantity += 1;
                              cartModel.name = data['name'];
                              cartModel.price = data['price'];
                              cartModel.imageUrl = data['imageUrl'];
                              cartModel.quantity = quantity;
                              await FirebaseFirestore.instance
                                  .collection("${user?.uid}")
                                  .doc(data['name'])
                                  .set(cartModel.toMap());
                              setState(() {});
                            },
                            icon: const Icon(Icons.add_circle),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(color: Color(0xffE5413F)),
              );
            },
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 100, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total : ",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "$total ₹",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
