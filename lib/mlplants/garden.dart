import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


class Plant {
  final int maxWaterLevel;
  int waterLevel;

  Plant({required this.maxWaterLevel, this.waterLevel = 0});

  void addWater(int amount) {
    waterLevel += amount;
    if (waterLevel > maxWaterLevel) {
      waterLevel = maxWaterLevel;
    }
  }

  void removeWater(int amount) {
    waterLevel -= amount;
    if (waterLevel < 0) {
      waterLevel = 0;
    }
  }

  double get waterPercent => waterLevel / maxWaterLevel;
}


class AlarmOn extends StatefulWidget {
  @override
  _AlarmOnState createState() => _AlarmOnState();
}

class _AlarmOnState extends State<AlarmOn>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Plant _plant = Plant(maxWaterLevel: 100, waterLevel: 0);
  Color _flowerColor = Colors.pink;

  int _timerDuration = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
    _animationController.addListener(() {
      setState(() {
        _plant.removeWater(1);
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _fillPlantWithWater() {
    setState(() {
      _plant.addWater(50);
    });
  }

  void _startTimer() {
    setState(() {
      _timer = Timer(Duration(minutes: _timerDuration), () {
        _fillPlantWithWater();
        _startTimer();
      });
    });
  }

  void _stopTimer() {
    setState(() {
      _timer?.cancel();
      _timer = null;
    });
  }

  void _selectColor() async {
    Color? newColor = await showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select flower color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _flowerColor,
              onColorChanged: (color) {
                Navigator.of(context).pop(color);
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(_flowerColor);
              },
            ),
          ],
        );
      },
    );
    if (newColor != null) {
      setState(() {
        _flowerColor = newColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Plant Watering App'),
    ),
    body: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
    color: _flowerColor,
    borderRadius: BorderRadius.circular(100),
    boxShadow: [
    BoxShadow(
    color: Colors.black.withOpacity                  (0.2),
      blurRadius: 5,
      offset: Offset(0, 3),
    ),
    ],
    ),
      child: CustomPaint(
        painter: WaterPainter(
          waterPercent: _plant.waterPercent,
          color: Colors.blue,
        ),
        child: Center(
          child: Text(
            '${(_plant.waterPercent * 100).toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _fillPlantWithWater,
            child: Text('Fill with water'),
          ),
          SizedBox(width: 20),
          ElevatedButton(
            onPressed: _selectColor,
            child: Text('Select color'),
          ),
        ],
      ),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Auto-water every'),
          SizedBox(width: 10),
          DropdownButton<int>(
            value: _timerDuration,
            items: [
              DropdownMenuItem(
                value: 0,
                child: Text('Off'),
              ),
              DropdownMenuItem(
                value: 1,
                child: Text('1 minute'),
              ),
              DropdownMenuItem(
                value: 5,
                child: Text('5 minutes'),
              ),
              DropdownMenuItem(
                value: 10,
                child: Text('10 minutes'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _timerDuration = value ?? 0;
                if (_timerDuration == 0) {
                  _stopTimer();
                } else {
                  _startTimer();
                }
              });
            },
          ),
        ],
      ),
    ],
    ),
    ),
    );
  }
}

class WaterPainter extends CustomPainter {
  final double waterPercent;
  final Color color;

  WaterPainter({required this.waterPercent, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final waterPaint = Paint()..color = color.withOpacity(0.5);
    final waterLevel = size.height * (1 - waterPercent);
    final waterRect = Rect.fromLTRB(
      0,
      waterLevel,
      size.width,
      size.height,
    );
    canvas.drawRect(waterRect, waterPaint);
  }

  @override
  bool shouldRepaint(WaterPainter oldDelegate) {
    return oldDelegate.waterPercent != waterPercent ||
        oldDelegate.color != color;
  }
}
