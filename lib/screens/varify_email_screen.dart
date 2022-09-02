import 'dart:async';

import 'package:bellybucks/screens/login%20screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_screen/home_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      final snackBar = SnackBar(
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? const HomeScreen()
        : Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  'Verify Email',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                elevation: 0,
                backgroundColor: const Color(0xffE5413F)),
            body: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "A verification email has been sent to your email.",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xffE5413F),
                      minimumSize: Size.fromHeight(
                          MediaQuery.of(context).size.height * 0.08),
                    ),
                    onPressed: () {
                      sendVerificationEmail();
                    },
                    icon: const Icon(Icons.email, size: 24),
                    label: const Text(
                      "Resent Email",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: const Color(0xffE5413F),
                      minimumSize: Size.fromHeight(
                          MediaQuery.of(context).size.height * 0.08),
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Cancel",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
