import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class OrderSuccesspage extends StatefulWidget {
  const OrderSuccesspage({Key? key}) : super(key: key);

  @override
  State<OrderSuccesspage> createState() => _OrderSuccesspagestate();
}

class _OrderSuccesspagestate extends State<OrderSuccesspage> {
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
            Image.asset("assets/food_doodle_2.png",
              fit: BoxFit.cover,
              height: height,
              width: width,
              color: Colors.white.withOpacity(0.4),
              colorBlendMode: BlendMode.modulate,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 155.0),
              child: Image.asset("assets/tick3.png",

                fit: BoxFit.cover,
                height: 50.0,
                width: 50.0,
                //color: Colors.transparent,
                colorBlendMode: BlendMode.modulate,),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 90.0),
              child: Text('\nOrder Success !',

                textAlign: TextAlign.center,
                style:GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize:25.0,
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text('Your order will be ready soon.',

                textAlign: TextAlign.center,
                style:GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize:26.9,
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            Padding(
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
            ),

          ],
        ),

      ),

    );


  }
}
