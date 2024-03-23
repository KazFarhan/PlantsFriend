// import 'dart:io';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image/image.dart' as img;
// import 'dart:ui';
//
//
//
// class PlantHeightDetector extends StatefulWidget {
//   @override
//   _PlantHeightDetectorState createState() => _PlantHeightDetectorState();
// }
//
// class _PlantHeightDetectorState extends State<PlantHeightDetector> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   late File _image;
//   double _plantHeight = 0.0;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Get the list of available cameras.
//     availableCameras().then((cameras) {
//       // Select the back camera.
//       CameraDescription backCamera = cameras.firstWhere(
//             (camera) => camera.lensDirection == CameraLensDirection.back,
//       );
//
//       // Create a CameraController and initialize it.
//       _controller = CameraController(
//         backCamera,
//         ResolutionPreset.medium,
//       );
//       _initializeControllerFuture = _controller.initialize();
//     });
//   }
//
//   @override
//   void dispose() {
//     // Dispose of the camera controller when the widget is disposed.
//     _controller.dispose();
//     super.dispose();
//   }
//
//   Future<void> _getImageFromCamera() async {
//     // Ensure that the camera is initialized before taking a picture.
//     try {
//       await _initializeControllerFuture;
//
//       // Take the picture and save it to a temporary file.
//       final image = await _controller.takePicture();
//
//       setState(() {
//         _image = File(image.path);
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<void> _getImageFromGallery() async {
//     // Select an image from the device's gallery.
//     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//
//     setState(() {
//       _image = File(image!.path);
//     });
//   }
//
//   void _detectPlantHeight() async {
//     if (_image == null) {
//       // If no image is selected, display an error message.
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text('Please select an image.'),
//             actions: <Widget>[
//               ElevatedButton(
//                 child: Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//       return;
//     }
//
//     // Load the image using the image package.
//     final imageBytes = await _image.readAsBytes();
//     final decodedImage = img.decodeImage(imageBytes);
//
//     // Detect the reference object and plant in the image.
//     final referenceObjectRect = await _detectReferenceObject(decodedImage!);
//     final plantRect = await _detectPlant(decodedImage);
//
//     if (referenceObjectRect == null) {
//       // If the reference object cannot be detected, display an error message.
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text('Could not detect the reference object.'),
//             actions: <Widget>[
//               ElevatedButton(
//                 child: Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//       return;
//     }
//
//     if (plantRect == null) {
//       // If the plant cannot be detected, display an error message.
//       showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Error'),
//               content: Text('Could not detect the plant.'),
//               actions: <Widget>[
//                 ElevatedButton(
//                   child: Text('OK'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//           }
//             );
//
//     return;
//   }
//           // Calculate the plant height based on the size of the plant and the reference object.
//           final referenceObjectHeight = referenceObjectRect.height.toDouble();
//       final plantHeight = plantRect.height.toDouble();
//       final scaleFactor = _plantHeight / referenceObjectHeight;
//       final actualPlantHeight = plantHeight * scaleFactor;
//
// // Display the plant height in an alert dialog.
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Plant Height'),
//             content: Text('${actualPlantHeight.toStringAsFixed(2)} cm'),
//             actions: <Widget>[
//               ElevatedButton(
//                 child: Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//
//     Future<img.Rectangle?> _detectReferenceObject(img.Image image) async {
// // TODO: Implement reference object detection.
//       return null;
//     }
//
//     Future<img.Rectangle?> _detectPlant(img.Image image) async {
// // TODO: Implement plant detection.
//       return null;
//     }
//
//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Plant Height Detector'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               _image == null
//                   ? Text('No image selected.')
//                   : Image.file(_image),
//               SizedBox(height: 20),
//               OutlinedButton(
//                 child: Text('Take picture'),
//                 onPressed: _getImageFromCamera,
//               ),
//               SizedBox(height: 20),
//               OutlinedButton(
//                 child: Text('Select from gallery'),
//                 onPressed: _getImageFromGallery,
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Enter the height of the reference object (cm)',
//                 ),
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   setState(() {
//                     _plantHeight = double.tryParse(value) ?? 0.0;
//                   });
//                 },
//               ),
//               SizedBox(height: 20),
//               OutlinedButton(
//                 child: Text('Detect plant height'),
//                 onPressed: _detectPlantHeight,
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//   }
//
