import 'package:bellybucks/responsive.dart';
import 'package:bellybucks/screens/login%20screen/desktop_login_screen.dart';
import 'package:flutter/material.dart';

import 'mobile_login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: MobileLoginScreen(),
      tablet: null,
      desktop: DesktopLoginScreen(),
    );
  }
}
