import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileCartScreen extends StatelessWidget {
  const MobileCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Cart Screen",
        style: GoogleFonts.poppins(),
      ),
    );
  }
}
