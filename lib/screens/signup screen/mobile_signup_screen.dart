import 'package:bellybucks/screens/varify_email_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/user_model.dart';

class MobileSignUpScreen extends StatefulWidget {
  const MobileSignUpScreen({Key? key}) : super(key: key);

  @override
  State<MobileSignUpScreen> createState() => _MobileSignUpScreenState();
}

class _MobileSignUpScreenState extends State<MobileSignUpScreen> {
  final _auth = FirebaseAuth.instance;

  //form key
  final _signupformKey = GlobalKey<FormState>();

  //editing controllers
  //first name field
  final nameEditingController = TextEditingController();
  //email field
  final emailEditingController = TextEditingController();
  //Mobile number field
  final mobileNumberEditingController = TextEditingController();
  //password field
  final passwordEditingController = TextEditingController();
  //confirm password field
  final confirmPasswordEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final nameField = TextFormField(
      autofocus: false,
      controller: nameEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        RegExp regex = RegExp(r'^.{4,}$');
        if (value!.isEmpty) {
          return ("Name is required for SignUp");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter valid name(Min. 4 Characters)");
        }
        return null;
      },
      onSaved: (value) {
        nameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: const Color(0xffE5413F),
      decoration: InputDecoration(
        labelText: 'Name',
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon: const Icon(CupertinoIcons.profile_circled,
            color: Color(0xFF023047)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "enter your name.",
        hintStyle:
            GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE5413F)),
        ),
      ),
    );
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Your Email.";
        }
        //reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter Valid Email");
        }
        //reg expression for validation of domain
        if (!RegExp("\b*.com\$", caseSensitive: true).hasMatch(value)) {
          return ("Enter Valid Email");
        }
        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: const Color(0xffE5413F),
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon:
            const Icon(CupertinoIcons.mail_solid, color: Color(0xFF023047)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        hintStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE5413F)),
        ),
      ),
    );
    final mobileNumberField = TextFormField(
      autofocus: false,
      controller: mobileNumberEditingController,
      keyboardType: TextInputType.phone,
      validator: (value) {
        RegExp regex = RegExp(r'^.{10,}$');
        if (value!.isEmpty) {
          return ("Mobile Number is required for SignUp");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter valid number(10 Characters)");
        }
        return null;
      },
      onSaved: (value) {
        mobileNumberEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: const Color(0xffE5413F),
      decoration: InputDecoration(
        labelText: 'Mobile Number',
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon:
            const Icon(CupertinoIcons.phone_fill, color: Color(0xFF023047)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "mobile number",
        hintStyle: GoogleFonts.poppins(
          textStyle: TextStyle(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE5413F)),
        ),
      ),
    );
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{8,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter valid password.");
        }
        return null;
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: const Color(0xffE5413F),
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon:
            Icon(CupertinoIcons.lock_fill, color: const Color(0xFF023047)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        hintStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE5413F)),
        ),
      ),
    );
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Password is required for SignUp");
        }
        if (confirmPasswordEditingController.text !=
            passwordEditingController.text) {
          return ("Password don't match");
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      cursorColor: const Color(0xffE5413F),
      decoration: InputDecoration(
        labelText: 'Conformation Password',
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon:
            const Icon(CupertinoIcons.lock_fill, color: Color(0xFF023047)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "re-enter your Password",
        hintStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE5413F)),
        ),
      ),
    );
    final signupButton = MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 10,
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      height: 60,
      minWidth: width * 0.35,
      color: const Color(0xffE5413F),
      onPressed: () {
        signUp(emailEditingController.text, passwordEditingController.text);
      },
      child: Text("Sign Up",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _signupformKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                      height: 256,
                      width: width,
                      margin: const EdgeInsets.only(bottom: 72),
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
                        "assets/images/food_doodle_1.png",
                        fit: BoxFit.cover,
                        color: Colors.white.withOpacity(0.6),
                        colorBlendMode: BlendMode.modulate,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                            offset: Offset(0, 5),
                          )
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/logo.png",
                          height: 120,
                          width: 120,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: nameField,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: emailField,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: mobileNumberField,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: passwordField,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: confirmPasswordField,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 196, top: 24),
                  child: signupButton,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    _signupformKey.currentState!.validate();
    if (_signupformKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    //calling Firestore
    //calling our user model
    //sending these values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    //writing all values
    userModel.name = nameEditingController.text;
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.mobileNumber = mobileNumberEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :)");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const VerifyEmailScreen()),
        (route) => false);
  }
}
