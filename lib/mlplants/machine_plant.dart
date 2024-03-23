import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_new_plants/page/camera_cont.dart';
import 'package:tflite_v2/tflite_v2.dart';
import '../widgets/bottom_nav.dart';

class MachinePlant extends StatefulWidget {
  const MachinePlant({Key? key}) : super(key: key);

  @override
  State<MachinePlant> createState() => _MachinePlantState();
}

class _MachinePlantState extends State<MachinePlant> {
  bool _loading = true;
  late File _imageFile;
  final imagepicker = ImagePicker();
  List predictions = [];

  @override
  void initState(){
    super.initState();
    loadmodel();
  }


  loadmodel()async{
    await Tflite.loadModel(model:'assets/model1.tflite', labels: 'assets/labels1.txt');
  }

  detect_image(File image)async{
    var prediction = await Tflite.runModelOnImage(path: image.path,
        numResults: 43,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _loading = false;
      predictions = prediction!;
    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  _loadimage_gallary() async{
    var image = await imagepicker.pickImage(source: ImageSource.gallery);
    if (image==null){
      return null;
    }
    else {

      _imageFile = File(image.path);
    }
    detect_image(_imageFile);
    }
  _loadimage_camera() async{
    var image = await imagepicker.pickImage(source: ImageSource.camera);
    if (image==null){
      return null;
    }
    else {

      _imageFile = File(image.path);
    }
    detect_image(_imageFile);
  }





  @override
  Widget build(BuildContext context) {
    var h= MediaQuery.of(context).size.height;
    var w= MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white60,
        backgroundColor: Colors.white70,
        title:  Padding(
          padding:  EdgeInsets.only(left: 70.0),
          child:  Text('FIND ME', style: GoogleFonts.robotoSerif(
            color: Colors.grey.shade400,
          ),),
        ),
        leading:IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>BottomNavBar()));
          },
          icon:  Icon(Icons.arrow_back,color: Colors.grey.shade400,),
        ),
      ),
    body: SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white60,Colors.white70]
          )
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height:20),
          Container(height: 200,width: 200,
            padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),),
          child: Image.asset('assets/icons/plant1.jpg',fit: BoxFit.fill,),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Container(child:  Text(
              'KNOW ME',
              style: GoogleFonts.openSans(
                fontSize: 32,
                color: Colors.grey.shade400,
              )
            ),
            ),
          ),
        const SizedBox(height: 10),
        Container(width: 350,
          height: 70,
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:(Context)=>BooksList()));
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(),
                ),
              backgroundColor: MaterialStateProperty.all(Colors.white),
            ),

            child: Text('Camera',style: GoogleFonts.openSans(
              color: Colors.grey.shade600,
              fontSize: 22,
            ),
            ),
          ),
        ),
          Container(width: 200,
            height: 70,
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){
                _loadimage_gallary();
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child:  Text('Gallery',style: GoogleFonts.openSans(
                color: Colors.grey.shade600,
                fontSize: 22,
              ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          _loading==false
              ?SingleChildScrollView(
                child: Container(

                    child: Column(
                      children: [
                         Container(
          child: Image.file(_imageFile,fit:BoxFit.fill),
          ),
                        Text(predictions[0]['label'].toString().substring(2)),
                      ],
                    ),
                ),
              ): Container()
        ],
        ),
      ),
    ),
    );
  }
}
