/// For managing the authentication logic
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restart_app/restart_app.dart';

class AuthService {
  bool isUserLoggedIn() {
    // Update as per logged in logic
    return true;
  }

  Future<void> logoutUser({String? reason}) async {
    // Logout the user
    print('Logged Out: $reason');
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    prefrences.remove("isLoggedIn");
    prefrences.remove("isLoggedInvendor");
    Restart.restartApp();
  }
}
