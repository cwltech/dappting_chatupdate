import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';

class female_balance extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _female_balance();
  }
}

class _female_balance extends State<female_balance> {
  @override
  Widget build(BuildContext context) {
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
                color: Colors.white,
              ),
              Opacity(
                  opacity: 0.9,
                  child: Image.asset('assets/hearts_1.png',
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover)),
            ]),
          ],
        )),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              leading: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              backgroundColor: Colors.transparent,
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: "My Balance",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        )),
                  ],
                ),
              ),
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFFEB974),
                          const Color(0xFF944C1E),
                          const Color(0xFF772F1A),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      //color:Color(0xff07D3DF).withOpacity(0.3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "My Balance :",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 30,
                                height: 30,
                                child: Image.asset("assets/bigcoin.png")),
                            Text("  24",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height,
                    child: ContainedTabBarView(
                      tabBarProperties: TabBarProperties(
                        //height: 32.0,
                        labelColor: Colors.red,
                        indicatorColor: Color(0xff07D3DF),
                        indicatorWeight: 1.0,
                        unselectedLabelColor: Colors.grey[400],
                      ),
                      tabs: [
                        Text(
                          'Deposit',
                          style: TextStyle(
                            //color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Withdrawal',
                          style: TextStyle(
                            //color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      views: [
                        Center(child: Text("No Data Found")),
                        Center(child: Text("No Data Found")),
                        //Container(color: Colors.green),
                        //Container(color: Colors.green)
                      ],
                      onChange: (index) => print(index),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
