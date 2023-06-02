import 'package:dapp/constants/constants.dart';
import 'package:dapp/providers/profile_deatils_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FemaleProfileViewWebView extends StatefulWidget {
  const FemaleProfileViewWebView({super.key});

  @override
  State<FemaleProfileViewWebView> createState() =>
      _FemaleProfileViewWebViewState();
}

class _FemaleProfileViewWebViewState extends State<FemaleProfileViewWebView> {
  // var user_id = "";
  late InAppWebViewController inAppWebViewController;

  get_blogdetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      var user_id = prefs.getString(FirestoreConstants.id.toString());
      print("c $user_id");
    });
  }

  @override
  void initState() {
    get_blogdetails();
    super.initState();
  }

  double progressBar = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile View"),
        ),
        body: Consumer<profile_details_provider>(
          builder: (BuildContext context, state, Widget? child) {
            return Stack(
              children: [
                InAppWebView(
                  initialOptions: InAppWebViewGroupOptions(
                      android:
                          AndroidInAppWebViewOptions(allowFileAccess: true),
                      ios: IOSInAppWebViewOptions(
                        allowsInlineMediaPlayback: true,
                      )),
                  initialUrlRequest: URLRequest(
                    url: Uri.parse(
                        "https://hookupindia.in/webview/profile.php?id=${state.map["data"]["userData"]["user_id"]}"),
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    inAppWebViewController = controller;
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progressbar) {
                    setState(() {
                      progressBar = progressbar / 100;
                    });
                  },
                )
              ],
            );

            //   WebView(
            //   zoomEnabled: false,
            //   javascriptMode: JavascriptMode.unrestricted,
            //   initialUrl:
            //       'https://hookupindia.in/webview/edit-profile.php?id=${state.map["data"]["userData"]["user_id"]}',
            // );
          },
        ));
  }
}
