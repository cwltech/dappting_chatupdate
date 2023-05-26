import 'package:dapp/providers/profile_deatils_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants/firestore_constants.dart';

class MaleProfileSetting extends StatefulWidget {
  const MaleProfileSetting({super.key});

  @override
  State<MaleProfileSetting> createState() => _MaleProfileSettingState();
}

class _MaleProfileSettingState extends State<MaleProfileSetting> {
  var user_id = "";

/* Get User ID From From Local Function */
  getUserDetails(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getString(FirestoreConstants.id)!;
      context.read<profile_details_provider>().profile_details_list(user_id);
    });
    print("User Profile ID 🍆🍆🍆🍆 ==========> $user_id");
  }

  @override
  void initState() {
    getUserDetails(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<profile_details_provider>().profile_details_list(user_id);
    return Scaffold(
        appBar: AppBar(
          title: const Text("View Profile"),
        ),
        body: Consumer<profile_details_provider>(
          builder: (BuildContext context, state, Widget? child) {
            return WebView(
              zoomEnabled: false,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl:
                  'https://hookupindia.in/webview/profile.php?id=${state.map["data"]["userData"]["user_id"]}',
            );
          },
        ));
  }
}
