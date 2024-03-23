import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/plant_data.dart';
import '../data/plant_model.dart';
import '../widgets/bottom_nav.dart';

class ContactsPage extends StatelessWidget{
  final Plants populerPlants;
  const ContactsPage({Key? key,required this.populerPlants,}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.green,
      automaticallyImplyLeading: false,
      title: const Padding(
        padding: EdgeInsets.all(50),
        child: Text('Benefits',style: TextStyle(fontSize: 22,),),),
      leading: IconButton(icon: const Icon(Icons.arrow_back),
        onPressed:()=> Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> const BottomNavBar())),),
    ),
      body:  SingleChildScrollView(
        child: Column(
              children: [ Image.asset(populerPlants.imagePath),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(populerPlants.name, style:  GoogleFonts.openSans(
                    fontSize: 24,
                  ),),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.lightGreen.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                child:  Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(populerPlants.description,
                      textAlign: TextAlign.justify,
                      style:  GoogleFonts.openSans(
                      fontSize: 21,

                    ),),
                  ),
                ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent.withOpacity(0.1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.lightBlueAccent.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(populerPlants.details1,
                        textAlign: TextAlign.justify,
                        style:  GoogleFonts.openSans(
                        fontSize: 21,
                      ) ,),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent.withOpacity(0.1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(populerPlants.detailsS2,
                        textAlign: TextAlign.justify,
                        style:  GoogleFonts.openSans(
                        fontSize: 21,
                      ) ,),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent.withOpacity(0.1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.lightGreenAccent.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(populerPlants.detailsS3,
                        textAlign: TextAlign.justify,
                        style:  GoogleFonts.openSans(
                        fontSize: 21,
                      ) ,),
                    ),
                  ),),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent.withOpacity(0.1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.lightBlue.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(populerPlants.details4,
                        textAlign: TextAlign.justify,
                        style:  GoogleFonts.openSans(
                        fontSize: 21,
                      ) ,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
                ),

      ),


    );
  }
}
class Benefits extends StatelessWidget{
  const Benefits({Key? key,required this.populerPlant}): super(key: key);
  final Plants populerPlant;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.green,
      automaticallyImplyLeading: false,
      title: const Padding(
        padding: EdgeInsets.all(50),
        child: Text('Benefits',style: TextStyle(fontSize: 24,),),),
      leading: IconButton(icon: const Icon(Icons.arrow_back),
        onPressed:()=> Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> const BottomNavBar())),),
    ),
      body:  SingleChildScrollView(
        child: Column(
          children: [

            Image.asset(populerPlant.imagePath),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(populerPlant.name, style:  GoogleFonts.openSans(
                fontSize: 24,
              ),),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.pinkAccent.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.1),
                    blurRadius: 100,
                    offset: const Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              width: double.infinity,
              child:  Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(populerPlant.description,
                    textAlign:TextAlign.justify,
                    style:  GoogleFonts.openSans(
                    fontSize: 21,
                  ),
                  ),
                ),
              ),),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.pinkAccent.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              width: double.infinity,
              child:  Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(populerPlant.details1,
                    textAlign:TextAlign.justify,
                    style:GoogleFonts.openSans(
                    fontSize: 21,
                  ) ,),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              width: double.infinity,
              child:  Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(populerPlant.detailsS2,
                    textAlign:TextAlign.justify,
                    style:  GoogleFonts.openSans(
                    fontSize: 21,
                  ) ,),
                ),
              ),),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.pinkAccent.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              width: double.infinity,
              child:  Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(populerPlant.detailsS3,
                    textAlign:TextAlign.justify,
                    style:  GoogleFonts.openSans(
                    fontSize: 21,
                  ) ,),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.pinkAccent.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              width: double.infinity,
              child:  Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(populerPlant.details4,
                    textAlign:TextAlign.justify,
                    style:  GoogleFonts.openSans(
                    fontSize: 21,
                  ) ,),
                ),
              ),),


          ],
        ),
      ),


    );
  }
}