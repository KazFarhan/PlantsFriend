import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:google_fonts/google_fonts.dart';


import '../widgets/bottom_nav.dart';

class BookReader extends StatefulWidget {
  @override
  _BookReaderState createState() => _BookReaderState();
}

class _BookReaderState extends State<BookReader> {
  final FlutterTts flutterTts = FlutterTts();
  String _selectedFileName = '';
  String _pdfText = '';
  PDFDoc? _pdfDoc;
  bool _isPlaying = false;
  bool _isPaused = false;
  int _currentPage = 1;
  int _numPages = 0;
  double _sliderValue = 1.0;
  File? file;
  String _selectedLanguage = 'English';


  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null && result.files.first != null) {
        file = File(result.files.first.path!);
        _pdfDoc = await PDFDoc.fromFile(file!);
        final numPages = await _pdfDoc!.length;
        setState(() {
          _numPages = numPages;
          _currentPage = 1;
          _sliderValue = 1.0; // reset slider value
          _selectedFileName = result.files.first.name;
        });
        _goToPage(1);
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }


  Future<void> _speak() async {
    try {
      await flutterTts.setLanguage(_selectedLanguage == 'English' ? 'en-US' : 'hi-IN');
      await flutterTts.setPitch(1.0);
      await flutterTts.setSpeechRate(0.5);
      String textToSpeak = _pdfText;
      if (_selectedLanguage == 'Hindi') {
        // filter out non-Hindi characters using a regular expression
        final hindiRegex = RegExp('\\p{InDevanagari}+');
        textToSpeak = textToSpeak.split('').where((c) => hindiRegex.hasMatch(c)).join();
      }
      await flutterTts.speak(textToSpeak);
      setState(() {
        _isPlaying = true;
      });
      await flutterTts.awaitSpeakCompletion(true);
      setState(() {
        _isPlaying = false;
      });
    } catch (e) {
      print('Error speaking text: $e');
    }
  }



  Future<void> _pause() async {
    try {
      await flutterTts.pause();
      setState(() {
        _isPaused = true;
      });
    } catch (e) {
      print('Error pausing speech: $e');
    }
  }

  Future<void> _stop() async {
    try {
      await flutterTts.stop();
      setState(() {
        _isPlaying = false;
        _isPaused = false;
      });
    } catch (e) {
      print('Error stopping speech: $e');
    }
  }

  Future<void> _clearText() async {
    setState(() {
      _pdfText = '';
    });
  }

  void _goToPage(int page) async {
    final pdfDoc = await PDFDoc.fromFile(file!);
    final currentPage = await pdfDoc.pageAt(page - 1);
    final text = await currentPage.text;
    setState(() {
      _pdfText = text;
      _currentPage = page;
      _sliderValue = page.toDouble();
    });
  }

  void _selectPage(int selectedPage) {
    _goToPage(selectedPage);
  }




  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed:()=> Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>BottomNavBar())),),

        title: Text('Book Reader'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/imagefk.jpg'),
            opacity: 0.4,
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: _pickFile,
                child: Text('Select PDF File'),
              ),
              SizedBox(height: 16.0),
              Text(
                _selectedFileName,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Select Language:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(width: 16.0),
                  DropdownButton<String>(
                    value: _selectedLanguage,
                    items: <String>['English', 'Hindi'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedLanguage = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: SingleChildScrollView(
                  child: SelectableText(
                    textAlign: TextAlign.justify,
                    _pdfText,
                    style: GoogleFonts.openSans(
                      fontSize: 18.0,
                      height: 1.5,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: _pdfText));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Text copied to clipboard')),
                      );
                    },
                  ),
                ),
              ),

              DropdownButton<int>(
                value: _currentPage,
                items: List.generate(_numPages, (index) => index + 1)
                    .map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('Page $value'),
                  );
                })
                    .toList(),
                onChanged: (int? value) {
                  if (value != null) {
                    _selectPage(value);
                  }
                },
              ),

              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: _isPlaying ? null : _speak,
                    icon: Icon(Icons.play_arrow),
                    tooltip: 'Play',
                  ),
                  IconButton(
                    onPressed: _isPlaying || _isPaused ? null : _pause,
                    icon: Icon(Icons.pause),
                    tooltip: 'Pause',
                  ),
                  IconButton(
                    onPressed: _isPlaying ? null : _stop,
                    icon: Icon(Icons.stop),
                    tooltip: 'Stop',
                  ),
                  IconButton(
                    onPressed: _clearText,
                    icon: Icon(Icons.clear),
                    tooltip: 'Clear',
                  ),

                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Page $_currentPage of $_numPages',
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                      )
                  ),
                  SizedBox(
                    width: 200.0,
                    child: _numPages > 0
                        ? Slider(
                      min: 1,
                      max: _numPages.toDouble(),
                      value: _sliderValue,
                      onChanged: (double value) {
                        setState(() {
                          _sliderValue = value;
                          _selectPage(value.round());
                        });
                      },
                    )
                        : SizedBox(),


                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}