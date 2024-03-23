import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/bottom_nav.dart';

class HomePage4 extends StatefulWidget {
  @override
  _HomePage4State createState() => _HomePage4State();
}

class _HomePage4State extends State<HomePage4> {
  DateTime selectedDate = DateTime.now();
  TextEditingController notesController = TextEditingController();
  int numNotes = 0;

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  void getNotes() async {
    final notes = await FirebaseFirestore.instance
        .collection('notes')
        .doc('${selectedDate.year}-${selectedDate.month}-${selectedDate.day}')
        .get();
    if (notes.exists) {
      setState(() {
        numNotes = notes.data()!['numNotes'];
      });
    }
  }

  void saveNotes(String text) async {
    await FirebaseFirestore.instance
        .collection('notes')
        .doc('${selectedDate.year}-${selectedDate.month}-${selectedDate.day}')
        .set({
      'text': text,
      'numNotes': numNotes + 1
    });
    setState(() {
      numNotes += 1;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Notes saved!', style: GoogleFonts.openSans()),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
    ));
  }


  void deleteNote() async {
    final notes = await FirebaseFirestore.instance
        .collection('notes')
        .doc('${selectedDate.year}-${selectedDate.month}-${selectedDate.day}')
        .get();
    if (notes.exists) {
      setState(() {
        numNotes = notes.data()!['numNotes'];
      });
    }

    if (numNotes > 0) {
      await FirebaseFirestore.instance
          .collection('notes')
          .doc('${selectedDate.year}-${selectedDate.month}-${selectedDate.day}')
          .update({
        'numNotes': numNotes - 1
      });

      setState(() {
        numNotes -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => BottomNavBar()));
            },
            icon:  Icon(Icons.arrow_back,color: Colors.grey.shade400,),
          ),
          title: Text(
            'Notes',
            style: GoogleFonts.openSans(color: Colors.grey.shade600),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
    children: [
    SizedBox(height: 10),
    GestureDetector(
    onTap: () async {
    final pickedDate = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2000),
    lastDate: DateTime.now().add(Duration(days: 365)));
    if (pickedDate != null) {
    setState(() {
    selectedDate = pickedDate;
    numNotes = 0;
    });
    getNotes();
    }
    },
    child: Container(
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
    BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    blurRadius: 10,
    offset: Offset(0, 5),
    ),
    ],
    ),
    child: Stack(
    children: [
    Text(
    '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
    style: TextStyle(fontSize: 24),
    ),
    if (numNotes > 0)
    Positioned(
    top: 0,
    right: 0,
    child: Container(
    decoration: BoxDecoration(
    color: Colors.red,
    borderRadius: BorderRadius.circular(10),
    ),
    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(
        '$numNotes',
        style: TextStyle(color: Colors.white),
      ),
    ),
    ),
    ],
    ),
    ),
    ),
      SizedBox(height: 20),
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Notes',
                  style: GoogleFonts.openSans(color: Colors.grey.shade600,
                  fontSize: 24),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('notes')
                        .doc(
                        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final data = snapshot.data!.data() as Map<String, dynamic>?;
                      if (data == null || !data.containsKey('text')) {
                        return Center(
                          child: Text('No notes found.',style: GoogleFonts.openSans(color: Colors.grey.shade600,
                              fontSize: 18),),
                        );
                      }

                      return SingleChildScrollView(
                        child: Text(data['text']),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  style: GoogleFonts.openSans(color: Colors.grey.shade600,
                      fontSize: 14),
                  controller: notesController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Add a new note',

                  ),
                  minLines: 1,
                  maxLines: null,
                ),
                ListView.builder(
                  itemCount: numNotes,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        'Note ${index + 1}',
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '',
                        style: GoogleFonts.openSans(),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: deleteNote,
                      ),
                    );
                  },
                ),


                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    saveNotes(notesController.text);
                    notesController.clear();
                  },
                  child: Text('Save note',style: GoogleFonts.openSans(),)
                ),
              ],
            ),
          ),
        ),
      ),
    ],
    ),
        ),
    );
  }
}
