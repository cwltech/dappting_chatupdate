import 'package:dapp/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../female_user/female_edit_profile.dart';

showbottomsheet(BuildContext context) {
  context.read<apperance_provider>().apperance_list();
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(20.0),
          topRight: const Radius.circular(20.0)),
    ),
    builder: (BuildContext context) {
      // we set up a container inside which
      // we create center column and display text

      // Returning SizedBox instead of a Container
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return Form(
            // key: _teamcreatedKey,
            child: Container(
              height: 500,
              child: Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<apperance_provider>().apperance_list();
                      },
                      child: Center(
                        child: Consumer<apperance_provider>(
                          builder: (context, value, child) {
                            return value.map.length == 0 && !value.error
                                ? CircularProgressIndicator()
                                : value.error
                                    ? Text("Opps SOmething went wrong")
                                    : Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        child: Container(
                                          child: value.map.length > 0
                                              ? ListView.builder(
                                                  itemCount:
                                                      value.map["data"].length,
                                                  shrinkWrap: true,
                                                  physics: ScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemBuilder:
                                                      (context, index) {
                                                    // return Text("hii");
                                                    return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          appreance = value
                                                                  .map["data"]
                                                              [index]["name"];
                                                          //   values = appreance;
                                                        });
                                                        print(
                                                            "apperance $appreance");
                                                        Navigator.pop(context);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              value.map["data"]
                                                                      [index]
                                                                  ["name"],
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "poppins",
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Divider(),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Container(),
                                        ),
                                      );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
