import 'dart:ffi';

class BottomMenu {
  final int id;
  final String imagePath;
  final String name;


  BottomMenu(this.id, this.imagePath, this.name);
}

List<BottomMenu> bottomMenu = [
  BottomMenu(0, 'assets/icons/home.png','Home'),
  BottomMenu(1, 'assets/icons/heart.png','Favorite'),
  BottomMenu(3, 'assets/icons/plant.png','Identifier'),
  BottomMenu(4, 'assets/icons/user.png','Profile'),

];

