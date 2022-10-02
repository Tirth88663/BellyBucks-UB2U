import 'dart:async';
import 'dart:ui';

import 'package:bellybucks/models/category_model.dart';
import 'package:bellybucks/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/cart_controllers.dart';
import '../../models/cart_model.dart';
import '../../models/user_model.dart';
import '../user profile screen/user_screen.dart';

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({Key? key}) : super(key: key);

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  List<ProductModel> productModels = List<ProductModel>.empty(growable: true);
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  static String name = "";
  CategoryModel categoryList = CategoryModel();
  int? selectedIndex;
  // final productController = Get.put(ProductController());
  final cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("categories")
        .doc("categories")
        .get()
        .then((value) {
      categoryList = CategoryModel.fromMap(value.data());
    });

    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return categoryList.categoryList != null
        ? Scaffold(
            extendBody: true,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const UserScreen()),
                    );
                  },
                  icon: const Icon(
                    CupertinoIcons.profile_circled,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            drawer: CustomDrawer(loggedInUser: loggedInUser),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hey, ${loggedInUser.name}",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        Text(
                          "Lets get your Order",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    //SearchBar
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(4, 3),
                              spreadRadius: 0.0,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextField(
                                cursorColor: const Color(0xffE5413F),
                                decoration: InputDecoration(
                                  // prefixIcon: Icon(CupertinoIcons.search),
                                  hintText: "Search Here",

                                  hintStyle: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  name = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: InkWell(
                                  child: const Icon(CupertinoIcons.search,
                                      color: Colors.grey),
                                  onTap: () {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 100,
                      child: Center(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                            categoryList.categoryList!.length,
                            (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  name = categoryList.categoryList![index];
                                });
                              },
                              onDoubleTap: () {
                                setState(() {
                                  selectedIndex = null;
                                  name = "";
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: Container(
                                  constraints:
                                      const BoxConstraints(minWidth: 103),
                                  decoration: BoxDecoration(
                                    color: selectedIndex != null &&
                                            selectedIndex == index
                                        ? const Color(0xffE5413F)
                                        : Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(1, 4),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        categoryList.categoryList![index]
                                            .toString(),
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: selectedIndex != null &&
                                                    selectedIndex == index
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    StreamBuilder(
                      stream: (name != "")
                          ? FirebaseFirestore.instance
                              .collection('products')
                              .where("searchKeywords", arrayContains: name)
                              .snapshots()
                          : FirebaseFirestore.instance
                              .collection('products')
                              .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
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
                                return Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      child: Container(
                                        height: width / 1.220149253731343,
                                        width: width,
                                        color: const Color(0xffE5413F),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      //writing all values
                                                      cartModel.name =
                                                          data['name'];
                                                      cartModel.price =
                                                          data['price'];
                                                      cartModel.imageUrl =
                                                          data['imageUrl'];
                                                      cartModel.quantity = 1;

                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "${user?.uid}")
                                                          .doc(data['name'])
                                                          .set(cartModel
                                                              .toMap());
                                                      Fluttertoast.showToast(
                                                          msg: "Added to Cart");
                                                    },
                                                    icon: const Icon(
                                                      CupertinoIcons
                                                          .heart_circle,
                                                      size: 36,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(30)),
                                                child: SizedBox(
                                                  height: width * 0.5,
                                                  width: width * 0.5,
                                                  child: Image(
                                                    image: NetworkImage(
                                                      data['imageUrl'],
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    data['name'],
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['price']} ₹",
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset("assets/images/unhappy_chef.png",
                                      fit: BoxFit.cover,
                                      height: 150,
                                      width: 150),
                                  Text(
                                    'Sorry\n Item Not Found !',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 22.0,
                                          color: Color(0xffE5413F),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Text(
                                    'Item currently unavaliable\nWe are updating the menu',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 18,
                                          color: Color(0xffE5413F),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                                color: Color(0xffE5413F)),
                          );
                        }
                      },
                    ),

                    // CatalogProducts(),
                  ],
                ),
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(color: Color(0xffE5413F)),
          );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
    required this.loggedInUser,
  }) : super(key: key);

  final UserModel loggedInUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 8.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Color(0xffE5413F)),
            currentAccountPicture: ClipOval(
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
            accountName: Text(
              "${loggedInUser.name}",
              style: GoogleFonts.poppins(),
            ),
            accountEmail: Text(
              "${loggedInUser.email}",
              style: GoogleFonts.poppins(),
            ),
          ),
        ],
      ),
    );
  }
}

// Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// CircleAvatar(
// radius: 40,
// backgroundImage: NetworkImage(
// data['imageUrl'],
// ),
// ),
// Text(data['name']),
// Text("${data['price']}"),
// IconButton(
// onPressed: () async {
// //writing all values
// cartModel.name = data['name'];
// cartModel.price = data['price'];
// cartModel.imageUrl = data['imageUrl'];
// cartModel.quantity = 1;
//
// await FirebaseFirestore.instance
//     .collection("${user?.uid}")
// .doc(data['name'])
// .set(cartModel.toMap());
// Fluttertoast.showToast(
// msg: "Added to Cart");
// },
// icon: const Icon(
// Icons.add_circle,
// ),
// ),
// ],
// )
