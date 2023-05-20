import 'package:carousel_slider/carousel_slider.dart';
import 'package:dapp/payment_stripe.dart';
import 'package:dapp/providers/package_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> imgList = [
  'assets/vip1.png',
  'assets/vip2.png',
  'assets/vip3.png'
];

List planimg = ["assets/vipheart.png", "assets/star.png", "assets/star.png"];

List plandesp = ["Standard", "Popular", "Special Offer"];

class vipaccess extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _vip();
  }
}

class _vip extends State<vipaccess> {
  var user_id;
  int? select;

  List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(item, fit: BoxFit.fill, width: 140.0),
                    ],
                  )),
            ),
          ))
      .toList();

  @override
  void initState() {
    super.initState();
    get_blogdetails(context);
  }

  get_blogdetails(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getString("user_id");
    });
    print("blodid $user_id");
  }

  double _opacity = 0.9;

  @override
  Widget build(BuildContext context) {
    context.read<package_provider>().package_list(user_id);
    int _current = 0;
    final CarouselController _controller = CarouselController();
    return Stack(
      children: [
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(children: [
              Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                  color: Colors.white,
                ),
              ),
              Opacity(
                  opacity: 1,
                  child: Image.asset('assets/hearts_1.png',
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height * 0.5,
                      fit: BoxFit.cover)),
            ]),
          ],
        )),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
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
              // actions: <Widget>[
              //   IconButton(
              //     icon: ImageIcon(
              //       AssetImage("assets/search.png"),
              //       color: Colors.black,
              //       size: 28,
              //     ),
              //     onPressed: () {},
              //   ),
              // ],
              elevation: 0.0,
            ),
            body: SingleChildScrollView(child:
                Consumer<package_provider>(builder: (context, value, child) {
              return value.map["data"]["HostList"] != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 140,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          )),
                          child: CarouselSlider(
                            items: imageSliders,
                            carouselController: _controller,
                            options: CarouselOptions(
                                autoPlay: true,
                                // enlargeCenterPage: true,
                                //aspectRatio: 4.0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                }),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: imgList.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 8.0,
                                height: 8.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : const Color(0xffCC0000))
                                        .withOpacity(
                                            _current == entry.key ? 0.8 : 0.4)),
                              ),
                            );
                          }).toList(),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 30.0, left: 20, bottom: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "VIP Access",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 0.0, left: 20, bottom: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Upgrade to VIP and quickly find new people in your area and chat without having to match first",
                              style: TextStyle(
                                color: Color(0xff686868),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: value.map["data"]["HostList"].length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      select = index;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 15),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 65,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: select == index
                                                  ? const Color(0xffCC0000)
                                                  : const Color(0xff07D3DF),
                                              width: 1.5)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  plandesp[index],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 17),
                                                ),
                                                Row(
                                                  children: [
                                                    // Text(
                                                    //   "Buy to get ",
                                                    //   style: TextStyle(
                                                    //       color:
                                                    //           Color(0xff686868),
                                                    //       fontSize: 15),
                                                    // ),
                                                    Text(
                                                      value.map["data"]
                                                              ["HostList"]
                                                          [index]["PlanName"],
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xff686868),
                                                          fontSize: 15),
                                                    ),
                                                    // Container(
                                                    //   width: 20,
                                                    //   height: 20,
                                                    //   child: Image.asset(
                                                    //     "assets/bigcoin.png",
                                                    //     fit: BoxFit.fill,
                                                    //   ),
                                                    // ),
                                                    // Text(
                                                    //   " Coins",
                                                    //   style: TextStyle(
                                                    //       color:
                                                    //           Color(0xff686868),
                                                    //       fontSize: 15),
                                                    // ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 2),
                                                child: Text(
                                                  "₹ " +
                                                      value.map["data"]
                                                              ["HostList"]
                                                          [index]["PlanPrice"],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 17),
                                                ),
                                              ),
                                              Container(
                                                width: 2,
                                                height: 65,
                                                color: select == index
                                                    ? const Color(0xffCC0000)
                                                    : const Color(0xff07D3DF),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  planimg[0],
                                                  width: 35,
                                                  height: 35,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 40),
                          child: Container(
                            width: MediaQuery.of(context).size.width * .6,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: const Color(0xffCC0000),
                            ),
                            child: TextButton(
                              onPressed: () {
                                payment_stripe.makepayment(
                                    context,
                                    value.map["data"]["HostList"][select]
                                        ["PlanPrice"],
                                    user_id,
                                    "0",
                                    value.map["data"]["HostList"][select]
                                            ["PlanId"]
                                        .toString());
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Buy",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Color(0xffCC0000),
                                ),
                              ),
                              // color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const Center(child: CircularProgressIndicator());
            })),
          ),
        ),
      ],
    );
  }
}
