import 'package:bellybucks/responsive.dart';
import 'package:bellybucks/screens/user%20profile%20screen/desktop_user_screen.dart';
import 'package:bellybucks/screens/user%20profile%20screen/mobile_user_screen.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: MobileUserScreen(),
      tablet: null,
      desktop: DesktopUserScreen(),
    );
  }
}
