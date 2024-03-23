import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_new_plants/page/home_page.dart';
import 'package:my_new_plants/data/bottom_menu.dart';
import '../Profile_page/profile_img.dart';
import '../mlplants/machine_plant.dart';
import '../page/addcart.dart';
import '../page/addtocart_new.dart';
import '../page/prof.dart';
import '../page/Profileup.dart';
import '../recyclebin/doc/loginpage.dart';
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}
class _BottomNavBarState extends State<BottomNavBar>{
  final user =FirebaseAuth.instance.currentUser!;
  PageController pageController = PageController();
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: PageView.builder(
         itemCount: child.length,
         controller: pageController,
         onPageChanged: (value) => setState(()=>selectIndex=value),
         itemBuilder: (itemBuilder, index){
       return Container(
       child: child[index],
       );
         }
         ),
     bottomNavigationBar: BottomAppBar(
       elevation:0,
       child: SizedBox(
         height: 60.0,
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             for(int i=0;bottomMenu.length>i; i++)
               GestureDetector(onTap: (){
                 setState(() {
                   pageController.jumpToPage(i);
                   selectIndex = i;
                 });
               }, child: Column(
                 children: [
                 Image.asset(bottomMenu[i].imagePath,
                   color: selectIndex==i? Colors.lightGreen: Colors.grey.withOpacity(0.8),

                 ),
                   Text(bottomMenu[i].name,
                     style: GoogleFonts.openSans(
                       fontSize: 14,
                       color: selectIndex==i? Colors.lightGreen: Colors.grey.withOpacity(0.8),
                     ),)
       ]
               ),

               ),


           ],
         ),

       ),
     ),
   );
  }
}
List<Widget>child = [
  const HomePage(),
  PlantList(),
  const MachinePlant(),
  Profile()
];

