import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_new_plants/widgets/bottom_nav.dart';

import '../page/details_page.dart';


class Nutrition extends StatefulWidget {
  @override
  _NutritionState createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
  int _numOfPlants = 50;
  int _soilPerPlant = 15;
  int _nutritionPerPlant = 10;
  int _waterPerPlant = 20;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Soil, Nutrition, and Water Calculator',
        theme: ThemeData(
        primarySwatch: Colors.blue,
    ),
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.all(30),
          child: Text('Soil, Nutrition, and Water Calculator',style: GoogleFonts.robotoSerif(fontSize: 14),),),
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=> BottomNavBar())),),
      ),
    body: SingleChildScrollView(
      child: Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      Text(
      'Number of Plants:',
      ),
      TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(hintText: 'Enter number of plants'),
      onChanged: (value) {
      setState(() {
      _numOfPlants = int.parse(value);
      });
      },
      ),
      Text(
      'Soil per Plant (in kg):',
      ),
      TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(hintText: 'Enter soil per plant'),
      onChanged: (value) {
      setState(() {
      _soilPerPlant = int.parse(value);
      });
      },
      ),
      Text(
      'Nutrition per Plant (in g):',
      ),
      TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(hintText: 'Enter nutrition per plant'),
      onChanged: (value) {
      setState(() {
      _nutritionPerPlant = int.parse(value);
      });
      },
      ),
      Text(
      'Water per Plant (in L):',
      ),
      TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(hintText: 'Enter water per plant'),
      onChanged: (value) {
      setState(() {
      _waterPerPlant = int.parse(value);
      });
      },
      ),
      Text(
      'Soil Needed:',
      ),
      Text(
      '${_numOfPlants * _soilPerPlant} kg',
      style: Theme.of(context).textTheme.displaySmall,
      ),
      Text(
      'Nutrition Needed:',
      ),
      Text(
      '${_numOfPlants * _nutritionPerPlant} g',
      style: Theme.of(context).textTheme.displaySmall,
      ),
      Text(
      'Water Needed:',
      ),
        Text(
          '${_numOfPlants * _waterPerPlant} L',
          style: Theme.of(context).textTheme.displaySmall
        ),
      ],
      ),
      ),
    ),
    ),
    );
  }
}
