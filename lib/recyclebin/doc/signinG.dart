import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_new_plants/data/plant_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/plant_model.dart';
import '../../page/details_page.dart';
import '../../widgets/bottom_nav.dart';

class PlantList extends StatefulWidget {
  @override
  _PlantListState createState() => _PlantListState();
}

class _PlantListState extends State<PlantList> {
  final List<Plants> _favoritePlants = [];
  final CollectionReference _favoritesRef =
  FirebaseFirestore.instance.collection('favorites');

  Future<void> _toggleFavorite(Plants plant) async {
    setState(() {
      if (_favoritePlants.contains(plant)) {
        _favoritePlants.remove(plant);
        _favoritesRef.doc(plant.id.toString()).delete();
      } else {
        _favoritePlants.add(plant);
        _favoritesRef.doc(plant.id.toString()).set(plant.toMap());
      }
    });
  }

  Future<void> _removeFavorite(Plants plant) async {
    setState(() {
      _favoritePlants.remove(plant);
      _favoritesRef.doc(plant.id.toString()).delete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        shadowColor: Colors.white60,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BottomNavBar()));
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 80.0),
          child: Text(
            'Plant Favorites',
            style: GoogleFonts.robotoSerif(
              color: Colors.grey.shade400,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (plants.isEmpty)
              const Center(
                child: Text(
                  'No plants in list',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                shrinkWrap: true,
                itemCount: plants.length,
                itemBuilder: (context, index) {
                  final plant = plants[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) =>
                              DetailsPage(plant: plant)));
                    },
                    child: ListTile(
                      leading: Image.asset(
                        plant.imagePath,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        plant.name,
                        style: GoogleFonts.openSans(color: Colors.grey
                            .shade600),
                      ),
                      subtitle: Text(
                        plant.category,
                        style: GoogleFonts.openSans(color: Colors.grey
                            .shade400),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          _favoritePlants.contains(plant)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () => _toggleFavorite(plant),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

