import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_new_plants/data/plant_model.dart';
import 'package:my_new_plants/page/details_page.dart';
import 'package:my_new_plants/page/water.dart';
import '../menupage/notes.dart';




class Sunlight extends StatelessWidget {
  final Plants plant;
  const Sunlight({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(

      body:   SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.orangeAccent,Colors.orangeAccent,Colors.white,Colors.orange,Colors.white,]
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
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailsPage(plant:plant)));

                        },),
                      Padding(
                        padding: const EdgeInsets.only(left: 90.0),
                        child: Text('Sunlight',style: GoogleFonts.robotoSerif(
                            fontSize: 22,
                            color: Colors.white
                        ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 100.0),
                        child: IconButton(icon: const Icon(Icons.arrow_forward),
                          onPressed: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>Water(plant:plant)));

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
                            padding: const EdgeInsets.only(bottom:40.0),
                            child: Container(
                              height: 400,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.8),
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
                                  color: Colors.orange.withOpacity(0.8),
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
                                  color: Colors.orange.withOpacity(0.6),
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
                                              color: Colors.white),

                                          children: <TextSpan>[
                                            TextSpan(text: plant.sunrays,
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
                                            TextSpan(text: plant.sunlight1,
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