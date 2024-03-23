// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:my_new_plants/data/plant_data.dart';
//
// import '../data/plant_model.dart';
// import '../widgets/bottom_nav.dart';
// import 'details_page.dart';
//
//
//
// class PlantList extends StatefulWidget {
//
//
//   @override
//   _PlantListState createState() => _PlantListState();
// }
//
// class _PlantListState extends State<PlantList> {
//   List<Plants> _favoritePlants = [];
//
//   void _toggleFavorite(Plants plant) {
//     setState(() {
//       if (_favoritePlants.contains(plant)) {
//         _favoritePlants.remove(plant);
//       } else {
//         _favoritePlants.add(plant);
//       }
//     });
//   }
//
//   void _removeFavorite(Plants plant) {
//     setState(() {
//       _favoritePlants.remove(plant);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white60,
//           shadowColor: Colors.white60,
//           leading: IconButton(
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder:(context)=>BottomNavBar()));
//             },
//             icon: const Icon(Icons.arrow_back),
//           ),
//           title: Padding(
//             padding: const EdgeInsets.only(left: 80.0),
//             child: Text('Plant Favorites',style: GoogleFonts.robotoSerif(
//                 color: Colors.grey.shade400,
//             ),),
//           ),
//         ),
//         body: plants.isEmpty
//             ? Center(
//           child: Text('No plants in list',style: GoogleFonts.robotoSerif(
//               color: Colors.grey.shade600
//           ),),
//         )
//             : ListView.builder(
//           itemCount: plants.length,
//           itemBuilder: (context, index) {
//             final plant = plants[index];
//
//             return GestureDetector(
//               onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>DetailsPage(plant: plant)));},
//               child: ListTile(
//                 leading: Image.asset(
//                   plant.imagePath,
//                   width: 50,
//                   height: 50,
//                   fit: BoxFit.cover,
//                 ),
//                 title: Text(plant.name,style: GoogleFonts.openSans(
//                     color: Colors.grey.shade600
//                 ),),
//                 subtitle: Text(plant.category,style: GoogleFonts.openSans(
//                     color: Colors.grey.shade400
//                 ),),
//                 trailing: IconButton(
//                   icon: Icon(
//                     _favoritePlants.contains(plant)
//                         ? Icons.favorite
//                         : Icons.favorite_border,
//                     color: Colors.red,
//                   ),
//                   onPressed: () => _toggleFavorite(plant),
//                 ),
//               ),
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => FavoritesList(
//                     favoritePlants: _favoritePlants,
//                     removeFavorite: _removeFavorite,
//                   ),
//                 ),
//               );
//             },
//             child: Stack(
//                 children: [
//                 Icon(Icons.favorite),
//             if (_favoritePlants.isNotEmpty)
//         Positioned(
//         top: 0,
//         right: 0,
//         child: Container(
//         padding: EdgeInsets.all(2),
//     decoration: BoxDecoration( color: Colors.red,
//       borderRadius: BorderRadius.circular(10),
//     ),
//           child: Text(
//             _favoritePlants.length.toString(),
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 12,
//             ),
//           ),
//         ),
//         ),
//                 ],
//             ),
//         ),
//     );
//   }
// }
//
// class FavoritesList extends StatelessWidget {
//   final List<Plants> favoritePlants;
//   final Function(Plants) removeFavorite;
//
//   FavoritesList({
//     required this.favoritePlants,
//     required this.removeFavorite,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.grey.shade600,
//         title: Padding(
//           padding: const EdgeInsets.only(left: 80.0),
//           child: Text('Favorites',style: GoogleFonts.robotoSerif(
//               color: Colors.white70
//           ),),
//         ),
//     ),
//     body: favoritePlants.isEmpty
//     ? Center(
//     child: Text('No favorites yet',style: GoogleFonts.openSans(
//     color: Colors.grey.shade600
//     ),),
//     )
//         : ListView.builder(
//     itemCount: favoritePlants.length,
//     itemBuilder: (context, index) {
//     final plant = favoritePlants[index];
//     return ListTile(
//       leading: Image.asset(
//         plant.imagePath,
//         width: 50,
//         height: 50,
//         fit: BoxFit.cover,
//       ),
//       subtitle: Text(plant.category,style: GoogleFonts.openSans(
//           color: Colors.grey.shade400
//       ),),
//       title: Text(plant.name,style: GoogleFonts.openSans(
//           color: Colors.grey.shade600
//       ),),
//       trailing: IconButton(
//         icon: Icon(
//           Icons.remove_circle,
//           color: Colors.red,
//         ),
//         onPressed: () => removeFavorite(plant),
//       ),
//     );
//     },
//     ),
//     );
//   }
// }
//
