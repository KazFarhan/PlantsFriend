// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class UserProfile extends StatefulWidget {
//   @override
//   _UserProfileState createState() => _UserProfileState();
// }
//
// class _UserProfileState extends State<UserProfile> {
//   late File _image;
//   late String _uploadedFileURL;
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController ageController = TextEditingController();
//
//   Future chooseFile() async {
//     await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
//       setState(() {
//         _image = image! as File;
//       });
//     });
//   }
//
//   Future uploadFile() async {
//     StorageReference storageReference = FirebaseStorage.instance
//         .ref()
//         .child('profiles/${nameController.text}.jpg');
//     StorageUploadTask uploadTask = storageReference.putFile(_image);
//     await uploadTask.onComplete;
//     print('File Uploaded');
//     storageReference.getDownloadURL().then((fileURL) {
//       setState(() {
//         _uploadedFileURL = fileURL;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//         title: Text('User Profile'),
//     ),
//     body: SingleChildScrollView(
//     child: Form(
//     key: _formKey,
//     child: Column(
//     children: <Widget>[
//     Container(
//     width: double.infinity,
//     height: 200,
//     decoration: BoxDecoration(
//     image: DecorationImage(
//     image: _image != null
//     ? FileImage(_image)
//         : NetworkImage(
//     'https://via.placeholder.com/150x150',
//     ),
//     fit: BoxFit.cover,
//     ),
//     ),
//     ),
//     ElevatedButton(
//     onPressed: chooseFile,
//     child: Text('Choose File'),
//     ),
//     SizedBox(
//     height: 20,
//     ),
//     TextFormField(
//     controller: nameController,
//     decoration: InputDecoration(labelText: 'Name'),
//     validator: (value) {
//     if (value!.isEmpty) {
//     return 'Please enter your name';
//     }
//     return null;
//     },
//     ),
//     SizedBox(
//     height: 20,
//     ),
//     TextFormField(
//     controller: ageController,
//     decoration: InputDecoration(labelText: 'Age'),
//     validator: (value) {
//     if (value!.isEmpty) {
//     return 'Please enter your age';
//     }
//     return null;
//     },
//     ),
//     SizedBox(height: 20,
//     ),
//       ElevatedButton(
//         onPressed: () {
//           if (_formKey.currentState!.validate()) {
//             uploadFile();
//           }
//         },
//         child: Text('Save'),
//       ),
//     ],
//     ),
//     ),
//     ),
//     );
//   }
// }
//
