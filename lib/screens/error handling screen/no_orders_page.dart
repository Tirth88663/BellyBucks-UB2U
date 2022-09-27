import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class NoOrdersPage extends StatefulWidget {
  const NoOrdersPage({Key? key}) : super(key: key);

  @override
  State<NoOrdersPage> createState() => _NoOrdersPagestate();
}

class _NoOrdersPagestate extends State<NoOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            
            Padding(
              padding: const EdgeInsets.only(bottom: 220.0),
              child: Image.asset("assets/no_orders.PNG",

                fit: BoxFit.cover,
                height: 300.0,
                width: 300.0,
                //color: Colors.transparent,
                colorBlendMode: BlendMode.modulate,),
            ),
            
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Text('No orders yet !',

                textAlign: TextAlign.center,
                style:GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize:29.0,
                      color: Colors.red, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            
          ],
        ),

      ),

    );


  }
}
