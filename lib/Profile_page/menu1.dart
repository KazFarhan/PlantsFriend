import 'package:flutter/material.dart';


class Animat extends StatefulWidget {
  @override
  _AnimatState createState() => _AnimatState();
}

class _AnimatState extends State<Animat> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Animation'),
      ),
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: RotationTransition(
            turns: _animationController,
            child: Icon(
              Icons.favorite,
              color: Colors.white,
              size: 100,
            ),
          ),
        ),
      ),
    );
  }
}







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


class Waat extends StatefulWidget {
  @override
  _WaatState createState() => _WaatState();
}

class _WaatState extends State<Waat>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  Plant _plant = Plant(maxWaterLevel: 100, waterLevel: 0);

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
                color: Colors.green,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomPaint(
                        painter: WaterPainter(_plant.waterPercent),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: RotationTransition(
                      turns: _animationController,
                      child: Icon(
                        Icons.local_florist,
                        color: Colors.green[800],
                        size: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Water level: ${_plant.waterLevel}/${_plant.maxWaterLevel}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fillPlantWithWater,
              child: Text('Fill with water'),
            ),
          ],
        ),
      ),
    );
  }
}

class WaterPainter extends CustomPainter {
  final double waterPercent;

  WaterPainter(this.waterPercent);

  @override
  void paint(Canvas canvas, Size size) {
    final waterPaint = Paint()
      ..color = Colors.blue[300]!
      ..style = PaintingStyle.fill;
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
    return oldDelegate.waterPercent != waterPercent;
  }
}
