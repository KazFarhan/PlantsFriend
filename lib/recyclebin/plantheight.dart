// import 'dart:async';
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:pdf_text/pdf_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:file_picker/file_picker.dart';
//
// class TextToSpeechPage1 extends StatefulWidget {
//   @override
//   _TextToSpeechPage1State createState() => _TextToSpeechPage1State();
// }
//
// class _TextToSpeechPage1State extends State<TextToSpeechPage1> {
//   // Initialize the text-to-speech engine.
//   late FlutterTts flutterTts;
//
//   // The text that will be read out loud.
//   String _text = '';
//
//   // The path of the file that will be read out loud.
//   String _filePath = '';
//
//   // Firebase Storage instance
//   final FirebaseStorage storage = FirebaseStorage.instance;
//
//   @override
//   void initState() {
//     super.initState();
//     flutterTts = FlutterTts();
//   }
//
//   @override
//   void dispose() {
//     // Stop the text-to-speech engine when the widget is disposed.
//     flutterTts.stop();
//     super.dispose();
//   }
//
//   /// Reads the contents of a file.
//   Future<void> _pickFile() async {
//     try {
//       final result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf'],
//       );
//       if (result != null) {
//         // Upload the file to Firebase Storage.
//         final file = File(result.files.single.path!);
//         final reference = storage.ref().child(result.files.single.name);
//         await reference.putFile(file);
//         setState(() {
//           _filePath = reference.fullPath;
//         });
//         await _readPdf(_filePath);
//
//       }
//     } catch (e) {
//       // Handle file picking error.
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('An error occurred while selecting the file.'),
//         ),
//       );
//     }
//   }
//
//   Future<void> _readPdf(String filePath) async {
//     try {
//       final ref = storage.ref().child(filePath);
//       final directory = await getTemporaryDirectory();
//       final file = File('${directory.path}/${filePath.split('/').last}');
//       await ref.writeToFile(file);
//       final pdfDoc = await PDFDoc.fromFile(file);
//       final pageCount = await pdfDoc.length;
//       final StringBuffer buffer = StringBuffer();
//       for (int i = 0; i < pageCount; i++) {
//         final page = await pdfDoc.pageAt(i);
//         final text = await page.text;
//         buffer.write(text);
//       }
//       setState(() {
//         _text = buffer.toString();
//         _filePath = filePath;
//       });
//     } catch (e) {
//       // Handle PDF reading error.
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('An error occurred while reading the PDF file.'),
//         ),
//       );
//     }
//   }
//
//
//   Future<void> _speak() async {
//     try {
//       if (_text.isNotEmpty) {
//         await flutterTts.setLanguage('en-US');
//         await flutterTts.setPitch(1.0);
//         final words = _text.split(' ');
//         for (final word in words) {
//           await flutterTts.speak(word);
//         }
//       } else {
//         // Show a message if no text is available.
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//             content: Text('Please select a PDF file first.'),
//             ),
//         );
//       }
//     } catch (e) {
// // Handle text-to-speech error.
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('An error occurred while reading the text.'),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Text to Speech'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _pickFile,
//               child: Text('Pick PDF file'),
//             ),
//             SizedBox(height: 16),
//             Text(
//               _filePath.isNotEmpty ? 'Selected file: ${_filePath.split('/').last}' : 'No file selected',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _speak,
//               child: Text('Speak'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
