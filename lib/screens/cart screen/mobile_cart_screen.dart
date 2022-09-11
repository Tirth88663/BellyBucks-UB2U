import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/cart_products.dart';
import '../../widgets/cart_total.dart';

class MobileCartScreen extends StatelessWidget {
  const MobileCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffE5413F),
        title: Text(
          "Cart Screen",
          style: GoogleFonts.poppins(),
        ),
      ),
      body: Column(
        children: [
          CartProducts(),
          Expanded(child: CartTotal()),
        ],
      ),
    );
  }
}
