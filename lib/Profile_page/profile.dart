import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_new_plants/widgets/bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../menupage/privacy_policy.dart';



class Profile extends StatefulWidget{

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
   File? pickedImage;
  late String _imagepath;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Column(
              children: [
                const SizedBox(height: 2),
                Container(width: 20,
                  height: 20,
                decoration: BoxDecoration(color: Colors.grey.shade500,
                borderRadius: BorderRadius.circular(200)),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                       Text(
                        "Pic Image From",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                          fontSize: 18,
                        ),

                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                          backgroundColor: Colors.grey,
                        ),
                        onPressed: () {
                          pickImage(ImageSource.camera);
                        },
                        icon: const Icon(Icons.camera),
                        label:  Text("CAMERA",style: GoogleFonts.openSans(
                          fontSize: 16,
                        ),),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                          backgroundColor: Colors.grey,
                        ),

                        onPressed: () {
                          pickImage(ImageSource.gallery);
                        },
                        icon: const Icon(Icons.image),
                        label:  Text("GALLERY",style: GoogleFonts.openSans(
                          fontSize: 18,
                        ),),

                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                          backgroundColor: Colors.grey,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.close),
                        label:  Text("CANCEL", style: GoogleFonts.openSans(
                          fontSize: 18,
                        ),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.grey.shade500,
     appBar: AppBar(
       backgroundColor: Colors.grey,
       leading: IconButton(
         onPressed: (){

           Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>BottomNavBar()));
         },
         icon: Icon(Icons.arrow_back),),
     ),
     body: SingleChildScrollView(
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: [
           const SizedBox(height: 50,),
           SingleChildScrollView(
             child: Column(
               children: [
                 Container(color: Colors.white,
                 height: 600,
                 width: double.infinity,
                   child:Column(
                       children:  [
                         const SizedBox(
                           height: 20,
                         ),
                         Padding(
                           padding: const EdgeInsets.only(right:200.0),
                           child: Container(width:300,child: TextButton.icon(onPressed:(){
                             Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Profile()));
                           }, icon: const Icon(Icons.person,color: Colors.black,),
                               label: const Text('Profile',style: TextStyle(fontSize: 18,color: Colors.black),)),),
                         ),

                         Divider(),
                         SizedBox(height: 10,),
                         Padding(
                           padding: const EdgeInsets.only(right:200.0),
                           child: Container(width:300,child: TextButton.icon(onPressed:(){
                             Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>PrivacyPage()));
                           }, icon: const Icon(Icons.privacy_tip_outlined,color: Colors.black,),
                               label: const Text('Privacy policy',style: TextStyle(fontSize: 18,color: Colors.black),)),),
                         ),


                       ],

                     ),),
                 Container(color: Colors.white,
                   height: 50,
                   width: double.infinity,),


               ],
             ),
           )

         ],
       ),
     ),

   );
  }

  void saveImage(path) async{
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    saveImage.setString('ImagePath', path);
  }

  void loadImage() async{
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    setState((){
      _imagepath = saveImage.getString('ImagePath')!;
    }
    );

  }
}