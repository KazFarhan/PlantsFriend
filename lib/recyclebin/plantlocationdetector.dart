// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
//
//
// class MyHomePage extends StatefulWidget {
//
//
//   late final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   List<Plant> plants = [];
//
//   void _addPlant() {
//     setState(() {
//       plants.add(Plant(name: 'Plant ${plants.length + 1}', bestLocation: '', image: ));
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: ListView.builder(
//         itemCount: plants.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             leading: Image.file(plants[index].image),
//             title: Text(plants[index].name),
//             subtitle: Text(plants[index].bestLocation),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _addPlant,
//         tooltip: 'Add Plant',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
//
// class Plant {
//   String name;
//   String bestLocation;
//   File image;
//
//   Plant({required this.name, required this.bestLocation, required this.image});
// }
//
// class PlantPage extends StatefulWidget {
//   PlantPage({required Key key, required this.plant}) : super(key: key);
//
//   final Plant plant;
//
//   @override
//   _PlantPageState createState() => _PlantPageState();
// }
//
// class _PlantPageState extends State<PlantPage> {
//   Future getImage() async {
//     var image = await ImagePicker.pickImage(source: ImageSource.camera);
//     setState(() {
//       widget.plant.image = image as File;
//     });
//   }
//
//   void _checkLocation() {
//     setState(() {
//       // Simulate location detection
//       List<String> locations = ['North Window', 'South Window', 'East Window', 'West Window'];
//       widget.plant.bestLocation = locations[new DateTime.now().millisecondsSinceEpoch % 4];
//     });
//
//     Navigator.pop(context, widget.plant);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${widget.plant.name} Information'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Container(
//             margin: EdgeInsets.all(16),
//             child: TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Name',
//               ),
//               onChanged: (String value) {
//                 setState(() {
//                   widget.plant.name = value;
//                 });
//               },
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.all(16),
//             child: widget.plant.image == null
//                 ? Text('No image selected.')
//                 : Image.file(widget.plant.image),
//           ),
//           Container(
//             margin: EdgeInsets.all(16),
//             child: ElevatedButton(
//               child: Text('Select Image'),
//               onPressed: getImage,
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.all(16),
//             child: ElevatedButton(
//               child: Text('Check Best Location'),
//               onPressed: _checkLocation,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
