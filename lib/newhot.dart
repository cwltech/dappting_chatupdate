import 'dart:ui';

import 'package:dapp/profile_dashboard.dart';
import 'package:dapp/show_profile.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


List<String> paths = [
  "assets/video1.mp4",
  "assets/video2.mp4",
];

class hot_new extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
      return _newhot();
  }
}

class _newhot extends State<hot_new> {
  VideoPlayerController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/video1.mp4")
      ..initialize().then((value) => {setState(() {})});
    _controller!.setLooping(true);
    _controller!.setVolume(0.0);
    _controller!.play();
  }
  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Stack(
    children: [
      SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _controller!.value.size.width ?? 0,
            height: _controller!.value.size.height ?? 0,
            child: VideoPlayer(_controller!),
          ),
        ),
      ),
      Scaffold(
        //  backgroundColor: Color(0xffCC0000),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder:(context) => profile_dashboard()));
                        },
                        child: Image.asset("assets/card.png",width: 40,
                        height: 40,),
                      )),
                ),

                Align(
                  //alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/2,left: 20,right: 20,bottom: 20),
                    //child: Opacity(
                    child: Container(
                      //alignment: Alignment.bottomCenter,
                      width: MediaQuery.of(context).size.width,
                      height: 140,
                      color:Color(0xffCC0000).withOpacity(0.4),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 20,top: 10,bottom: 3,right: 20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            InkWell(
                                                onTap: (){
                                                  Navigator.of(context).push(MaterialPageRoute(builder:(context) => show_profile()));
                                                },
                                                child: Image.asset("assets/profilepp.png",width: 40,height: 40,)),
                                            Text("  Tiffany 24",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ],
                                        ),
                                            FavoriteButton(
                                              isFavorite: true,
                                              iconDisabledColor: Colors.white,
                                              valueChanged: (_isFavorite) {
                                                print('Is Favorite : $_isFavorite');
                                              },
                                            ),
                                      ],
                                    ),
                                  ),
                                ),

                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20,right: 10,top: 0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Australia",
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.7),
                                            fontSize: 12,
                                          ),),
                                      ),
                                    ),

                                    Opacity(
                                      opacity: 0.9,
                                      child: Container(
                                        // color: Colors.green.withOpacity(5),
                                        width: 50,
                                        height: 17,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.green.withOpacity(0.6),
                                        ),
                                        child: Center(
                                          child: Text("online",style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.teal,
                                            fontSize: 12,
                                          ),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(left: 20.0,top: 0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Video Call @ 30 \u{1FA99}/ min",
                                          style: TextStyle(
                                            color:  Color(0xff07D3DF),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(right: 20.0),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: (){
                                               setState(() {
                                                 // showDialog(
                                                 //   context: context,
                                                 //   builder: (context) => AlertDialog(
                                                 //     titlePadding: EdgeInsets.all(0),
                                                 //     contentPadding:
                                                 //     EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                                 //     title: Text("Heading"),
                                                 //     content: Container(
                                                 //       height: 100,
                                                 //       child: ListView.builder(
                                                 //         scrollDirection: Axis.horizontal,
                                                 //           shrinkWrap: true,
                                                 //           itemCount: 5,
                                                 //           itemBuilder: (ctx, i) {
                                                 //             return Text("Warning: Operand of null-aware operation ");
                                                 //           }),
                                                 //     ),
                                                 //   ),
                                                 // );
                                                 showDialog(
                                                   context: context,
                                                   builder: (context) =>  BackdropFilter(
                                                     filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                                                     child: Center(
                                                       child: Container(
                                                         width: MediaQuery.of(context).size.width,
                                                         height: 270,
                                                         child: Dialog(
                                                           backgroundColor: Colors.transparent,
                                                           child: ListView.builder(
                                                             scrollDirection: Axis.horizontal ,
                                                               shrinkWrap: true,
                                                               itemCount: 5,
                                                               itemBuilder: (ctx, i) {
                                                               return _dialog(context);
                                                               }),
                                                           //child: _dialogContent(context)),
                                                       ),
                                                   ),
                                                     ),
                                                  ),
                                                 );
                                               });
                                              },
                                              child: Icon(Icons.videocam,color: Colors.white,size: 38,))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ),
                  ),
                ),
              ],
            ),
          )
      ),
    ],
   );
  }

  Widget _dialogContent(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width*0.87,
      height: 220,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.87,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color:Color(0xffCC0000).withOpacity(0.3),
              ),
             child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Gujarat, India'),
                );
              },
            ),
             ),
          ),
          Container(
            width: 80,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color:Color(0xffCC0000).withOpacity(0.4),
            ),
            child: Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Color(0xffCC0000),width: 2)
              ),
              child: Center(
                child: Text(
                  "Buy Now",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 13
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _dialog(BuildContext context){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8,top: 10,bottom: 10),
          child: Container(
            width: MediaQuery.of(context).size.width*0.7,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color:Color(0xffCC0000).withOpacity(0.4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: "My Balance: ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                )
                            ),
                            WidgetSpan(child: Image.asset("assets/smallcoin.png",width: 15,height: 15,)),
                            TextSpan(text: "  0",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                )
                            ),
                          ],
                        ),
                      ),

                      Icon(Icons.clear_rounded,size: 15,color: Colors.white,)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_back_ios,size: 15,color: Colors.white,),
                      Center(
                        child: Image.asset("assets/bigcoin.png",width: 40,height: 40,),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded,size: 15,color: Colors.white,),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Center(
                    child: Text("46",style:TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text("₹ 99.00",style:TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),)
                  ),
                ),
              ],
            ),
          ),
        ),

        Container(
          width: 80,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color:Color(0xffCC0000).withOpacity(0.4),
          ),
          child: Container(
            width: 80,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xffCC0000),width: 2)
            ),
            child: Center(
              child: Text(
                "Buy Now",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 13
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}