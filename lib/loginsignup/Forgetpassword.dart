import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class  ForgptPasswordPage extends StatefulWidget {
  const ForgptPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgptPasswordPage> createState() => _ForgptPasswordPageState();
}

class _ForgptPasswordPageState extends State<ForgptPasswordPage> {
  final _emailController = TextEditingController();
  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }
  Future passwordReset() async{
    try{
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(context: context,
        builder:(context){
          return AlertDialog(
            content: Text('Password reset link sent! check your email'),
          );
        },
      );
    } on FirebaseAuthException catch (e){
      print(e);
      showDialog(context: context,
          builder:(context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
          },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 250,
            child: Image.asset('assets/images/Asset1.png'),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Enter your Email and we will send you a Password reset link',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              fontSize: 18,
            ),),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 25
            ),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Email',
                fillColor: Colors.grey.shade300,
                filled: true,
              ),
            ),
          ),
          MaterialButton(onPressed: passwordReset,
          child: Text('Reset Password'),
          color: Colors.deepPurple.shade200,),
        ],
      ),
    );
  }
}
