import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_new_plants/loginsignup/signup.dart';
import 'package:my_new_plants/widgets/bottom_nav.dart';
import 'Forgetpassword.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

class SplashPage extends StatefulWidget{
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;



  Future<void> signIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sign In Error'),
          content: Text(e.toString().substring(31)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }




}
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 300,
                width: 450,
                child: Image.asset('assets/images/crot.jpg'),
              ),
              const SizedBox(height: 10),
               Text(
                'WELCOME',
                style:  GoogleFonts.robotoSerif(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                style:  GoogleFonts.openSans(
                  fontSize: 18,
                ),
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: "Enter Username",
                  labelText: "Username/Mobile Number"
              ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                style:  GoogleFonts.openSans(
                fontSize: 18,
              ),
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Password",
                  labelText: "Password",

              ),
              ),
              const SizedBox(width: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 150.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                      MaterialPageRoute(builder:(context){
                        return ForgptPasswordPage();
                      },
                      ),
                    );
                  },
                  child: Text(
                    'Forgot Password?',
                    style:  GoogleFonts.openSans(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              Stack(
                children: [
                  GestureDetector(
                    onTap: isLoading ? null : signIn,
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.yellowAccent.shade700,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (isLoading)
                    const Padding(
                      padding:  EdgeInsets.only(bottom: 100.0),
                      child:  Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.blue, // Replace with the color you want
                          ),
                        ),
                      ),
                    ),
                ],
              ),


              TextButton(onPressed: (){
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (builder)=> SignUpScreen()));
                      }, child: Text(
                        'Create an account',
                        style:  GoogleFonts.openSans(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      ),

                    ],
                  ),
          ),
        ),
    );
  }
}