import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class about_us extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _about_us();
  }
}

class _about_us extends State<about_us> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
        ),
        Opacity(
            opacity: 0.9,
            child: Image.asset('assets/homeheart.png',
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover)),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.transparent,
            title: const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: "ABOUT US",
                      style: TextStyle(
                          color: Color(0xffCC0000),
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
              child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("INTRODUCTION",
                      style: TextStyle(
                          color: Color(0xffCC0000),
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Hookup is an ambitious project of Skyworld Technologies Pvt Ltd. Our company is into multiple businesses like marketing strategy celebrity & artist management and event management. The Skyworld Technologies Pvt Ltd is focused on developing flexible business models that can be implemented online. Being a pioneer of people-centric Internet based business models, Skyworld Technology Pvt Ltd. believes in innovation driven growth.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                    ),
                    // maxLines: 10,
                    // overflow: TextOverflow.ellipsis
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("HOOKUP",
                      style: TextStyle(
                          color: Color(0xffCC0000),
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Hookup is one of the popular matchmaking platforms available online. It was founded with the main objective to help people find their soul mate, a person who can understand them better. Today, one of the main reasons of increasing cases of depression, anxiety and suicide is that people hold up their emotions. They have no one with whom they can share and discuss their issues.\n\n"
                    "This is a small initiative from the team of Hookup India to connect similar minded people. With our platform we want to redefine the meaning of matchmaking. Earlier, matchmaking was limited to matrimony, but on this platform, people can find their life partner, friend, soulmate or buddy.\n\n"
                    "Hookup is trusted and secure social networking platform with real and verified profiles. We give prime importance to the privacy and safety of our users.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                    ),
                    // maxLines: 10,
                    // overflow: TextOverflow.ellipsis
                  ),
                ),
              ),
            ],
          )),
        ),
      ],
    );
  }
}
