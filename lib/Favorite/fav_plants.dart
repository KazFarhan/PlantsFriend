import 'package:flutter/cupertino.dart';
import 'package:my_new_plants/Favorite/favorite_list.dart';

class FavoritePlants extends ChangeNotifier {

  late FavoriteListModel _favoritelist;

  final List<int> _itemIds = [];

  FavoriteListModel get favoritelist => _favoritelist;

  set favoritelist(FavoriteListModel newList){
    _favoritelist = newList;

    notifyListeners();
  }

  List<Item> get items =>
      _itemIds.map((id) => _favoritelist.getById(id)).toList();

  void add(Item item){
    _itemIds.add(item.id);

    notifyListeners();
  }
  void remove(Item item) {
    _itemIds.remove(item.id);

    notifyListeners();

  }
}