// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:my_new_plants/widgets/bottom_nav.dart';
//
// class ProfileScreen extends StatefulWidget{
//
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   String? profilePic;
//   TextEditingController firstname = TextEditingController();
//   TextEditingController lastname = TextEditingController();
//   TextEditingController phone = TextEditingController();
//   TextEditingController email = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//
//   @override
//   void initState(){
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       if (FirebaseAuth.instance.currentUser!.displayName ==null){
//         SnackBar(content: Text('Please complete profile firstly',style: GoogleFonts.openSans(
//           fontSize: 18,),),);
//       } else{
//         FirebaseFirestore.instance
//             .collection('users')
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .get().then((DocumentSnapshot<Map<String, dynamic>> snapshot){
//               firstname.text =snapshot['name'];
//               lastname.text =snapshot['lastname'];
//               phone.text =snapshot['phone'];
//               email.text =snapshot['email'];
//               profilePic = snapshot['profilepic'];
//         });
//       }
//     });
//     super.initState();
//   }
//
//   bool isSaving = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Center(
//             child: Form(
//               key: formKey,
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 350.0),
//                     child: IconButton(icon: const Icon(Icons.arrow_back),
//                       onPressed:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>BottomNavBar())),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 20.0),
//                     child: Text('PROFILE',
//                     style: GoogleFonts.robotoSerif(
//                       fontSize: 27,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.grey.shade400,
//                     ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: GestureDetector(
//                       onTap: () async{
//                         final XFile? pickImage = await ImagePicker().pickImage(
//                             source: ImageSource.gallery,
//                         imageQuality: 60
//                         );
//                         if (pickImage!=null) {
//                           setState(() {
//                             profilePic = pickImage.path;
//                           },
//                           );
//
//                         }
//                     },
//                       child: Container(
//                         child:profilePic==null?
//                         CircleAvatar(
//                           radius: 70,
//                           child: Image.asset(
//                             'assets/images/profile.png',
//                           fit: BoxFit.fill,
//                           ),
//                         )
//                             : profilePic!.contains('http')
//                             ?CircleAvatar(
//                           radius: 70,
//                           backgroundImage: NetworkImage(profilePic!)
//
//                         )
//                               : CircleAvatar(
//                           radius: 70,
//                           backgroundImage: FileImage(File(profilePic!)),
//
//                       ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: 800,
//                     width: 350,
//                     child: Column(
//                       children: [
//                         SizedBox(height: 20),
//                         TextFormField(
//                           style: GoogleFonts.openSans(
//                             fontSize: 14,
//                           ),
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                               hintText: 'enter first name',
//                           ),
//                           controller: firstname,
//                           validator: (value){
//                             if (value!.isEmpty){
//                               return 'should not be empty';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           style: GoogleFonts.openSans(
//                             fontSize: 14,
//                           ),
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             hintText: 'enter last name',
//                           ),
//                           controller: lastname,
//                           validator: (value){
//                             if (value!.isEmpty){
//                               return 'should not be empty';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           style: GoogleFonts.openSans(
//                             fontSize: 14,
//                           ),
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             hintText: 'enter phone number',
//                           ),
//                           controller: phone,
//                           validator: (value){
//                             if (value!.isEmpty){
//                               return 'should not be empty';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           style: GoogleFonts.openSans(
//                             fontSize: 14,
//                           ),
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             hintText: 'enter email address',
//                           ),
//                           validator: (value){
//                             if (value!.isEmpty){
//                               return 'should not be empty';
//                             }
//                             return null;
//                           },
//                         ),
//                         TextButton(
//                           onPressed:(){
//                             if (formKey.currentState!.validate()){
//                               SystemChannels.textInput.invokeMapMethod('TextInput.hide');
//                             profilePic==null
//                                 ?ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(content: Text('select profile picture')))
//                                 :
//                             firstname.text.isEmpty?
//                             saveInfo(): update();
//                             }
//                           },
//                           child: Text(firstname.text.isEmpty?
//                           'Save':'Update',
//                           style: GoogleFonts.robotoSerif(
//                             fontSize: 24,
//                             color: Colors.grey.shade400
//                           ),
//                         ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ),
//         ),
//       ),
//     );
//   }
//   String? downloadUrl;
//   Future<String?> uploadImage(File filepath, String? reference) async {
//     try {
//       final finalName =
//           '${FirebaseAuth.instance.currentUser!.uid}${DateTime.now().second}';
//       final Reference fbStorage = FirebaseStorage.instance.ref(reference).child(finalName);
//       final UploadTask uploadTask = fbStorage.putFile(filepath);
//       await uploadTask.whenComplete(() async {
//         downloadUrl = await fbStorage.getDownloadURL();
//       });
//
//       return downloadUrl;
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
//
//
//   update(){
//     setState(() {
//       isSaving = true;
//     });
//     uploadImage(File(profilePic!), 'profile').whenComplete((){
//       Map<String,dynamic> data={
//         'firstname': firstname.text,
//         'lastname': lastname.text,
//         'phone' : phone.text,
//         'email': email.text,
//         'profilePic': profilePic,
//       };
//       FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(data).whenComplete((){
//         FirebaseAuth.instance.currentUser!.updateDisplayName(firstname.text);
//         setState(() {
//           isSaving = false;
//         });
//       });
//
//     });
//   }
//   saveInfo() {
//     setState(() {
//       isSaving = true;
//     });
//     uploadImage(File(profilePic!), 'profile').whenComplete((){
//       Map<String,dynamic> data={
//         'firstname': firstname.text,
//         'lastname': lastname.text,
//         'phone' : phone.text,
//         'email': email.text,
//         'profilePic': downloadUrl,
//       };
//       FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(data).whenComplete((){
//         FirebaseAuth.instance.currentUser!.updateDisplayName(firstname.text);
//         setState(() {
//           isSaving = false;
//         });
//       });
//
//     });
//   }
// }