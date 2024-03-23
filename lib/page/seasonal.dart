import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_new_plants/page/details_page.dart';
import 'package:my_new_plants/page/temperature.dart';
import '../data/plant_model.dart';
import '../menupage/notes.dart';


class Seasonal extends StatelessWidget {
  final Plants plant;
  const Seasonal({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(

      body:  SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomLeft,
                  colors: [Colors.lightGreenAccent,Colors.white,Colors.green,Colors.green,Colors.greenAccent,]
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
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>Temperature(plant:plant)));
                        },),
                      Padding(
                        padding: const EdgeInsets.only(left: 100.0),
                        child: Text('Seasonal',style: GoogleFonts.robotoSerif(
                            fontSize: 22,
                            color: Colors.white
                        ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                        child: IconButton(icon: const Icon(Icons.arrow_forward),
                          onPressed: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailsPage(plant:plant)));

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
                                color: Colors.white70.withOpacity(0.4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.greenAccent.withOpacity(0.8),
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
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white70.withOpacity(0.2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.greenAccent.withOpacity(0.8),
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
                              color: Colors.green.withOpacity(0.2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.greenAccent.withOpacity(0.6),
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


                                            TextSpan(text: plant.detailsS2,
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

                                            TextSpan(text: plant.detailsS3,
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

                                            TextSpan(text: plant.seas1,
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
                                            TextSpan(text: plant.seas2,
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