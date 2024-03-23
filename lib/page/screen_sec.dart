import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sunlight',
      home: Scaffold(
        appBar: AppBar(title: Text('Sunlight', style: TextStyle(color: Colors.orange),),),
        body: Center(
          child: Row(
            children: [
              const Center(
                  child: ButtonBar(
                    children: [Text("Go Back"),
                    ],
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
