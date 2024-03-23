import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_new_plants/data/category_model.dart';
import 'package:my_new_plants/data/plant_data.dart';
import 'package:my_new_plants/page/Benefit.dart';
import 'package:my_new_plants/menupage/notifications.dart';
import 'package:my_new_plants/menupage/send_feedback.dart';
import 'package:my_new_plants/page/details_page.dart';
import 'package:my_new_plants/page/searchpage.dart';
import 'package:my_new_plants/Profile_page/profile.dart';
import '../Quiz/plantsquiz.dart';
import '../Quiz/sunligtforplant.dart';
import '../categories/Outdoor_plant.dart';
import '../loginsignup/splash_screen_page.dart';
import '../menupage/events.dart';
import '../menupage/bookreader.dart';
import '../menupage/nutriitioncal.dart';
import '../menupage/notes.dart';
import '../recyclebin/doc/loginpage.dart';
import '../recyclebin/plantalarm.dart';
import '../menupage/Alarmon.dart';
import '../recyclebin/plantheight.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  bool isExpanded = false;
  bool issExpanded = false;
  late String _plantName;
  late DateTime _wateringTime;
  void _showReminder() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text("Welcome!"),
        content: Text("It's time to Care of $_plantName"),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _plantName = "Plants";
    _wateringTime = DateTime.now().add(Duration(hours: 24));
    Timer(_wateringTime.difference(DateTime.now()), _showReminder);
  }
  final user = FirebaseAuth.instance.currentUser;
  PageController controller= PageController();
  int selectIndex = 0;
  @override

  void iniState(){
    controller = PageController(viewportFraction: 0.8, initialPage: 0);
    super.initState();
  }

  Widget build(BuildContext context) {

   return Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(
      backgroundColor: Colors.grey.shade400,
       shadowColor: Colors.white60,
     ),

     body: Container(
       decoration:  BoxDecoration(
           gradient: LinearGradient(
               begin: Alignment.topLeft,
               end: Alignment.bottomRight,
               colors: [Colors.white70,Colors.grey.shade200]
           )
       ),
       child: SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
            Padding(
              padding: const EdgeInsets.only(left: 340.0, top: 10),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>SearchPage()));
                  },
                  child: Center(child: Icon(Icons.search,size: 30,color: Colors.grey.shade400,)),
                ),
              ),
            ),

             SizedBox(
               height: 30,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [

                   for(int i = 0; i < categories.length; i++)
                     GestureDetector(
                       onTap: (){
                         setState(()=>
                         selectId =categories[i].id,);
                         Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>PlantDecoration()));

                       },
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           Text(categories[i].name,
                             style:GoogleFonts.robotoSerif(
                               color: selectId == i
                                   ? Colors.green
                                   :Colors.black.withOpacity(0.7),
                               fontSize: 18,
                       ),
                           ),
                           if(selectId==i)
                             const CircleAvatar(
                               radius: 3,
                               backgroundColor: Colors.green,
                             )

                         ],
                       ),
                     )
                 ],
               ),
             ),
             Center(
               child: SizedBox(width: 400,
                 height: 300.0,
                 child: PageView.builder(
                     itemCount: plants.length,
                     controller: controller,
                     physics: const BouncingScrollPhysics(),
                     padEnds: false,
                     pageSnapping: true,
                     onPageChanged: (value)=> setState(() => activePage = value),
                     itemBuilder: (itemBuilder, index){
                       bool active = index == activePage;
                       return  slider(active, index);
                     },
                 ),
               ),
             ),
             const SizedBox(height: 50),
             Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                       'Advantages of Indoor Plants',
                     style:GoogleFonts.robotoSerif(
                       fontSize: 18,
                     ),
                   ),
                   const SizedBox(height: 20),

                       IconButton(
                         icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                         onPressed: () {
                           setState(() {
                             issExpanded = !issExpanded;
                           });
                         },
                       ),
                     ],
           ),
                 ),
               ],
             ),
             const SizedBox(height: 10),
             SizedBox(
               height: issExpanded ? 300 : 0,
               child: ListView.builder(
                   itemCount: populerPlants.length,
                   physics: const BouncingScrollPhysics(),
                   padding: const EdgeInsets.only(left: 10),
                   scrollDirection: Axis.vertical,
                   itemBuilder: (itemBuilder, index){
                 return TextButton(
                   onPressed: (){
                     Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>  ContactsPage(populerPlants: populerPlants[index])));
                   },
                   child: Container(
                     height: 100,
                     width: double.infinity,
                     margin: const EdgeInsets.only(bottom: 10),
                     decoration: BoxDecoration(
                     color: Colors.grey.withOpacity(0.2),
                     boxShadow: [
                       BoxShadow(
                         color: Colors.white60.withOpacity(0.8),
                         blurRadius: 10,
                         offset: const Offset(5, 5),
                       ),
                     ],
                     borderRadius: BorderRadius.circular(10),
                   ),
                     child: Stack(
                       children: [
                         Row(
                           children: [Image.asset(
                             populerPlants[index].imagePath,
                             width: 80,
                             height: 80,
                           ),
                             const SizedBox(width: 10),
                             Column(crossAxisAlignment: CrossAxisAlignment.start,
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(
                                   populerPlants[index].name,
                                   style: GoogleFonts.openSans(
                                     fontSize: 16,
                                     color: Colors.black
                                   ),

                                   ),

                               ],
                             ),
                           ],
                         ),

                       ],
                     ),
                   ),
                 );
               },
               ),
             ),

             const SizedBox(height: 50),
             Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         'Advantages of Outdoor Plants',
                         style:GoogleFonts.robotoSerif(
                           fontSize: 18,
                         ),
                       ),
                       const SizedBox(height: 20),
                       IconButton(
                         icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                         onPressed: () {
                           setState(() {
                             isExpanded = !isExpanded;
                           });
                         },
                       ),
                     ],
                   ),
                 ),
               ],
             ),
             const SizedBox(height: 10),
              SizedBox(
                 width: double.infinity,
                height: isExpanded ? 300 : 0,
                 child: ListView.builder(
                   itemCount: populerPlant.length,
                   physics: const BouncingScrollPhysics(),
                   padding: const EdgeInsets.only(left: 1),
                   scrollDirection: Axis.vertical,
                   itemBuilder: (itemBuilder, index){
                     return TextButton(
                       onPressed: (){
                         Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Benefits( populerPlant: populerPlant[index],)));
                       },
                       child: Container(
                         height: 100,
                         width: double.infinity,
                         margin: const EdgeInsets.only(bottom: 10),
                         decoration: BoxDecoration(
                           color: Colors.grey.withOpacity(0.2),
                           boxShadow: [
                             BoxShadow(
                               color: Colors.white60.withOpacity(0.8),
                               blurRadius: 10,
                               offset: const Offset(0, 5),
                             ),
                           ],
                           borderRadius: BorderRadius.circular(10),
                         ),
                         child: Stack(
                           children: [
                             Row(
                               children: [Image.asset(
                                 populerPlant[index].imagePath,
                                 width: 100,
                                 height: 80,
                               ),
                                 const SizedBox(width: 10),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Text(
                                       populerPlant[index].name,
                                       style: GoogleFonts.openSans(
                                           fontSize: 16,
                                           color: Colors.black
                                       ),
                                     ),

                                   ],
                                 ),
                               ],
                             ),

                           ],
                         ),
                       ),
                     );
                   },
                 ),
               ),
           ],
        ),

       ),
     ),
     drawer: Drawer(
       child: SingleChildScrollView(
         child: Column(
           children: [
             MyDrawerlist(),
           ],
         ),
       ),
     ),
    );

  }
  AnimatedContainer slider(active, index){
    double margin = active ? 5:50;

    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOutCubic,
      margin: EdgeInsets.all(margin),
      child: mainPlantsCard(index),
    );
  }
  Widget mainPlantsCard(index){
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context, MaterialPageRoute(
          builder: (builder)=>  DetailsPage(plant:plants[index]),
        ),
        );
      },
      child: Container(
      padding: const EdgeInsets.all( 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(5, 5),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200,width: 2),
        borderRadius: BorderRadius.circular(40),
      ),
        child: Stack(
          children: [
            Container(
            decoration: BoxDecoration(
            color: Colors.white60,
            boxShadow: [
              BoxShadow(
                color: Colors.white70.withOpacity(0.8),
                blurRadius: 40,
                offset: const Offset(5, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(40),
              image: DecorationImage(
                image: AssetImage(plants[index].imagePath),
                fit: BoxFit.cover,
              ),
          ),
          ),
            Positioned(
              right: 8,
                top: 20,
                child: CircleAvatar(
              backgroundColor: Colors.yellowAccent.withOpacity(0.7),
                  radius: 15,
                  child: Image.asset('assets/icons/add.png',
                  color: Colors.blue,
                  height: 15,
                  ),
            ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
                child:Padding(
                padding:const EdgeInsets.only(bottom: 1),
                  child: Text(
                    '${plants[index].name} ',
                    style: GoogleFonts.openSans(
                      fontSize: 24,
                      color: Colors.yellowAccent,
                      fontWeight: FontWeight.w500,
                    ),
                    ),
                  ),

            ),
          ],
        ),
      ),
    );

  }
  int selectId =0;
  int activePage =0;
Widget MyDrawerlist(){
  return Container(
    padding: const EdgeInsets.only(top:200,right: 100),
    child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: TextButton.icon(onPressed:(){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Profile()));
                }, icon: const Icon(Icons.settings_outlined,color: Colors.grey),
                    label:  Text('Settings',style: GoogleFonts.robotoSerif(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),),),
              ),
              const SizedBox(height: 10,),
              TextButton.icon(onPressed:(){
                Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>NotificationsPage()));
              }, icon: const Icon(Icons.notifications,color: Colors.grey,),
                  label:  Text('Notifications',style: GoogleFonts.robotoSerif(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),),),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextButton.icon(onPressed:(){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>FeedbackPage()));
                }, icon: const Icon(Icons.feedback_outlined,color: Colors.grey,),
                    label:  Text('Send feedback',style: GoogleFonts.robotoSerif(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),),),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(right: 60.0),
                child: TextButton.icon(onPressed:(){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>AlarmScreen()));
                }, icon: const Icon(Icons.alarm,color: Colors.grey,),
                  label:  Text('Alarm',style: GoogleFonts.robotoSerif(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),),),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: TextButton.icon(onPressed:(){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>MyHomePage4()));
                }, icon: const Icon(Icons.cloud,color: Colors.grey,),
                  label:  Text('Animate',style: GoogleFonts.robotoSerif(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),),),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: TextButton.icon(onPressed:(){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>MindMapScreen()));
                }, icon: const Icon(Icons.note_add,color: Colors.grey,),
                  label:  Text('Notes',style: GoogleFonts.robotoSerif(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),),),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: TextButton.icon(onPressed:(){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Nutrition()));
                }, icon: const Icon(Icons.menu_book_sharp,color: Colors.grey,),
                  label:  Text('Nutrition',style: GoogleFonts.robotoSerif(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),),),
              ),
              const SizedBox(height: 10,),
              TextButton.icon(onPressed:(){
                Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>BookReader()));
              }, icon: const Icon(Icons.book,color: Colors.grey,),
                label:  Text('Read PDF',style: GoogleFonts.robotoSerif(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),),),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(right: 60.0),
                child: TextButton.icon(onPressed:(){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>HomePage4()) );
                }, icon: const Icon(Icons.note,color: Colors.grey,),
                  label:  Text('Notes',style: GoogleFonts.robotoSerif(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),),),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: TextButton.icon(onPressed:(){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>TextToSpeechPage()) );
                }, icon: const Icon(Icons.speaker,color: Colors.grey,),
                  label:  Text('Text Speech',style: GoogleFonts.robotoSerif(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),),),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: MaterialButton(
                  onPressed:() async {
                    bool confirmLogout = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Logout Confirmation",style: GoogleFonts.openSans(),),
                        content: Text("Are you sure you want to logout?",style: GoogleFonts.openSans(),),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text("Cancel",style: GoogleFonts.openSans(),),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text("Logout",style: GoogleFonts.openSans(),),
                          ),
                        ],
                      ),
                    );

                    if (confirmLogout) {
                      await FirebaseAuth.instance.signOut();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Splashscreen()));
                    }
                  },
                  color: Colors.white,
                  child:  Text('Sign Out', style: GoogleFonts.robotoSerif(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                  ),
                ),
              ),

            ],
          ),

  );
}

}
