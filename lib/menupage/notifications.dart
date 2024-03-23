import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../categories/searchplant.dart';
import '../data/Indoor_plant.dart';
import '../data/infodata.dart';
import '../widgets/bottom_nav.dart';

class NotificationsPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.green,
      automaticallyImplyLeading: false,
      title: const Padding(
        padding: EdgeInsets.all(70),
        child: Text('Notifications',style: TextStyle(fontSize: 32,),),),
      leading: IconButton(icon: Icon(Icons.arrow_back),
        onPressed:()=> Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>BottomNavBar())),),
    ),
      body:  Center(
        child: Column(
          children: [
          ],
        ),
      ),
    );
  }

}