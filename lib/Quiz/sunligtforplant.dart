import 'package:flutter/material.dart';



class MyHomePage2 extends StatefulWidget {
  @override
  _MyHomePage2State createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Color _color;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {
          _color = _getColor(_animation.value);
        });
      });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bucket Fill Animation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRect(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  heightFactor: _animation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Color: ${_color.toString()}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor(double value) {
    if (value < 0.25) {
      return Colors.transparent;
    } else if (value < 0.5) {
      return Colors.blue[100]!;
    } else if (value < 0.75) {
      return Colors.blue[200]!;
    } else {
      return Colors.blue;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}