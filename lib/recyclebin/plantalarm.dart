import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/bottom_nav.dart';

class Plant {
  double waterPercent;

  Plant({required this.waterPercent});
}

class MyHomePage4 extends StatefulWidget {
  const MyHomePage4({Key? key}) : super(key: key);

  @override
  _MyHomePage4State createState() => _MyHomePage4State();
}

class _MyHomePage4State extends State<MyHomePage4>
    with SingleTickerProviderStateMixin {
  final Plant _plant = Plant(waterPercent: 0.5);
  late AnimationController _controller;
  int _timerDuration = 0;
  Timer? _timer;
  Color _flowerColor = Colors.red;
  bool _waterAlarm = false;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..addListener(() {
        setState(() {
          _plant.waterPercent -= 0.01;
          if (_plant.waterPercent < 0) {
            _plant.waterPercent = 0;
          }
          if (_plant.waterPercent < 0.25) {
            _flowerColor = Colors.yellow;
          }
          if (_plant.waterPercent < 0.1) {
            _flowerColor = Colors.orange;
          }
          if (_plant.waterPercent == 0) {
            _flowerColor = Colors.red;
            _waterAlarm = true;
          }
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _stopTimer();
    super.dispose();
  }

  void _fillPlantWithWater() {
    setState(() {
      _plant.waterPercent += 0.2;
      if (_plant.waterPercent > 1) {
        _plant.waterPercent = 1;
      }
      if (_plant.waterPercent > 0.25) {
        _flowerColor = Colors.red;
      }
      _waterAlarm = false;
    });
  }

  void _selectColor() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _flowerColor,
              onColorChanged: (Color color) {
                setState(() {
                  _flowerColor = color;
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(minutes: _timerDuration), (_) {
      setState(() {
        _plant.waterPercent -= 0.1;
        if (_plant.waterPercent < 0) {
          _plant.waterPercent = 0;
        }
        if (_plant.waterPercent < 0.25) {
          _flowerColor = Colors.yellow;
        }
        if (_plant.waterPercent < 0.1) {
          _flowerColor = Colors.orange;
        }
        if (_plant.waterPercent == 0) {
          _flowerColor = Colors.red;
          _waterAlarm = true;
          _stopTimer();
        }
        if (_plant.waterPercent > 0.25) {
          _flowerColor = Colors.red;
          _waterAlarm = false;
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        shadowColor: Colors.grey.shade200,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder:(context)=>BottomNavBar()));
          },
          icon:  Icon(Icons.arrow_back,color: Colors.white70),
        ),
        title: Center(child: Text('Plant App',style:GoogleFonts.openSans(
          color: Colors.white70,
          fontSize: 20,
        ))),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 200.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.green[_plant.waterPercent.toInt() * 100],
                child: Center(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: PlantPainter(
                            waterPercent: _plant.waterPercent,
                            flowerColor: _flowerColor),
                        child: Container(
                          width: 200,
                          height: 200,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _fillPlantWithWater,
                    child: Text('Water plant',style:GoogleFonts.openSans()),
                  ),
                  ElevatedButton(
                    onPressed: _selectColor,
                    child: Text('Change flower color',style:GoogleFonts.openSans()),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Water every (minutes):',style:GoogleFonts.openSans()),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_timerDuration > 0) {
                              _timerDuration--;
                            }
                          });
                        },
                        child: Icon(Icons.remove),
                      ),
                      Text(_timerDuration.toString(),style:GoogleFonts.openSans()),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _timerDuration++;
                          });
                        },
                        child: Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlantPainter extends CustomPainter {
  final double waterPercent;
  final Color flowerColor;

  PlantPainter({required this.waterPercent, required this.flowerColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint stemPaint = Paint()
      ..color = Colors.green[700]!
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    Paint leafPaint = Paint()
      ..color = Colors.green[400]!
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    Paint flowerPaint = Paint()..color = flowerColor;

    Offset center = Offset(size.width / 2, size.height / 2);

// Draw stem
    canvas.drawLine(center, Offset(center.dx, size.height * 0.75), stemPaint);

// Draw leaves
    canvas.drawLine(center, Offset(center.dx - 30, size.height * 0.6), leafPaint);
    canvas.drawLine(center, Offset(center.dx + 30, size.height * 0.6), leafPaint);

// Draw flower
    double flowerSize = 20 + 80 * waterPercent;
    canvas.drawCircle(
        Offset(center.dx, size.height * 0.5 - flowerSize / 2), flowerSize / 2, flowerPaint);
  }

  @override
  bool shouldRepaint(PlantPainter oldDelegate) {
    return oldDelegate.waterPercent != waterPercent ||
        oldDelegate.flowerColor != flowerColor;
  }
}
