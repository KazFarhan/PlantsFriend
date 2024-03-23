import 'package:flutter/material.dart';

import '../widgets/bottom_nav.dart';


class NightMode extends StatefulWidget {
  @override
  _NightModeState createState() => _NightModeState();
}

class _NightModeState extends State<NightMode> {
  Color _backgroundColor = Colors.white;

  void _changeBackgroundColor() {
    setState(() {
      _backgroundColor = _backgroundColor == Colors.white ? Colors.grey : Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder:(context)=>BottomNavBar()));
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text('Background Color Demo'),
      ),
      body: Container(
        color: _backgroundColor,
        child: Center(
          child: ElevatedButton(
            onPressed: _changeBackgroundColor,
            child: Text('Change Background Color'),
          ),
        ),
      ),
    );
  }
}
