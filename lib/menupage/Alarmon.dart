import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../widgets/bottom_nav.dart';

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime selectedTime = DateTime.now();
  TextEditingController notesController = TextEditingController();
  int numNotes = 0;
  late FlutterLocalNotificationsPlugin localNotifications;
  late String selectedRingtone = 'default';

  @override
  void initState() {
    super.initState();
    getNotes();
    initLocalNotifications();
  }

  void initLocalNotifications() {
    localNotifications = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSettings = InitializationSettings(android: android);
    localNotifications.initialize(initSettings);
  }

  Future<void> scheduleNotification(String note) async {
    // Create a TZDateTime object with the desired date and time
    var scheduledNotificationDateTime = tz.TZDateTime.from(
      selectedDate.add(Duration(hours: selectedTime.hour, minutes: selectedTime.minute)),
      tz.local,
    );

    // Create an AndroidNotificationDetails object with the desired settings
    var android = AndroidNotificationDetails(
      'channel id', 'channel name',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      color: Colors.green,
      sound: RawResourceAndroidNotificationSound('ringtone_$selectedRingtone'),
    );

    // Create a NotificationDetails object with the AndroidNotificationDetails object
    var platform = NotificationDetails(android: android);

    // Schedule the notification using the zonedSchedule method
    await FlutterLocalNotificationsPlugin().zonedSchedule(
      0, 'Notes', note, scheduledNotificationDateTime, platform,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
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
      'numNotes': numNotes + 1,
      'time': selectedTime.toString(),
      'ringtone': selectedRingtone,
    });
    setState(() {
      numNotes += 1;
    });
    if (selectedTime != null) {
      scheduleNotification(text);
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Notes saved!',
        style: GoogleFonts.openSans(),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
    ));
  }

  void showNotesForSelectedDay() async {
    final notes = await FirebaseFirestore.instance
        .collection('notes')
        .doc('${selectedDate.year}-${selectedDate.month}-${selectedDate.day}')
        .get();
    if (notes.exists) {
      notesController.text = notes.data()!['text'];
      selectedTime = DateTime.parse(notes.data()!['time']);
      selectedRingtone = notes.data()!['ringtone'];
    } else {
      notesController.text = '';
      selectedTime = DateTime.now();
      selectedRingtone = 'default';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white60,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => BottomNavBar()));
            },
            icon:  Icon(Icons.arrow_back,color: Colors.grey.shade600,),
          ),
          title: Text(
            'Notes',
            style: GoogleFonts.openSans(),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
          padding: EdgeInsets.all(16),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Text(
    'Date:',
    style: GoogleFonts.openSans(fontSize: 20),
    ),
    SizedBox(height: 8),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
    style: GoogleFonts.openSans(fontSize: 20),
    ),
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.white38,
        backgroundColor: Colors.white30,
        foregroundColor: Colors.white30,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    onPressed: () async {
    final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2015, 8),
    lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
    setState(() {
    selectedDate = picked;
    showNotesForSelectedDay();
    getNotes();
    });
    },
    child: Text(
    'Select Date',
    style: GoogleFonts.openSans(fontSize: 16,color: Colors.grey.shade400),
    ),
    ),
    ],
    ),
    SizedBox(height: 16),
    Text(
    'Time:',
    style: GoogleFonts.openSans(fontSize: 20),
    ),
    SizedBox(height: 8),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    '${selectedTime.hour}:${selectedTime.minute}',
    style: GoogleFonts.openSans(fontSize: 20),
    ),
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.white38,
        backgroundColor: Colors.white12,
        foregroundColor: Colors.white30,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    onPressed: () async {
    final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(selectedTime),
    );
    if (picked != null)
    setState(() {
    selectedTime = DateTime(selectedTime.year, selectedTime.month, selectedTime.day, picked.hour, picked.minute);
    });
    },
    child: Text(
    'Select Time',
    style: GoogleFonts.openSans(fontSize: 16,color: Colors.grey.shade400),
    ),
    ),
    ],
    ),
    SizedBox(height: 16),
    Text(
    'Notes:',
    style: GoogleFonts.openSans(fontSize: 20),
    ),
    SizedBox(height: 8),
    TextField(
    controller: notesController,
    maxLines: null,
    keyboardType: TextInputType.multiline,
    decoration: InputDecoration(

    hintText: 'Enter your notes here',
    border: OutlineInputBorder(),
    ),
    ),
    SizedBox(height: 16),
    Text(
    'Ringtone:',
    style: GoogleFonts.openSans(fontSize: 20),
    ),
    SizedBox(height: 8),
    DropdownButton<String>(
    value: selectedRingtone,
    icon: Icon(Icons.arrow_drop_down),
    iconSize: 24,
    elevation: 16,
    style: GoogleFonts.openSans(fontSize: 20,color: Colors.black),
    onChanged: (String? newValue) {
    setState(() {
    selectedRingtone = newValue!;
    });
    },
    items: <String>['default', 'alarm1', 'alarm2', 'alarm3', 'alarm4', 'alarm5']
          .map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
    value: value,
    child: Text(value),
    );
    }).toList(),
    ),
    SizedBox(height: 20),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.white38,
          backgroundColor: Colors.white12,
          foregroundColor: Colors.white30,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
          onPressed: () {
            saveNotes(notesController.text);
          },
          child: Text(
            'Save Notes',
            style: GoogleFonts.openSans(fontSize: 20,color: Colors.grey.shade600),
          ),

      ),
    ],
    ),
          ),
        ),


    );
  }
}