import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_new_plants/page/seasonal.dart';
import 'package:my_new_plants/page/water.dart';

import '../data/plant_model.dart';
import '../menupage/notes.dart';
import 'details_page.dart';
import '../recyclebin/plantalarm.dart';

class Temperature extends StatelessWidget {
  final Plants plant;
  const Temperature({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(

      body:  SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              gradient: RadialGradient(
                  colors: [Colors.red,Colors.white,Colors.redAccent,]
              )
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Container(
                  child: Row(
                    children: [
                      IconButton(icon: const Icon(Icons.arrow_back),
                        onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>Water(plant:plant)));

                        },),
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0),
                        child: Text('Temperature',style: GoogleFonts.robotoSerif(
                            fontSize: 22,
                            color: Colors.white
                        ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0),
                        child: IconButton(icon: const Icon(Icons.arrow_forward),
                          onPressed: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>Seasonal(plant:plant)));

                          },),
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 400,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.8),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                                borderRadius:  BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(plant.imagePath),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white70.withOpacity(0.2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.4),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                              borderRadius:  BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(plant.name,
                                style: GoogleFonts.robotoSerif(
                                    fontSize: 22,
                                    color: Colors.white
                                ),),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white70.withOpacity(0.2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.2),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                              borderRadius:  BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RichText(
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                          style: GoogleFonts.openSans(
                                              fontSize: 20,
                                              color: Colors.black),

                                          children: <TextSpan>[

                                            TextSpan(text: plant.temperature,
                                              style: GoogleFonts.openSans(
                                                  fontSize: 20,
                                                  color: Colors.black
                                              ),
                                            ),
                                          ]
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RichText(
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                          style: GoogleFonts.openSans(
                                              fontSize: 20,
                                              color: Colors.black),

                                          children: <TextSpan>[

                                            TextSpan(text: plant.temper1,
                                              style: GoogleFonts.openSans(
                                                  fontSize: 20,
                                                  color: Colors.black
                                              ),
                                            ),
                                          ]
                                      ),
                                    ),
                                  ),


                                ],
                              ),

                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}