import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

class PlantReminder extends StatefulWidget {
  @override
  _PlantReminderState createState() => _PlantReminderState();
}

class _PlantReminderState extends State<PlantReminder> {
  late String _plantName;
  late DateTime _wateringTime;

  void _showReminder() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text("Water your plant"),
        content: Text("It's time to water $_plantName"),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _plantName = "Tomato Plant";
    _wateringTime = DateTime.now().add(Duration(seconds: 5));
    Timer(_wateringTime.difference(DateTime.now()), _showReminder);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plant Reminder"),
      ),
      body: Center(

        child: Column(
          children: [
            Container(
                child: Center(
                    child: Text("Reminder set for $_plantName")
                ),
            ),
          ],
        ),
      ),
    );
  }
}
