import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/user_model.dart';
import '../user profile screen/user_screen.dart';

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({Key? key}) : super(key: key);

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String name = "";
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                MaterialPageRoute(builder: (context) => const UserScreen()),
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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
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
              Container(
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
              const SizedBox(height: 40),
              // Container(
              //   height: 200,
              //   width: 500,
              //   color: Colors.white,
              //   child: ListView(
              //     physics: const BouncingScrollPhysics(),
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     children: [
              //       Container(
              //         height: 100,
              //         width: 95,
              //         decoration: const BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.all(
              //             Radius.circular(20),
              //           ),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.grey,
              //               offset: Offset(5, 5),
              //               spreadRadius: 3,
              //               blurRadius: 4,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(
                    10,
                    (index) => Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: SizedBox(
                        height: 147,
                        width: 95,
                        child: Center(
                          child: Text("item $index"),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
      backgroundColor: const Color(0xffE5413F),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
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
