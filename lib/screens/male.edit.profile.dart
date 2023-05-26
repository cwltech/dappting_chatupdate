import 'package:dapp/constants/app.keys.dart';
import 'package:dapp/providers/profile_deatils_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MaleEditProfileSetting extends StatefulWidget {
  const MaleEditProfileSetting({super.key});

  @override
  State<MaleEditProfileSetting> createState() => _MaleEditProfileSettingState();
}

class _MaleEditProfileSettingState extends State<MaleEditProfileSetting> {
  // var user_id = "";

  get_blogdetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      var user_id = prefs.getString(AppKeys.loginUserID.toString());
      print("c $user_id");
    });
  }

  @override
  void initState() {
    get_blogdetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
        ),
        body: Consumer<profile_details_provider>(
          builder: (BuildContext context, state, Widget? child) {
            return WebView(
              zoomEnabled: false,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl:
                  'https://hookupindia.in/webview/edit-profile.php?id=${state.map["data"]["userData"]["user_id"]}',
            );
          },
        ));
  }
}
