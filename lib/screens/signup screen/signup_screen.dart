import 'package:bellybucks/responsive.dart';
import 'package:flutter/material.dart';

import '../signup screen/mobile_signup_screen.dart';
import 'desktop_signup_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: MobileSignUpScreen(),
      tablet: null,
      desktop: DesktopSignUpScreen(),
    );
  }
}
