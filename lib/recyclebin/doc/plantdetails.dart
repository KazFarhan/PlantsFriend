// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:my_new_plants/data/plant_data.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../data/plant_model.dart';
// import '../../page/details_page.dart';
// import '../../widgets/bottom_nav.dart';
//
//
// class PlantList extends StatefulWidget {
//   @override
//   _PlantListState createState() => _PlantListState();
// }
//
// class _PlantListState extends State<PlantList> {
//   List<Plants> _favoritePlants = [];
//   CollectionReference favoritesRef =
//   FirebaseFirestore.instance.collection('favorites');
//
//
//   @override
//   @override
//   void initState() {
//     super.initState();
//
//     // Retrieve favorite plant data from Firestore
//     favoritesRef.get().then((querySnapshot) {
//       setState(() {
//         _favoritePlants = querySnapshot.docs.map<Plants>((doc) {
//           final data = doc.data();
//           return Plants(
//             name: data!['name'] ?? '',
//             imagePath: data['imagePath'],
//             category: data['category'],
//           );
//         }).toList();
//       });
//     }).catchError((error) {
//       print("Failed to retrieve favorite plants: $error");
//     });
//   }
//
//
//
//
//   void _toggleFavorite(Plants plant) async {
//     setState(() {
//       if (_favoritePlants.contains(plant)) {
//         _favoritePlants.remove(plant);
//         favoritesRef.doc(plant.id.toString()).delete();
//       } else {
//         _favoritePlants.add(plant);
//         favoritesRef.doc(plant.id.toString()).set(plant.toMap());
//       }
//     });
//   }
//
//   void _removeFavorite(Plants plant) async {
//     setState(() {
//       _favoritePlants.remove(plant);
//       favoritesRef.doc(plant.id.toString()).delete();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white60,
//         shadowColor: Colors.white60,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => BottomNavBar()));
//           },
//           icon: const Icon(Icons.arrow_back),
//         ),
//         title: Padding(
//           padding: const EdgeInsets.only(left: 80.0),
//           child: Text(
//             'Plant Favorites',
//             style: GoogleFonts.robotoSerif(
//               color: Colors.grey.shade400,
//             ),
//           ),
//         ),
//       ),
//       body: _favoritePlants.isEmpty
//           ? Center(
//         child: Text(
//           'No favorite plants',
//           style: GoogleFonts.robotoSerif(color: Colors.grey.shade600),
//         ),
//       )
//           : ListView.builder(
//         itemCount: _favoritePlants.length,
//         itemBuilder: (context, index) {
//           final plant = _favoritePlants[index];
//
//           return GestureDetector(
//             onTap: () {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(
//                       builder: (context) => DetailsPage(plant: plant)));
//             },
//             child: ListTile(
//               leading: Image.asset(
//                 plant.imagePath,
//                 width: 50,
//                 height: 50,
//                 fit: BoxFit.cover,
//               ),
//               title: Text(
//                 plant.name,
//                 style: GoogleFonts.openSans(color: Colors.grey.shade600),
//               ),
//               subtitle: Text(
//                 plant.category,
//                 style: GoogleFonts.openSans(color: Colors.grey.shade400),
//               ),
//               trailing: IconButton(
//                 icon: Icon(
//                   Icons.favorite,
//                   color: Colors.red,
//                 ),
//                 onPressed: () => _removeFavorite(plant),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
//
