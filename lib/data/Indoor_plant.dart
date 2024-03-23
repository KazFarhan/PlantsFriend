import 'dart:async';
import 'package:flutter/material.dart';

class Plant {
  final String name;
  final String species;
  late final DateTime lastWatered;
  final int waterInterval;

  Plant({
   required this.name,
    required this.species,
    required this.lastWatered,
    required this.waterInterval,
  });
}



class PlantReminder1 extends StatefulWidget {
  final List<Plant> plants;

  PlantReminder1({
    required this.plants,
  });

  @override
  _PlantReminder1State createState() => _PlantReminder1State();
}

class _PlantReminder1State extends State<PlantReminder1> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(hours: 1), (timer) {
      for (var plant in widget.plants) {
        var timeSinceLastWatered =
            DateTime.now().difference(plant.lastWatered).inHours;
        if (timeSinceLastWatered >= plant.waterInterval) {
          showNotification(plant);
        }
      }
    });
  }

  void showNotification(Plant plant) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('It\'s time to water your plant!'),
          content: Text('Don\'t forget to water your ${plant.name}'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Water'),
              onPressed: () {
                setState(() {
                  plant.lastWatered = DateTime.now();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
    );
  }
}


