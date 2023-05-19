import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../constants/app_constants.dart';
import '../constants/color_constants.dart';

class FullPhotoPage extends StatelessWidget {
  final String url;
  FullPhotoPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffCC0000),
        title: Text(
          AppConstants.fullPhotoTitle,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(url),
        ),
      ),
    );
  }
}
