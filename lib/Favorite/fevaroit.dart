// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'FavPlant_list.dart';
// import 'apptheme.dart';
// import 'fav_plants.dart';
// import 'favlist.dart';
// import 'favorite_list.dart';
//
// class Fevorite_Plants extends StatelessWidget{
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         Provider(create: (context)=>FavoriteListModel()),
//         ChangeNotifierProxyProvider<FavoriteListModel, FavoritePlants>(
//           create:(context)=>FavoritePlants(),
//           update: (context, favoritelist,favoritepage){
//             if (favoritepage == null)
//               throw ArgumentError.notNull('favoritepage');
//             favoritepage.favoritelist = favoritelist;
//             return favoritepage;
//     },
//     ),
//     ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title:'Favorite Page',
//         theme: appTheme,
//         initialRoute: '/',
//         routes: {
//           '/':(context)=>FavPlantList(),
//           '/favoritepage':(context)=>FavoritePage(),
//         },
//
//       ),
//     );
//
//   }
// }
