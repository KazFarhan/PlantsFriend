import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_new_plants/main.dart';
import 'package:tflite_v2/tflite_v2.dart';
class BooksList extends StatefulWidget {
  const BooksList({Key? key}) :super(key: key);

  @override
  State<BooksList> createState() => _BooksListState();
}

class _BooksListState extends State<BooksList> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output ='';

  @override
  void initState(){
    super.initState();
    loadCamera();
    loadmodel();
  }

  loadCamera(){
    cameraController =CameraController(camera![0], ResolutionPreset.medium);
    cameraController!.initialize().then((value){
      if(!mounted){
        return;
      }
      else{
        setState(() {
          cameraController!.startImageStream((imageStream){
            cameraImage = imageStream;
            runModel();
          });
        });
      }
    });
  }
  runModel()async{
    if(cameraImage!=null){
      var predictions = await Tflite.runModelOnFrame(bytesList: cameraImage!.planes.map((plane){
        return plane.bytes;
      }).toList(),
        imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 44,
        threshold: 0.1,
        asynch: true);
      predictions!.forEach((element) {
          setState(() {
            output = element['label'];
          });
        });

    }
  }
  loadmodel()async{
    await Tflite.loadModel(labels: "assets/labels1.txt", model:"assets/model1.tflite",);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey,
        title: const Padding(
          padding: EdgeInsets.all(110),
          child: Text('Plant Detection', style: TextStyle(fontSize: 18,),),),
        elevation: 0,
      ),
      body:Column(
        children: [
          Padding(padding:EdgeInsets.all(20),
          child: Container(
            height: MediaQuery.of(context).size.height*0.7,
            width: MediaQuery.of(context).size.width,
            child: !cameraController!.value.isInitialized?
                Container():
                AspectRatio(aspectRatio:cameraController!.value.aspectRatio,
                child: CameraPreview(cameraController!),),
          ),
          ),
          Text(output, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),)
        ],
      ),
    );
  }
}