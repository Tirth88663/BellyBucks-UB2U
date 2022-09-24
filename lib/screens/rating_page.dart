import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Ratingpage extends StatefulWidget {
  const Ratingpage({Key? key}) : super(key: key);

  @override
  State<Ratingpage> createState() => _Ratingpagestate();
}

class _Ratingpagestate extends State<Ratingpage> {
  var rating = 1.0 ;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
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
              padding: const EdgeInsets.only(bottom: 400.0,left: 30.0,right: 30.0),
              child: Text('How is your experience with the app so far ?',

                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 22.0,
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(bottom: 110.0,left: 15.0,right: 30.0),
              child: Text('Any comments or suggestions ?',

                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 22.0,
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 235.0),
              child: SmoothStarRating(
                rating: rating,
                size: 60,
                //filledIconData: Icons.star,
                halfFilledIconData: Icons.star_half,
                //defaultIconData: Icons.star_border,
                starCount: 5,
                allowHalfRating: true,
                color: Colors.amberAccent,
                borderColor: Colors.white,
                onRated: (value) {
                  setState(() {
                    rating = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 330.0),
              child: SizedBox(
                width: 140.0,
                height: 37,

                child:MaterialButton(
                  elevation: 15.0,
                  highlightColor: const Color(0xFFB3E5FC),
                  color: Colors.white,
                  onPressed:(){},
                  shape: (
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0),
                          side: const BorderSide(color: Colors.white)
                      )
                  ),
                  child: Text("SUBMIT",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 22.0,
                            color:  Color(0xFFE5413F),
                            fontWeight: FontWeight.w600),),
                ),
                ),
            ),
            ),
          const Padding(
            padding: EdgeInsets.only(top: 110.0,left: 15.0,right: 15.0),

                child: TextField (
                  //obscureText: true,
                  autofocus: false,

                  textAlign: TextAlign.center,
                  enableInteractiveSelection: true ,
                  cursorColor: Colors.white,
                  cursorHeight: 30.0,
                  maxLines: 5 ,
                  //minLines: 5,

                  decoration: InputDecoration(

                    contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white,width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,width: 2.0)),

                  ),
                ),
          ),

          ],
        ),

      ),

    );
  }
}