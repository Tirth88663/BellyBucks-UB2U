import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class NoInternetConnectionpage extends StatefulWidget {
  const NoInternetConnectionpage({Key? key}) : super(key: key);

  @override
  State<NoInternetConnectionpage> createState() => _NoInternetConnectionpagestate();
}

class _NoInternetConnectionpagestate extends State<NoInternetConnectionpage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
              padding: EdgeInsets.only(bottom: 260.0),
              child: Image.asset("assets/no_internet.PNG",

                fit: BoxFit.cover,
                height: 300.0,
                width: 300.0,
                //color: Colors.transparent,
                colorBlendMode: BlendMode.modulate,),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Text('WHOOPS !',

                textAlign: TextAlign.center,
                style:GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize:29.0,
                      color: Colors.red, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 300.0),
              child: Text('Slow or No Internet Connection\nCheck and Try Again',

                textAlign: TextAlign.center,
                style:GoogleFonts.breeSerif(
                  textStyle: const TextStyle(
                      fontSize:25,
                      color: Colors.red, fontWeight: FontWeight.w500),
                ),
              ),
            ),

            /*Padding(
              padding: const EdgeInsets.only(top: 165.0),
              child: const SizedBox(
                width: 170.0,
                height: 33.5,

                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20.0),

                  ),),

                  child:Text('Thank You',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize:28.0,
                        color: Colors.black, fontWeight: FontWeight.w600),

                  ) ,
                ),
              ),
            ),*/

          ],
        ),

      ),

    );


  }
}