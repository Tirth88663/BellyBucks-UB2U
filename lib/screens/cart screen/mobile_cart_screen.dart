import 'dart:async';

import 'package:bellybucks/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../models/cart_model.dart';
import '../../models/order_model.dart';
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
  ProductModel productModel = ProductModel();
  OrderModel orderModel = OrderModel();
  Map<String, int> products = {};

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

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment
    var collection = FirebaseFirestore.instance.collection('${user?.uid}');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
      setState(() {});
    }
    total = 0;
    Fluttertoast.showToast(msg: "Payment Done Successfully");

    orderModel.customerName = loggedInUser.name;
    orderModel.mobileNumber = loggedInUser.mobileNumber;
    orderModel.products = products;

    await FirebaseFirestore.instance
        .collection("orders")
        .doc("${user?.uid}")
        .set(orderModel.toMap());
    Fluttertoast.showToast(msg: "Order placed Successfully");
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
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 1.5,
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xffE5413F),
        title: Text(
          "Basket",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
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
                  if (streamSnapshot.data!.docs.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
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
                        products[data['name']] = quantity;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 10),
                          child: Container(
                            height: width * 0.35,
                            width: width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(2, 2),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    child: SizedBox(
                                      height: width * 0.25,
                                      width: width * 0.25,
                                      child: Image(
                                        image: NetworkImage(
                                          data['imageUrl'],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        data['name'],
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              if (quantity == 1) {
                                                quantity -= 1;
                                                cartModel.name = data['name'];
                                                cartModel.price = data['price'];
                                                cartModel.imageUrl =
                                                    data['imageUrl'];
                                                cartModel.quantity = quantity;
                                                await FirebaseFirestore.instance
                                                    .collection("${user?.uid}")
                                                    .doc(data['name'])
                                                    .set(cartModel.toMap());
                                                setState(() {});
                                                await FirebaseFirestore.instance
                                                    .runTransaction((Transaction
                                                        myTransaction) async {
                                                  myTransaction.delete(
                                                      streamSnapshot
                                                          .data!
                                                          .docs[index]
                                                          .reference);
                                                  setState(() {});
                                                });
                                                setState(() {});
                                              } else {
                                                quantity -= 1;
                                                cartModel.name = data['name'];
                                                cartModel.price = data['price'];
                                                cartModel.imageUrl =
                                                    data['imageUrl'];
                                                cartModel.quantity = quantity;
                                                await FirebaseFirestore.instance
                                                    .collection("${user?.uid}")
                                                    .doc(data['name'])
                                                    .set(cartModel.toMap());
                                                setState(() {});
                                              }
                                            },
                                            icon:
                                                const Icon(Icons.remove_circle),
                                          ),
                                          Text(
                                            '$quantity',
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              quantity += 1;
                                              cartModel.name = data['name'];
                                              cartModel.price = data['price'];
                                              cartModel.imageUrl =
                                                  data['imageUrl'];
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
                                      )
                                    ],
                                  ),
                                  const Spacer(flex: 1),
                                  Text(
                                    "${data['price']} ₹",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 56),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/images/empty_cart.PNG",
                              fit: BoxFit.cover,
                              height: 300.0,
                              width: 300.0,
                              color: const Color(0xffE5413F),
                              colorBlendMode: BlendMode.hue,
                            ),
                            Text(
                              'Your cart is empty !',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 24,
                                    color: Color(0xffE5413F),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 40, left: 40, top: 8),
                              child: Text(
                                "Looks like you haven't decided your menu yet",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 20,
                                      color: Color(0xffE5413F),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
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
                      if (total != 0) {
                        var options = {
                          'key': 'rzp_test_hWuiPIOF6PwuKv',
                          'amount': (total! *
                              100), //in the smallest currency sub-unit.
                          'name': '${loggedInUser.name}',
                          'description': 'Thanks for Ordering',
                          'timeout': 300, // in seconds
                          'prefill': {
                            'contact': '${loggedInUser.mobileNumber}',
                            'email': '${loggedInUser.email}',
                          }
                        };
                        _razorpay.open(options);
                      } else {
                        Fluttertoast.showToast(
                            msg: "Can't proceed Your basket is empty");
                      }
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
      ),
    );
  }
}

// Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 24,
// vertical: 10,
// ),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// CircleAvatar(
// radius: 40,
// backgroundImage:
// NetworkImage(data['imageUrl']),
// ),
// const SizedBox(width: 20),
// Expanded(
// child: Text(data['name']),
// ),
// const SizedBox(width: 30),
// Expanded(
// child: Text("${data['price']} ₹"),
// ),
// IconButton(
// onPressed: () async {
// if (quantity == 1) {
// quantity -= 1;
// cartModel.name = data['name'];
// cartModel.price = data['price'];
// cartModel.imageUrl = data['imageUrl'];
// cartModel.quantity = quantity;
// await FirebaseFirestore.instance
//     .collection("${user?.uid}")
//     .doc(data['name'])
//     .set(cartModel.toMap());
// setState(() {});
// await FirebaseFirestore.instance
//     .runTransaction((Transaction
// myTransaction) async {
// myTransaction.delete(streamSnapshot
//     .data!.docs[index].reference);
// setState(() {});
// });
// setState(() {});
// } else {
// quantity -= 1;
// cartModel.name = data['name'];
// cartModel.price = data['price'];
// cartModel.imageUrl = data['imageUrl'];
// cartModel.quantity = quantity;
// await FirebaseFirestore.instance
//     .collection("${user?.uid}")
//     .doc(data['name'])
//     .set(cartModel.toMap());
// setState(() {});
// }
// },
// icon: const Icon(Icons.remove_circle),
// ),
// Text('$quantity'),
// IconButton(
// onPressed: () async {
// quantity += 1;
// cartModel.name = data['name'];
// cartModel.price = data['price'];
// cartModel.imageUrl = data['imageUrl'];
// cartModel.quantity = quantity;
// await FirebaseFirestore.instance
//     .collection("${user?.uid}")
// .doc(data['name'])
// .set(cartModel.toMap());
// setState(() {});
// },
// icon: const Icon(Icons.add_circle),
// ),
// ],
// ),
// )
