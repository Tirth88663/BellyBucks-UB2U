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
      //backgroundColor: const Color(0xFFE5413F),
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            /* Image.asset("assets/food_doodle_2.png",
              fit: BoxFit.cover,
              height: height,
              width: width,
              color: Colors.white.withOpacity(0.4),
              colorBlendMode: BlendMode.modulate,
            ),*/
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
            /*Padding(
              padding: const EdgeInsets.only(top: 300.0,left: 20.0,right: 20.0),
              child: Text("Looks like you haven't decided your menu yet",

                textAlign: TextAlign.center,
                style:GoogleFonts.breeSerif(
                  textStyle: const TextStyle(
                      fontSize:27,
                      color: Colors.red, fontWeight: FontWeight.w500),
                ),
              ),
            ),*/

          ],
        ),

      ),

    );


  }
}