import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/bottom_nav.dart';

class PlantGrowingGame extends StatefulWidget {
  @override
  _PlantGrowingGameState createState() => _PlantGrowingGameState();
}

class _PlantGrowingGameState extends State<PlantGrowingGame> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.all(30),
          child: Text('Play Game',style: GoogleFonts.robotoSerif(fontSize: 22),),),
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=> BottomNavBar())),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 300,
            width: 300,
            child: Image.asset('assets/images/seed.png'),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: TextButton(
              onPressed: () {
                _controller.forward();
              },
              child: Text("Water"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value,
                  child: Container(
                    height: 300,
                    width: 300,
                    child: Image.asset('assets/images/plant.png'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}