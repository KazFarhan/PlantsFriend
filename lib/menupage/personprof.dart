// import 'package:flutter/material.dart';
// import 'package:my_new_plants/data/plant_data.dart';
//
// import '../data/plant_model.dart';
//
//
// class FavoritePlantsPage extends StatefulWidget {
//   @override
//   _FavoritePlantsPageState createState() => _FavoritePlantsPageState();
// }
//
// class _FavoritePlantsPageState extends State<FavoritePlantsPage> {
//
//
//   bool _isFavorite(Plants plant) {
//     return plants.contains(plant);
//   }
//
//   void _addFavorite(Plants plant) {
//     setState(() {
//       plants.add(plant);
//     });
//   }
//
//   void _removeFavorite(Plants plant) {
//     setState(() {
//       plants.remove(plant);
//     });
//   }
//
//   Widget _buildPlantTile(Plants plant) {
//     return ListTile(
//       leading: Image.asset(plant.imagePath, width: 60, height: 60),
//       title: Text(plant.name),
//       trailing: IconButton(
//         icon: Icon(_isFavorite(plant) ? Icons.favorite : Icons.favorite_border),
//         onPressed: () {
//           if (_isFavorite(plant)) {
//             _removeFavorite(plant);
//           } else {
//             _addFavorite(plant);
//           }
//         },
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Favorite Plants'),
//       ),
//       body: ListView(
//         children: plants.map((plant) => _buildPlantTile(plant)).toList(),
//       ),
//     );
//   }
// }
//
