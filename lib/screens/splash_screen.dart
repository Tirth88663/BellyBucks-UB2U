import 'package:bellybucks/main.dart';
import 'package:flutter/material.dart';

import '../responsive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const RootPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Image.asset(
        "assets/images/mobile_splash_screen.jpg",
        fit: BoxFit.cover,
      ),
      tablet: Image.asset(
        "assets/images/tab_splash_screen.png",
        fit: BoxFit.cover,
      ),
      desktop: Image.asset(
        "assets/images/desktop_splash_screen.png",
        fit: BoxFit.cover,
      ),
    );
  }
}
