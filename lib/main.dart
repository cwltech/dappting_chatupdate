import 'dart:async';
import 'dart:math';
import 'dart:math' as Math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dapp/female_user/female_home_activity.dart';
import 'package:dapp/home_activity.dart';
import 'package:dapp/login.dart';
import 'package:dapp/providers/auth_provider.dart';
import 'package:dapp/providers/block_listprovider.dart';
import 'package:dapp/providers/chat_provider.dart';
import 'package:dapp/providers/coin_deduction_provider.dart';
import 'package:dapp/providers/country_provider.dart';
import 'package:dapp/providers/female_details_provider.dart';
import 'package:dapp/providers/keyboard_provider.dart';
import 'package:dapp/providers/package_provider.dart';
import 'package:dapp/providers/profile_deatils_provider.dart';
import 'package:dapp/providers/profile_provider.dart';
import 'package:dapp/providers/regular_package_provider.dart';
import 'package:dapp/providers/setting_provider.dart';
import 'package:dapp/providers/vip_package_provider.dart';
import 'package:dapp/user_activity_detector.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51M057ASG0qpJpZRXqDdGnQRaMWGTTqdzLZlshxpanJ8hOYfzvbJkeYZrkZhdvmHg2W4GruMeMAJvXgMcyTApwuCg00iV5RA2eB";
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<country_provider>(
            create: (context) => country_provider()),
        ChangeNotifierProvider<apperance_provider>(
            create: (context) => apperance_provider()),
        ChangeNotifierProvider<ethencity_provider>(
            create: (context) => ethencity_provider()),
        ChangeNotifierProvider<childrenhave_provider>(
            create: (context) => childrenhave_provider()),
        ChangeNotifierProvider<children_want_provider>(
            create: (context) => children_want_provider()),
        ChangeNotifierProvider<body_type_provider>(
            create: (context) => body_type_provider()),
        ChangeNotifierProvider<drink_provider>(
            create: (context) => drink_provider()),
        ChangeNotifierProvider<education_provider>(
            create: (context) => education_provider()),
        ChangeNotifierProvider<english_provider>(
            create: (context) => english_provider()),
        ChangeNotifierProvider<eye_color_provider>(
            create: (context) => eye_color_provider()),
        ChangeNotifierProvider<hair_color_provider>(
            create: (context) => hair_color_provider()),
        ChangeNotifierProvider<height_provider>(
            create: (context) => height_provider()),
        ChangeNotifierProvider<occupation_provider>(
            create: (context) => occupation_provider()),
        ChangeNotifierProvider<maritial_provider>(
            create: (context) => maritial_provider()),
        ChangeNotifierProvider<religion_provider>(
            create: (context) => religion_provider()),
        ChangeNotifierProvider<smoke_provider>(
            create: (context) => smoke_provider()),
        ChangeNotifierProvider<ChatListMessageProvider>(
            create: (context) => ChatListMessageProvider()),
        ChangeNotifierProvider<starsign_provider>(
            create: (context) => starsign_provider()),
        ChangeNotifierProvider<weight_provider>(
            create: (context) => weight_provider()),
        ChangeNotifierProvider<hostlist_provider>(
            create: (context) => hostlist_provider()),
        ChangeNotifierProvider<package_provider>(
            create: (context) => package_provider()),
        ChangeNotifierProvider<vip_package_provider>(
            create: (context) => vip_package_provider()),
        ChangeNotifierProvider<regular_package_provider>(
            create: (context) => regular_package_provider()),
        ChangeNotifierProvider<virtual_gift_provider>(
            create: (context) => virtual_gift_provider()),
        ChangeNotifierProvider<ProfileDetailsProvider>(
            create: (context) => ProfileDetailsProvider()),
        ChangeNotifierProvider<CoinDeductionProvider>(
            create: (context) => CoinDeductionProvider()),
        ChangeNotifierProvider<block_list_provider>(
            create: (context) => block_list_provider()),
        ChangeNotifierProvider<female_details_provider>(
            create: (context) => female_details_provider()),
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(
            prefs: prefs,
            firebaseFirestore: firebaseFirestore,
          ),
        ),
        Provider<SettingProvider>(
          create: (_) => SettingProvider(
            prefs: prefs,
            firebaseFirestore: firebaseFirestore,
            firebaseStorage: firebaseStorage,
          ),
        ),
      ],
      child: UserActivityDetector(
        child: WillPopScope(
          onWillPop: () async {
            MoveToBackground.moveTaskToBack();
            return false;
          },
          child: MaterialApp(
            title: 'Splash Screen',
            home: Splash2(),
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
            debugShowCheckedModeBanner: false,
            //initialRoute: '/home_page',
          ),
        ),
      ),
    );
  }
}

class Splash2 extends StatefulWidget {
  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> with SingleTickerProviderStateMixin {
  double _opacity = 0.9;
  AnimationController? controller;
  Animation<double>? animation;
  var isLoggedIn;
  final random = Random();
  final avatarSize = 60.0;
  var isLoggedInvendor;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      // just delay for showing this slash page clearer because it too fast
      getuser(context);

      controller = AnimationController(
          duration: const Duration(seconds: 60), vsync: this)
        ..repeat();
      animation = Tween<double>(begin: 0, end: 2 * Math.pi).animate(controller!)
        ..addListener(() {
          setState(() {});
        });
    });
  }

