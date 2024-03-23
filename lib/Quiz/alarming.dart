import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

import '../widgets/bottom_nav.dart';

void main() => runApp(PlantCareAlarm());

class PlantCareAlarm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Care Alarm',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: PlantCareHomePage(),
    );
  }
}

class PlantCareHomePage extends StatefulWidget {
  @override
  _PlantCareHomePageState createState() => _PlantCareHomePageState();
}

class _PlantCareHomePageState extends State<PlantCareHomePage> {
  String _alarmText = "";
  late Timer _timer;
  int _frequency = 24;
  int _plantType = 0;
  String _plantName = "Plant";

  List<String> _plantTypes = [    "Succulent",    "Fern",    "Flower",    "Vegetable",  ];

  @override
  void initState() {
    super.initState();
    _setAlarm();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _setAlarm() {
    _timer = Timer.periodic(Duration(hours: _frequency), (timer) {
      setState(() {
        _alarmText = "Time to water your $_plantName!";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.all(30),
          child: Text('Plant Care Alarm',style: GoogleFonts.robotoSerif(fontSize: 22),),),
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=> BottomNavBar())),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _alarmText,
              style: TextStyle(fontSize: 20.0),
            ),
            ElevatedButton(
              child: Text('Dismiss Alarm'),
              onPressed: () {
                setState(() {
                  _alarmText = "";
                });
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                "Plant Type: $_plantName",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            DropdownButton<int>(
              value: _plantType,
              items: _plantTypes
                  .asMap()
                  .entries
                  .map((MapEntry map) => DropdownMenuItem<int>(
                value: map.key,
                child: Text(map.value),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _plantType = value!;
                  _plantName = _plantTypes[value];
                });
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 20
              ),
              child: Text(
                "Watering Frequency (hours): $_frequency",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Slider(
              value: _frequency.toDouble(),
              min: 4.0,
              max: 72.0,
              divisions: 18,
              label: "$_frequency",
              onChanged: (value) {
                setState(() {
                  _frequency = value.round();
                  _timer.cancel();
                  _setAlarm();
                });
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                "Plant Nutrition",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                child: Text("Add Fertilizer"),
                onPressed: () {
                  setState(() {
                    _alarmText = "Fertilizer has been added to $_plantName.";
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}