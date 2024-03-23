import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import '../widgets/bottom_nav.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  late File _image;
  img.Image? _adjustedImage;
  double _rotation = 0.0;
  double _scale = 1.0;

  late String name = '';
  late String email = '';
  late String phone = '';

  String get _userId => _auth.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final snapshot = await _firestore.collection('users').doc(_userId).get();
    final data = snapshot.data();

    setState(() {
      name = data!['name'] ?? '';
      email = data!['email'] ?? '';
      phone = data!['phone'] ?? '';
    });
  }

  Future<void> _getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
        _adjustedImage = img.decodeImage(_image.readAsBytesSync())!;
        _adjustedImage = _resizeImage(_adjustedImage!); // resize the image
      });
    }
  }

  void _rotateImage(double angle) {
    setState(() {
      _rotation += angle;
      _adjustedImage = img.copyRotate(_adjustedImage!, angle:angle);
    });
  }


  void _scaleImage(double scale) {
    setState(() {
      _scale *= scale;
      _adjustedImage = img.copyResize(_adjustedImage!, width: (_adjustedImage!.width * _scale).toInt());
    });
  }
  img.Image _resizeImage(img.Image image) {
    const int maxSize = 1024; // max size of the image in pixels
    if (image.width <= maxSize && image.height <= maxSize) {
      return image; // no need to resize if already small
    }

    double ratio = 1.0;
    if (image.width > image.height) {
      ratio = maxSize / image.width;
    } else {
      ratio = maxSize / image.height;
    }

    final resizedImage = img.copyResize(image, height: (image.height * ratio).toInt());

    return resizedImage;
  }


  Future<void> _saveChanges() async {
    final updateData = <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
    };

    if (_adjustedImage != null) {
      final reference = _storage.ref().child('profile_images/$_userId.png');
      await reference.putData(Uint8List.fromList(img.encodePng(_adjustedImage!)));
      final imageUrl = await reference.getDownloadURL();
      updateData['ImageUrl'] = imageUrl;
    }


    await _firestore.collection('users').doc(_userId).update(updateData);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Profile updated successfully.',style: GoogleFonts.openSans(),),
    ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white60,
          shadowColor: Colors.white60,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder:(context)=>BottomNavBar()));
            },
            icon:  Icon(Icons.arrow_back,color: Colors.grey.shade400,),
          ),
        title: Center(child: Text('Update Profile',style: GoogleFonts.openSans(
          color: Colors.grey.shade400,
        ),)),

    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
        child: StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection('users').doc(_userId).snapshots(),
        builder: (context, snapshot) {
        if (!snapshot.hasData) {
        return CircularProgressIndicator();
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;

        return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        SizedBox(
        width: 200,
        height: 200,
          child: GestureDetector(
            onTap: _getImage,
            child: _adjustedImage != null
                ? Transform.rotate(
              angle: _rotation,
              child: Image.memory(
                Uint8List.fromList(img.encodePng(_adjustedImage!)),
                fit: BoxFit.cover,
              ),
            )
                : CircleAvatar(
              backgroundImage: data['ImageUrl'] != null
                  ? NetworkImage(data['ImageUrl'])
                  : null,
            ),
          ),
        ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.rotate_left),
                onPressed: () => _rotateImage(-45.0),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.rotate_right),
                onPressed: () => _rotateImage(45.0),
              ),

              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.zoom_in),
                onPressed: () => _scaleImage(1.5),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.zoom_out),
                onPressed: () => _scaleImage(0.5),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            style: GoogleFonts.openSans(
              color: Colors.black, // change the text color
              fontSize: 16,),
            decoration: InputDecoration(
              hintText: 'Name',
              labelText: 'Name',
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              suffixIcon: Icon(Icons.person,color: Colors.grey.shade400,),
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            ),
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            controller: TextEditingController(text: name),
          ),
          const SizedBox(height: 10),
          TextField(
          style: GoogleFonts.openSans(
          color: Colors.black, // change the text color
          fontSize: 16,),
          decoration: InputDecoration(
          hintText: 'Email',
          labelText: 'Email',
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          suffixIcon: Icon(Icons.email,color: Colors.grey.shade400),
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          ),
          onChanged: (value) {
          setState(() {
          email = value;
          });
          },
          controller: TextEditingController(text: email),
          ),


          const SizedBox(height: 10),
          TextField(
            style: GoogleFonts.openSans(
              color: Colors.black, // change the text color
              fontSize: 16, // change the font size
            ),
            decoration: InputDecoration(
              hintText: 'Phone Number', // update the hint text
              labelText: 'Phone', // update the label text
              border: OutlineInputBorder( // add a border
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              suffixIcon: Icon(Icons.phone,color: Colors.grey.shade400), // add a suffix icon
            ),
            onChanged: (value) {
              setState(() {
                phone = value;
              });
            },
            controller: TextEditingController(text: phone),
          ),


          const SizedBox(height: 20),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white10,
              foregroundColor: Colors.white70,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            onPressed: _saveChanges,
            child: Text('Save Changes',style: GoogleFonts.openSans(
              color: Colors.grey.shade400
            ),),
          ),
        ],
        );
        },
        ),
        ),
      ),
    ),
    );
  }
}
