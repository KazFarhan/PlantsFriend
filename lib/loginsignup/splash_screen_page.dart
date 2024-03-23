import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_new_plants/loginsignup/mainpage.dart';
import 'package:my_new_plants/loginsignup/splash_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}


class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState(){
    super.initState();
    _navigatetohome();
  }
  
  _navigatetohome()async{
    await Future.delayed(Duration(seconds: 3),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>SplashPage(),),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset('assets/images/PF.png',),
        ),
      ),
    );
  }
}