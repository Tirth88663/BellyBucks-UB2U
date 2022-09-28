import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../models/cart_model.dart';
import '../../models/user_model.dart';

final key = GlobalKey<_MobileCartScreenState>();

class MobileCartScreen extends StatefulWidget {
  const MobileCartScreen({Key? key}) : super(key: key);
  @override
  State<MobileCartScreen> createState() => _MobileCartScreenState();
}

class _MobileCartScreenState extends State<MobileCartScreen> {
  static int? total;
  final _razorpay = Razorpay();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    Timer(const Duration(seconds: 1), () {
      setState(() {});
    });
    setState(() {});
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
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
              if (!streamSnapshot.hasData) {
                cartTotal = 0;
                total = 0;
              }
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
              } else {
                cartTotal = 0;
                total = 0;
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xffE5413F)),
                );
              }
            },
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 80, left: 16, right: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total : ",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        "$total ₹",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    var options = {
                      'key': 'rzp_test_hWuiPIOF6PwuKv',
                      'amount':
                          (total! * 100), //in the smallest currency sub-unit.
                      'name': '${loggedInUser.name}',
                      'description': 'Thanks for Ordering',
                      'timeout': 300, // in seconds
                      'prefill': {
                        'contact': '${loggedInUser.mobileNumber}',
                        'email': '${loggedInUser.email}',
                      }
                    };

                    _razorpay.open(options);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: const Color(0xffE5413F),
                      height: 50,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Proceed to checkout",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.arrow_forward_ios_rounded,
                                color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
