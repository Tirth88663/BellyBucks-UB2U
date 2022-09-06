import 'package:bellybucks/responsive.dart';
import 'package:flutter/material.dart';

import 'desktop_home_screen.dart';
import 'mobile_home_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: MobileHomeScreen(),
      tablet: null,
      desktop: DesktopHomeScreen(),
    );
  }
}
