// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class MyAudioPlayer extends StatefulWidget {
//   @override
//   _MyAudioPlayerState createState() => _MyAudioPlayerState();
// }
//
// class _MyAudioPlayerState extends State<MyAudioPlayer> {
//   AudioPlayer audioPlayer = AudioPlayer();
//   String audioUrl =
//       'https://developer.spotify.com/documentation/web-api';
//
//   Future<void> playAudio() async {
//     int result = await audioPlayer.play(audioUrl);
//     if (result == 1) {
//       // success
//       print('Audio playing...');
//     } else {
//       // failure
//       print('Error playing audio');
//     }
//
//   }
//
//   @override
//   void dispose() {
//     audioPlayer.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Audio Player'),
//       ),
//       body: Center(
//         child: TextButton(
//           child: Text('Play Audio'),
//           onPressed: () {
//             playAudio();
//           },
//         ),
//       ),
//     );
//   }
// }
