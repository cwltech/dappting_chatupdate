import 'package:flutter/material.dart';

circle(BuildContext context) async{
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return new AlertDialog(
        backgroundColor: Colors.transparent,
        // title: Text("Loading....",style: TextStyle(
        //   color: Colors.black,
        //   fontFamily: "poppins",
        //   fontSize: 12,
        // ),),
        content:
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: CircularProgressIndicator(
                color: Color(0xff07D3DF),
                backgroundColor: Color(0xffCC0000),
              ),
              height: 50.0,
              width: 50.0,
            ),
          ],
        ),
      );
    },
  );
}