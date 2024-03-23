// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../page/addcart.dart';
// import 'apptheme.dart';
// import 'fav_plants.dart';
// import 'favlist.dart';
// import 'favorite_list.dart';
//
// class FavPlantList extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers:[
//           SliverAppBar(
//             backgroundColor: Colors.green,
//             title: const Text('Favorite Plants'),
//             floating: true,
//             actions: [
//               IconButton(
//         icon: const Icon(Icons.favorite_border),
//         onPressed: ()=>Navigator.pushNamed(context,'/favoritepage'),
//     ),
//             ],
//           ),
//           const SliverToBoxAdapter(child: SizedBox(height: 12),),
//           SliverList(delegate:
//           SliverChildBuilderDelegate((BuildContext context, int index){
//             return _MyListItem(index);
//     },
//     childCount: 80),
//     )
//     ]
//
//       ),
//     );
//   }
// }
//
// class _MyListItem extends StatelessWidget{
//   final int index;
//   const _MyListItem(this.index, {Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     var item = context.select<FavoriteListModel, Item>(
//         (favoritelist)=> favoritelist.getByPosition(index),
//     );
//     var textTheme = Theme.of(context).textTheme.headline6;
// return Padding(padding:const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
// child: LimitedBox(
//   maxHeight: 100,
//   child: Row(
//     children: [
//       AspectRatio(aspectRatio:1,
//       child: TextButton(
//           onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>AddCart(item: item)));
//           },
//           child: Image.asset(item.image)),
//       ),
//       const SizedBox(width: 30),
//       Expanded(child:Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(item.Name,style: const TextStyle(fontSize: 18,color: Colors.black),),
//           Text(item.Subtitle,
//           style: const TextStyle(fontSize: 16,color: Colors.grey)),
//         ],
//       ),
//       ),
//       const SizedBox(width: 24),
//       _AddButton(item: item),
//     ],
//   ),
// ),
// );
//   }
// }
// class _AddButton extends StatelessWidget{
//   final Item item;
//   const _AddButton({required this.item, Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context){
//
//     var isInFavoritePage = context.select<FavoritePlants, bool>(
//         (favoritepage)=> favoritepage.items.contains(item),
//     );
//     return IconButton(
//       icon: isInFavoritePage
//         ? const Icon(Icons.favorite,color: Colors.red)
//       : const Icon(Icons.favorite_border),
//         onPressed: isInFavoritePage
//         ?(){
//         var favoritepage = context.read<FavoritePlants>();
//         favoritepage.remove(item);
//     }
//     : (){
//         var favoritepage = context.read<FavoritePlants>();
//         favoritepage.add(item);
//         },
//     );
//   }
// }