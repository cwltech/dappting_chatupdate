// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// class Example extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return VideoPlayersList();
//   }
// }
//
// class VideoPlayersList extends StatelessWidget {
//   const VideoPlayersList({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     List<String> paths = [
//       "assets/video1.mp4",
//       "assets/video2.mp4",
//     ];
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(children: [
//           ListView.builder(
//             shrinkWrap: true,
//             physics: const BouncingScrollPhysics(),
//             itemCount: paths.length,
//             itemBuilder: (BuildContext context, int index) {
//               return VideoPlay(
//                 pathh: paths[index],
//               );
//             },
//           ),
//         ]),
//       ),
//     );
//   }
// }
//
// class VideoPlay extends StatefulWidget {
//   String? pathh;
//
//   @override
//   _VideoPlayState createState() => _VideoPlayState();
//
//   VideoPlay({
//     Key? key,
//     this.pathh, // Video from assets folder
//   }) : super(key: key);
// }
//
// class _VideoPlayState extends State<VideoPlay> {
//   ValueNotifier<VideoPlayerValue?> currentPosition = ValueNotifier(null);
//   VideoPlayerController? controller;
//   late Future<void> futureController;
//
//   initVideo() {
//     //controller = VideoPlayerController.asset(widget.pathh!);
//     controller = VideoPlayerController.asset(widget.pathh!)
//       ..initialize().then((value) => {setState(() {})});
//     controller!.setLooping(true);
//     controller!.setVolume(0.0);
//     controller!.play();
//     futureController = controller!.initialize();
//   }
//
//   @override
//   void initState() {
//     initVideo();
//     controller!.addListener(() {
//       if (controller!.value.isInitialized) {
//         currentPosition.value = controller!.value;
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     controller!.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: futureController,
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator.adaptive();
//         } else {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: SizedBox(
//               height: controller!.value.size.height,
//               width: double.infinity,
//               child: AspectRatio(
//                   aspectRatio: controller!.value.aspectRatio,
//                   child: Stack(children: [
//                     Positioned.fill(
//                         child: Container(
//                             foregroundDecoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                   colors: [
//                                     Colors.black.withOpacity(.7),
//                                     Colors.transparent
//                                   ],
//                                   stops: [
//                                     0, .3
//                                   ],
//                                   begin: Alignment.bottomCenter,
//                                   end: Alignment.topCenter),
//                             ),
//                             child: VideoPlayer(controller!))),
//                           /* Positioned.fill(
//                       child: Column(
//                         children: [
//                           Expanded(
//                             flex: 8,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   flex: 3,
//                                   child: GestureDetector(
//                                     onDoubleTap: () async {
//                                       Duration? position =
//                                       await controller!.position;
//                                       setState(() {
//                                         controller!.seekTo(Duration(
//                                             seconds: position!.inSeconds - 10));
//                                       });
//                                     },
//                                     child: const Icon(
//                                       Icons.fast_rewind_rounded,
//                                       color: Colors.black,
//                                       size: 40,
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                     flex: 4,
//                                     child: IconButton(
//                                       icon: Icon(
//                                         controller!.value.isPlaying
//                                             ? Icons.pause
//                                             : Icons.play_arrow,
//                                         color: Colors.black,
//                                         size: 40,
//                                       ),
//                                       onPressed: () {
//                                         setState(() {
//                                           if (controller!.value.isPlaying) {
//                                             controller!.pause();
//                                           } else {
//                                             controller!.play();
//                                           }
//                                         });
//                                       },
//                                     )),
//                                 Expanded(
//                                   flex: 3,
//                                   child: GestureDetector(
//                                     onDoubleTap: () async {
//                                       Duration? position =
//                                       await controller!.position;
//                                       setState(() {
//                                         controller!.seekTo(Duration(
//                                             seconds: position!.inSeconds + 10));
//                                       });
//                                     },
//                                     child: const Icon(
//                                       Icons.fast_forward_rounded,
//                                       color: Colors.black,
//                                       size: 40,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                               flex: 2,
//                               child: Align(
//                                 alignment: Alignment.bottomCenter,
//                                 child: ValueListenableBuilder(
//                                     valueListenable: currentPosition,
//                                     builder: (context,
//                                         VideoPlayerValue? videoPlayerValue, w) {
//                                       return Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 20, vertical: 10),
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               videoPlayerValue!.position
//                                                   .toString()
//                                                   .substring(
//                                                   videoPlayerValue.position
//                                                       .toString()
//                                                       .indexOf(':') +
//                                                       1,
//                                                   videoPlayerValue.position
//                                                       .toString()
//                                                       .indexOf('.')),
//                                               style: const TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 22),
//                                             ),
//                                             const Spacer(),
//                                             Text(
//                                               videoPlayerValue.duration
//                                                   .toString()
//                                                   .substring(
//                                                   videoPlayerValue.duration
//                                                       .toString()
//                                                       .indexOf(':') +
//                                                       1,
//                                                   videoPlayerValue.duration
//                                                       .toString()
//                                                       .indexOf('.')),
//                                               style: const TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 22),
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     }),
//                               ))
//                         ],
//                       ),
//                     ),*/
//                   ])),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
