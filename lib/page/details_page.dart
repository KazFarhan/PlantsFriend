import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_new_plants/core/color.dart';
import 'package:my_new_plants/data/plant_model.dart';
import 'package:my_new_plants/page/home_page.dart';
import 'package:my_new_plants/page/seasonal.dart';
import 'package:my_new_plants/page/sunlight.dart';
import 'package:my_new_plants/page/water.dart';
import '../widgets/bottom_nav.dart';
import '../page/temperature.dart';

class DetailsPage extends StatelessWidget {
  final Plants plant;
  const DetailsPage({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade400,
          leading: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder:(context)=>BottomNavBar()));
              },
              icon: const Icon(Icons.arrow_back),
            ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.infinity,
                        height: 500,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.white70,Colors.white,Colors.white60,Colors.grey]
                            ),
                          boxShadow: [
                            BoxShadow(
                              color: green.withOpacity(0.6),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                          borderRadius: const BorderRadius.only(
                            topLeft:  Radius.circular(10),
                            topRight:  Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          image: DecorationImage(
                            image: AssetImage(plant.imagePath),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                           vertical: 10.0),
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.white60,Colors.white70,Colors.white54]
                              )
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: plant.name,
                                              style: GoogleFonts.openSans(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '  ${plant.category} ',
                                              style: GoogleFonts.robotoSerif(
                                                fontSize: 22,
                                                color: Colors.green.shade600,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RichText(
                                    textAlign: TextAlign.justify,
                                    text: TextSpan(
                                      text: plant.description,
                                      style: GoogleFonts.openSans(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                  Text(
                                    'Treatment',
                                    style: GoogleFonts.robotoSerif(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                const SizedBox(height: 20.0),
                                Container(
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          InkWell(
                                            highlightColor: Colors.white70,
                                            hoverColor: Colors.orange,
                                            onTap: (){
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Sunlight(plant: plant)));
                                            },
                                            child:  Image.asset('assets/icons/sun.png',
                                                 height: 28.0),
                                          ),
                                           Text('Sunlight',
                                            style: GoogleFonts.openSans(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                           ),
                                        ],
                                      ),

                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Water(plant: plant)));
                                            },
                                            child:  InkWell(
                                              highlightColor: Colors.white70,
                                              hoverColor: Colors.lightBlueAccent,
                                              child: Image.asset('assets/icons/drop.png',
                                                  height: 28.0),
                                            ),
                                          ),
                                           InkWell(
                                             highlightColor: Colors.white70,
                                             hoverColor: Colors.lightBlueAccent,
                                             child: Text('Water',style: GoogleFonts.openSans(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                          ),
                                             ),
                                           ),
                                        ],
                                      ),

                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Temperature(plant: plant)));
                                            },
                                            child:  InkWell(
                                              highlightColor: Colors.grey.shade100,
                                              hoverColor: Colors.red,
                                              child: Image.asset('assets/icons/temperature.png',
                                                  height: 24.0),
                                            ),
                                          ),
                                           InkWell(
                                             highlightColor: Colors.grey.shade100,
                                             hoverColor: Colors.red,
                                             child: Text('Temperature',
                                                 style: GoogleFonts.openSans(
                                                   fontSize: 18,
                                                   fontWeight: FontWeight.w500,
                                                 ),),
                                           ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Seasonal(plant: plant)));
                                            },
                                            child:  InkWell(
                                              highlightColor: Colors.grey.shade100,
                                              hoverColor: Colors.lightGreen,
                                              child: Image.asset('assets/icons/rain.png',
                                                  height: 24.0),
                                            ),
                                          ),
                                           InkWell(
                                             highlightColor: Colors.grey.shade100,
                                             hoverColor: Colors.lightGreen,
                                             child: Text('Seasonal',
                                              style: GoogleFonts.openSans(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),),
                                           ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                    ),
                          ),

                        ),
                      ),
          ],
        ),
      ),
      ]
    ),
      )
    );
  }
}
