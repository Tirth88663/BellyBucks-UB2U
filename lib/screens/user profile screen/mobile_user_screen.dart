import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/user_model.dart';
import '../forgot_password_screen.dart';
import '../login screen/login_screen.dart';

class MobileUserScreen extends StatefulWidget {
  const MobileUserScreen({Key? key}) : super(key: key);

  @override
  State<MobileUserScreen> createState() => _MobileUserScreenState();
}

class _MobileUserScreenState extends State<MobileUserScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

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
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Container(
                    height: 228,
                    width: width,
                    decoration: const BoxDecoration(
                      color: Color(0xffE5413F),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                          offset: Offset(0, 5),
                        )
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/food_doodle_3.png",
                      fit: BoxFit.cover,
                      color: Colors.white.withOpacity(0.3),
                      colorBlendMode: BlendMode.modulate,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      height: 188,
                      child: Column(
                        children: [
                          const SizedBox(height: 56),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: Container(
                                  color: Colors.white,
                                  child: Image.asset(
                                    "assets/images/red_user_icon.png",
                                    height: 80,
                                    width: 80,
                                    scale: 2,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Welcome, ",
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          letterSpacing: 1,
                                        ),
                                      )),
                                  const SizedBox(height: 8),
                                  Text("${loggedInUser.name}",
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          letterSpacing: 1,
                                        ),
                                      )),
                                ],
                              ),
                              const SizedBox(width: 24),
                              GestureDetector(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 25,
                                    width: 70,
                                    color: Colors.white,
                                    child: Center(
                                      child: Text("Edit",
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black,
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 24, right: 16, left: 16),
                child: Column(
                  children: [
                    GestureDetector(
                      child: Container(
                        width: width,
                        height: 50,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 2, color: const Color(0xffE5413F)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Text(
                          "Change Password",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      child: Container(
                        width: width,
                        height: 50,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 2, color: const Color(0xffE5413F)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Log Out",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.logout,
                              color: Color(0xffE5413F),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        logout(context);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
