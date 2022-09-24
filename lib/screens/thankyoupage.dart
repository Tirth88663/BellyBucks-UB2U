import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Thankyoupage extends StatefulWidget {
  const Thankyoupage({Key? key}) : super(key: key);

  @override
  State<Thankyoupage> createState() => _ThankyoupageState();
}

class _ThankyoupageState extends State<Thankyoupage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Scaffold(
        backgroundColor: const Color(0xFFE5413F),
        body: Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
              Image.asset("lib/assets/food_doodle_2.png",
                  fit: BoxFit.cover,
                  height: height,
                  width: width,
                  color: Colors.white.withOpacity(0.4),
                  colorBlendMode: BlendMode.modulate,
              ),
                Padding(
                  padding: EdgeInsets.only(bottom: 130.0),
                  child: Image.asset("lib/assets/tick3.png",

                    fit: BoxFit.cover,
                    height: 50.0,
                    width: 50.0,
                    //color: Colors.transparent,
                    colorBlendMode: BlendMode.modulate,),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: Text('\nThank you so much !',

                    textAlign: TextAlign.center,
                    style:GoogleFonts.poppins(
                      textStyle: const TextStyle(
                      fontSize:22.0,
                        color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                ),
              ),
                Padding(
                  padding: const EdgeInsets.only(top: 75.0),
                  child: Text('We will look into this and will continue on improving the app.',

                    textAlign: TextAlign.center,
                    style:GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize:20.0,
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

              ],
            ),

        ),

    );


  }
}