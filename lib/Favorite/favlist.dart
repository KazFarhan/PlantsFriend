import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_new_plants/Favorite/fav_plants.dart';
import 'package:provider/provider.dart';
import '../page/addcart.dart';



class FavoritePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      title: const Padding(
        padding:  EdgeInsets.only(left: 50.0),
        child: Text(
          'Favorite Page',
              style: TextStyle(fontSize: 24),
        ),
      ),
      ),
      body:  Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
                child:Padding(
              padding:  const EdgeInsets.all(8),
                  child: _FavoritePageList(),
            ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoritePageList extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    var itemNameStyle = Theme.of(context).textTheme.headline6;
    var favoritepage = context.watch<FavoritePlants>();
    return ListView.builder(
      itemCount: favoritepage.items.length,
      itemBuilder: (context, index)=> ListTile(
        leading: TextButton(
            onPressed: (){},
            child: Image.asset(favoritepage.items[index].image)),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: (){
            favoritepage.remove(favoritepage.items[index]);
          },
        ),
        title: Text(
          favoritepage.items[index].Name,
          style: const TextStyle(fontSize: 16,color:Colors.black),
        ),
        subtitle: Text(
          favoritepage.items[index].Subtitle,
          style: const TextStyle(fontSize: 16,color:Colors.grey),
        ),
      ),
    );

  }

}
