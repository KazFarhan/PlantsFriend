import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_new_plants/categories/decodescription.dart';
import '../data/plant_data.dart';
import '../widgets/bottom_nav.dart';


class PlantDecoration extends StatefulWidget {

  @override
  State<PlantDecoration> createState() => _PlantDecorationState();
}

class _PlantDecorationState extends State<PlantDecoration> {

  final CarouselController carouselController =CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white30,

        title:  Padding(
          padding: EdgeInsets.all(50),
          child: Text('Decoration', style: GoogleFonts.robotoSerif(
            fontSize: 22,
          ),),),
        leading: IconButton(icon: const Icon(Icons.arrow_back,color: Colors.grey),
          onPressed: () =>
              Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const BottomNavBar()),),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topLeft,
                  colors: [Colors.blue,Colors.white70,Colors.white30,]
              )
          ),
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(top: 10),
                child:  Text("Plants",style: GoogleFonts.openSans(
                  fontSize: 24,
                ),),
              ),
              const SizedBox(height:10),
               SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Center(
                      child: CarouselSlider(
                      items: plants.map((item)=>TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context)=>PlantDecoration1(item: item)));
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomRight,
                                      colors: [Colors.white,Colors.white,Colors.white,Colors.white,]
                                  )
                              ),
                              child: Image.asset(
                    item.imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item.name,
                                style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontSize: 22,
                              ),),
                            ),
                             const SizedBox(height: 20),
                             Container(
                                width: double.infinity,
                               decoration: const BoxDecoration(
                                   gradient: LinearGradient(
                                       begin: Alignment.bottomLeft,
                                       end: Alignment.topLeft,
                                       colors: [Colors.white70,Colors.white70,]
                                   )
                               ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(item.decoration1,
                                      textAlign: TextAlign.justify,
                                      style: GoogleFonts.openSans(
                                        color: Colors.black,
                                        fontSize: 22,
                                      ),),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ).toList(),
                          options: CarouselOptions(
                            height: 1000,
                            viewportFraction: 1,
                            scrollPhysics: const BouncingScrollPhysics(),
                            autoPlay: true,
                            enlargeCenterPage: true,
                            onPageChanged: (Index, reason){
                              setState(() {
                                currentIndex =Index;
                              });
                            },

                      ),
    ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );

  }
}