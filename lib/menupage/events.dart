import 'dart:async';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

import '../widgets/bottom_nav.dart';

class TextToSpeechPage extends StatefulWidget {
  @override
  _TextToSpeechPageState createState() => _TextToSpeechPageState();
}

class _TextToSpeechPageState extends State<TextToSpeechPage> {
  // Initialize the text-to-speech engine.
  late FlutterTts flutterTts;

  // The text that will be read out loud.
  String _text = '';

  // The path of the file that will be read out loud.
  String _filePath = '';

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
  }

  @override
  void dispose() {
    // Stop the text-to-speech engine when the widget is disposed.
    flutterTts.stop();
    super.dispose();
  }

  /// Reads the contents of a file.
  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        // Copy the file to the application documents directory.
        final file = File(result.files.single.path!);
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/${result.files.single.name}';
        await file.copy(filePath);
        setState(() {
          _filePath = filePath ?? '';
        });
        await _readPdf();
      }
    } catch (e) {
      // Handle file picking error.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while selecting the file.'),
        ),
      );
    }
  }

  Future<void> _readPdf() async {
    try {
      final file = File(_filePath);
      final pdfDoc = await PDFDoc.fromFile(file);
      final pageCount = await pdfDoc.length;
      final StringBuffer buffer = StringBuffer();
      for (int i = 0; i < pageCount; i++) {
        final page = await pdfDoc.pageAt(i);
        final text = await page.text;
        buffer.write(text);
      }
      setState(() {
        _text = buffer.toString();
        final FlutterTts flutterTts = FlutterTts();

      });
    } catch (e) {
      // Handle PDF reading error.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while reading the PDF file.',style: GoogleFonts.openSans()),
        ),
      );
    }
  }

  Future<void> _speak() async {
    try {
      if (_text.isNotEmpty) {
        await flutterTts.setLanguage('en-US');
        await flutterTts.setPitch(1.0);
        await flutterTts.speak(_text);
      } else {
        // Show a message if no text is available.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select a PDF file first.',style: GoogleFonts.openSans()),
          ),
        );
      }
    } catch (e) {
      // Handle speech synthesis error.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while speaking the text.',style: GoogleFonts.openSans()),
        ),
      );
    }
  }

  /// Stops the text-to-speech engine.
  Future<void> _stop() async {
    try {
      await flutterTts.stop();
    } catch (e) {
      // Handle speech stop error.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while stopping the speech.',style: GoogleFonts.openSans()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white60,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => BottomNavBar()));
            },
            icon:  Icon(Icons.arrow_back,color: Colors.grey.shade600,),
          ),
          title: Center(child: Text('Text-to-Speech Example',style: GoogleFonts.openSans(
            color: Colors.grey.shade400
          ),)),
        ),
        body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [// The "Select File" button.
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.white38,
          backgroundColor: Colors.white60,
          foregroundColor: Colors.white30,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: _pickFile,
        child: Text('Select File',style: GoogleFonts.openSans(color: Colors.black)),
      ),
      SizedBox(height: 16.0),
// The file path label.
      Text(
        _filePath.isNotEmpty ? 'File: $_filePath' : 'No file selected.',style: GoogleFonts.openSans(),
      ),
      SizedBox(height: 16.0),
// The "Read File" button.
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.white38,
          backgroundColor: Colors.white60,
          foregroundColor: Colors.white30,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: _readPdf,
        child: Text('Read File',style: GoogleFonts.openSans(color: Colors.black)),
      ),
      SizedBox(height: 16.0),
// The text-to-speech controls.
      Text(
        'Text-to-Speech Controls',style: GoogleFonts.openSans(),

      ),
      SizedBox(height: 16.0),
// The "Speak" button.
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.white38,
          backgroundColor: Colors.white60,
          foregroundColor: Colors.white30,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: _speak,
        child: Center(child: Text('Speak',style: GoogleFonts.openSans(color: Colors.black))),
      ),
      SizedBox(height: 16.0),
// The "Stop" button.
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.white38,
          backgroundColor: Colors.white60,
          foregroundColor: Colors.white30,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: _stop,
        child: Text('Stop',style: GoogleFonts.openSans(color: Colors.black)),
      ),
    ],
    ),
        ),
    );
  }
}

