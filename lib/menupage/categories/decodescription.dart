import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_new_plants/data/plant_model.dart';
import 'package:my_new_plants/categories/decodescription.dart';
import '../data/plant_data.dart';
import '../widgets/bottom_nav.dart';
import '../data/Indoor_plant.dart';

class PlantDecoration1 extends StatelessWidget {
  final Plants item;

  const PlantDecoration1({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white30,
          title: const Text(""),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.grey),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topLeft,
                    colors: [Colors.blue, Colors.white70, Colors.white30,]
                )
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 24.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name, style: GoogleFonts.openSans(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),),
                                const SizedBox(height: 10),
                                const Text(
                                  "Decoration Idea 1", style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),),
                                const SizedBox(height: 10),
                                Text(item.decoration1, style: GoogleFonts
                                    .openSans(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),),
                                const SizedBox(height: 20),
                                const Text(
                                  "Decoration Idea 2", style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),),
                                const SizedBox(height: 10),
                                Text(item.decoration2, style: GoogleFonts
                                    .openSans(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),),
                                const SizedBox(height: 20),
                                const Text(
                                  "Decoration Idea 3", style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),),
                                const SizedBox(height: 10),
                                Text(item.decoration3, style: GoogleFonts
                                    .openSans(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),),
                                const SizedBox(height: 20),
                                const Text(
                                  "Decoration Idea 4", style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),),
                                const SizedBox(height: 10),
                                Text(item.decoration4, style: GoogleFonts
                                    .openSans(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),),
                              ]
                          ),
                        ),
                      ]
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}