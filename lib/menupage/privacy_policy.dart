import 'package:flutter/material.dart';

import '../widgets/bottom_nav.dart';

class PrivacyPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar( elevation: 0,
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.all(70),
          child: Text('Privacy',style: TextStyle(fontSize: 32,),),),
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed:()=> Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>BottomNavBar())),),
      ),
      body: const Center(
        child: Text('Privacy Page'),
      ),
    );
  }

}