import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String email;
  final String phone;
  final String imageUrl;

  User({required this.name, required this.email, required this.phone, required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'imageUrl': imageUrl,
    };
  }
}

class ProfileDetailPage extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;

  const ProfileDetailPage({Key? key, required this.name, required this.email, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 60.0),
          child: Text(name),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 200.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100.0,
                backgroundImage: NetworkImage(imageUrl,scale: 1.0),
              ),
              SizedBox(height: 16.0),
              Text(
                  name,
                  style: GoogleFonts.openSans(
                    fontSize: 24,
                  )
              ),
              const SizedBox(height: 10.0),
              Text(
                  email,
                  style: GoogleFonts.openSans(
                    fontSize: 24,
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}





class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  Uri? _imageUrl;
  File? _image;
  bool _isLoading = false;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserProfile() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final user = FirebaseAuth.instance.currentUser;
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      final data = snapshot.data();
      nameController.text = data?['name'];
      emailController.text = data?['email'];
      phoneController.text = data?['phone'];
      _imageUrl = Uri.parse(data?['image'] ?? '');
      _userId = user.uid;
    } catch (error) {
      print('Error fetching user profile: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );

    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildImage(),
              SizedBox(height: 16),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (_image != null) {
      return GestureDetector(
        onTap: _getImage,
        child: CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey[200],
          backgroundImage: FileImage(_image!),
        ),
      );
    } else if (_imageUrl != null) {
      return GestureDetector(
        onTap: _getImage,
        child: CircleAvatar(
          radius: 100,
          backgroundColor: Colors.grey[200],
          backgroundImage: NetworkImage(_imageUrl.toString(), scale: 1),
        ),
      );
    } else {
      return GestureDetector(
        onTap: _getImage,
        child: CircleAvatar(
          radius: 100,
          backgroundColor: Colors.grey[200],
          child: Icon(Icons.camera_alt, size: 50),
        ),
      );
    }
  }


  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final user = FirebaseAuth.instance.currentUser!;
        String imageUrl = _imageUrl?.toString() ?? '';

        // If the user has selected a new image, upload it to Firebase Storage and get its URL
        if (_image != null) {
          final task = await FirebaseStorage.instance
              .ref('users/${user.uid}/profile_image.jpg')
              .putFile(_image!);

          imageUrl = await task.ref.getDownloadURL();
        }

        // Create a new User object and save it to Firestore
        final newUser = User(
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          imageUrl: imageUrl,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set(newUser.toMap());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
      } catch (error) {
        print('Error saving user profile: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving user profile')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}