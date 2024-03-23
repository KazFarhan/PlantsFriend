// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../data/plant_data.dart';
// import '../data/plant_model.dart';
//
//
//
// class PlantList extends StatefulWidget {
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
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Padding(
//           padding: const EdgeInsets.only(left: 100.0),
//           child: Text('Plant Favorites',style: GoogleFonts.robotoSerif(
//             color: Colors.grey.shade400
//           ),),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: plants.length,
//         itemBuilder: (context, index) {
//           final plant = plants[index];
//
//           return ListTile(
//             leading: Image.asset(
//               plant.imagePath,
//               width: 50,
//               height: 50,
//               fit: BoxFit.cover,
//             ),
//             title: Text(plant.name, style: GoogleFonts.openSans(),),
//             subtitle: Text(plant.category, style: GoogleFonts.openSans(),),
//             trailing: IconButton(
//               icon: Icon(
//                 _favoritePlants.contains(plants)
//                     ? (Icons.favorite)
//                     : Icons.favorite_border,
//                 color: Colors.red,
//
//               ),
//               onPressed: () => _toggleFavorite(plant),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => FavoritesList(
//                 favoritePlants: _favoritePlants,
//                 removeFavorite: _removeFavorite,
//               ),
//             ),
//           );
//         },
//         child: Icon(Icons.favorite,
//         color: Colors.white,),
//       ),
//     );
//   }
// }
//
// class FavoritesList extends StatelessWidget {
//   final List<Plants> favoritePlants;
//   final Function(Plants) removeFavorite;
//
//   FavoritesList({required this.favoritePlants, required this.removeFavorite});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.grey,
//         title: Padding(
//           padding: const EdgeInsets.only(left: 80.0),
//           child: Text('Favorites',style: GoogleFonts.robotoSerif(
//             color: Colors.white70
//           ),),
//         ),
//     ),
//     body: ListView.builder(
//     itemCount: favoritePlants.length,
//     itemBuilder: (context, index) {
//     final plant = favoritePlants[index];
//
//     return ListTile(
//     leading: Image.asset(
//       plant.imagePath,
//       width: 50,
//       height: 50,
//       fit: BoxFit.cover,
//     ),
//       title: Text(plant.name,style: GoogleFonts.openSans(),),
//       subtitle: Text(plant.category,style: GoogleFonts.openSans(),),
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