// You'll probably want to wrap this function in a debounce

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  getuser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = (prefs.getBool('isLoggedIn') == null)
        ? false
        : prefs.getBool('isLoggedIn');
    isLoggedInvendor = (prefs.getBool('isLoggedInvendor') == null)
        ? false
        : prefs.getBool('isLoggedInvendor');
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
        child: Stack(
      children: [
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(children: [
              Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height,
                color: Color(0xffCC0000),
              ),
              Opacity(
                  opacity: _opacity,
                  child: Image.asset('assets/hearts_1.png',
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover)),
            ]),
          ],
        )),
        Scaffold(
            //  backgroundColor: Color(0xffCC0000),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Center(
                      child: Image.asset(
                        "assets/logo.png",
                      ),
                    ),
                  ),
                  /* Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        color: Colors.transparent,
                        child: LayoutBuilder(builder: (context, constraints) {
                          return Stack(children: [
                            new Positioned(
                                left: avatarSize +
                                    (constraints.biggest.width -
                                            2 * avatarSize) /
                                        100.0 *
                                        random.nextInt(100),
                                top: avatarSize +
                                    (constraints.biggest.height -
                                            2 * avatarSize) /
                                        100.0 *
                                        random.nextInt(100),
                                child: new CircleAvatar(
                                  radius: avatarSize / 2,
                                  child: new Text('1'),
                                  backgroundColor: Colors.yellow,
                                )),
                            new Positioned(
                                left: avatarSize +
                                    (constraints.biggest.width -
                                            2 * avatarSize) /
                                        100.0 *
                                        random.nextInt(100),
                                top: avatarSize +
                                    (constraints.biggest.height -
                                            2 * avatarSize) /
                                        100.0 *
                                        random.nextInt(100),
                                child: new CircleAvatar(
                                  radius: avatarSize / 2,
                                  child: new Text('2'),
                                  backgroundColor: Colors.red,
                                )),
                            new Positioned(
                                left: avatarSize +
                                    (constraints.biggest.width -
                                            2 * avatarSize) /
                                        100.0 *
                                        random.nextInt(100),
                                top: avatarSize +
                                    (constraints.biggest.height -
                                            2 * avatarSize) /
                                        100.0 *
                                        random.nextInt(100),
                                child: new CircleAvatar(
                                  radius: avatarSize / 2,
                                  child: new Text('3'),
                                  backgroundColor: Colors.blue,
                                )),
                          ]);
                        }),
                      )),*/

                  /*Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.8,
                    child: CustomMultiChildLayout(
                        delegate: CircularLayoutDelegate(
                          rotation: animation?.value,
                          itemCount: 3,
                          radius: 120,
                        ),
                        children: List.generate(
                            3,
                            (i) => LayoutId(
                                id: 'BUTTON$i',
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://i.picsum.photos/id/853/200/200.jpg?hmac=f4LF-tVBBnJb9PQAVEO8GCTGWgLUnxQLw44rUofE6mQ"),
                                  radius: 60,
                                )))),
                  ),*/
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.8,
                      child: Image.asset("assets/image.png")),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        if (isLoggedIn) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => home_home()));
                        } else if (isLoggedInvendor) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => female_home()));
                        } else {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => login()));
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                              width: 70,
                              height: 70,
                              child: Image.asset("assets/homecircle.png")),
                          // Front image
                          Image.asset("assets/rectangle.png"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    ));
  }
}

const double _radiansPerDegree = Math.pi / 180;
final double _startAngle = -90.0 * _radiansPerDegree;

class CircularLayoutDelegate extends MultiChildLayoutDelegate {
  static const String actionButton = 'BUTTON';

  final int itemCount;
  final double radius;
  final double? rotation;
  Offset? center;

  CircularLayoutDelegate({
    required this.itemCount,
    required this.radius,
    this.rotation,
  });

  double _calculateItemAngle(int index) {
    double _itemSpacing = 360.0 / itemCount;
    return (rotation ?? 0) +
        _startAngle +
        index * _itemSpacing * _radiansPerDegree;
  }

  @override
  void performLayout(Size size) {
    center = new Offset(size.width / 2, size.height / 2);
    for (int i = 0; i < itemCount; i++) {
      final String actionButtonId = '$actionButton$i';

      if (hasChild(actionButtonId)) {
        final Size buttonSize =
            layoutChild(actionButtonId, new BoxConstraints.loose(size));

        final double itemAngle = _calculateItemAngle(i);

        positionChild(
          actionButtonId,
          Offset(
            (center!.dx - buttonSize.width / 2) +
                (radius) * Math.cos(itemAngle),
            (center!.dy - buttonSize.height / 2) +
                (radius) * Math.sin(itemAngle) +
                10 * Math.sin(i + (rotation ?? 0) * 3),
          ),
        );
      }
    }
  }

  @override
  bool shouldRelayout(CircularLayoutDelegate oldDelegate) =>
      itemCount != oldDelegate.itemCount ||
      radius != oldDelegate.radius ||
      rotation != oldDelegate.rotation;
}
