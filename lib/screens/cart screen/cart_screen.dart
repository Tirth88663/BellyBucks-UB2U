import 'package:bellybucks/responsive.dart';
import 'package:bellybucks/screens/cart%20screen/desktop_cart_screen.dart';
import 'package:bellybucks/screens/cart%20screen/mobile_cart_screen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: MobileCartScreen(),
      tablet: null,
      desktop: DesktopCartScreen(),
    );
  }
}
