// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Weather App',
//       home: WeatherScreen(),
//     );
//   }
// }
//
// class WeatherScreen extends StatefulWidget {
//   @override
//   _WeatherScreenState createState() => _WeatherScreenState();
// }
//
// class _WeatherScreenState extends State<WeatherScreen> {
//   var temperature;
//   var humidity;
//   var windSpeed;
//   var description;
//
//   void getWeatherData() async {
//     var url = "API_KEY_HERE";
//     var response = await http.get(url);
//     var decodedJson = jsonDecode(response.body);
//
//     setState(() {
//       temperature = decodedJson['main']['temp'];
//       humidity = decodedJson['main']['humidity'];
//       windSpeed = decodedJson['wind']['speed'];
//       description = decodedJson['weather'][0]['description'];
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getWeatherData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Weather App'),
//       ),
//       body: Column(
//         children: [
//           Text('Temperature: $temperature°F'),
//           Text('Humidity: $humidity%'),
//           Text('Wind Speed: $windSpeed mph'),
//           Text('Description: $description'),
//           ElevatedButton(
//             child: Text('Check Plant Care'),
//             onPressed: () {
//               // logic for plant care based on weather data
//               if (temperature >= 70 && humidity >= 50) {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       content: Text(
//                           'It is warm and humid outside. Make sure to water your plants frequently and mist them to increase humidity.'),
//                     );
//                   },
//                 );
//               } else if (temperature >= 70 && windSpeed >= 10) {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       content: Text(
//                           'It is warm but windy outside. Make sure to stake your taller plants and protect your delicate plants from wind damage.'),
//                     );
//                   },
//                 );
//               } else {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       content: Text(
//                           'The weather is mild. Keep an eye on your plants and water them as needed.'),
//                     );
//                   },
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
