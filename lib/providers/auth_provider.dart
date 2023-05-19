import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/firestore_constants.dart';
import '../models/user_chat.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateException,
  authenticateCanceled,
}

class AuthProvider extends ChangeNotifier {
  final FirebaseFirestore firebaseFirestore;
  final SharedPreferences prefs;

  Status _status = Status.uninitialized;

  Status get status => _status;

  AuthProvider({
    required this.prefs,
    required this.firebaseFirestore,
  });

  String? getUserFirebaseId() {
    return prefs.getString(FirestoreConstants.id);
  }

  Future<bool> handleSignIn(
      String user_id, String displayName, String photoURL, String type) async {
    //_status = Status.authenticating;
    notifyListeners();
    if (type == "user") {
      final QuerySnapshot result = await firebaseFirestore
          .collection(FirestoreConstants.pathUserCollection)
          .where(FirestoreConstants.id, isEqualTo: user_id)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        // Writing data to server because here is a new user
        firebaseFirestore
            .collection(FirestoreConstants.pathUserCollection)
            .doc(user_id)
            .set({
          FirestoreConstants.nickname: displayName,
          FirestoreConstants.photoUrl: photoURL,
          FirestoreConstants.id: user_id,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          FirestoreConstants.chattingWith: null
        });
        // Write data to local storage
        String? currentUser = user_id;
        await prefs.setString(FirestoreConstants.id, currentUser);
        await prefs.setString(FirestoreConstants.nickname, displayName ?? "");
        await prefs.setString(FirestoreConstants.photoUrl, photoURL ?? "");
        print("FirestoreConstants $displayName $currentUser");
      } else {
        // Already sign up, just get data from firestore
        DocumentSnapshot documentSnapshot = documents[0];
        UserChat userChat = UserChat.fromDocument(documentSnapshot);
        // Write data to local
        await prefs.setString(FirestoreConstants.id, userChat.id);
        await prefs.setString(FirestoreConstants.nickname, userChat.nickname);
        await prefs.setString(FirestoreConstants.photoUrl, userChat.photoUrl);
        await prefs.setString(FirestoreConstants.aboutMe, userChat.aboutMe);
      }
      _status = Status.authenticated;
      notifyListeners();
      return true;
    } else {
      print("type1 $type");
      final QuerySnapshot result = await firebaseFirestore
          .collection(FirestoreConstants.pathUservendorCollection)
          .where(FirestoreConstants.id, isEqualTo: user_id)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        // Writing data to server because here is a new user
        firebaseFirestore
            .collection(FirestoreConstants.pathUservendorCollection)
            .doc(user_id)
            .set({
          FirestoreConstants.nickname: displayName,
          FirestoreConstants.photoUrl: photoURL,
          FirestoreConstants.id: user_id,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          FirestoreConstants.chattingWith: null
        });
        // Write data to local storage
        String? currentUser = user_id;
        await prefs.setString(FirestoreConstants.id, currentUser);
        await prefs.setString(FirestoreConstants.nickname, displayName ?? "");
        await prefs.setString(FirestoreConstants.photoUrl, photoURL ?? "");
        print("FirestoreConstants $displayName $currentUser");
      } else {
        // Already sign up, just get data from firestore
        DocumentSnapshot documentSnapshot = documents[0];
        UserChat userChat = UserChat.fromDocument(documentSnapshot);
        // Write data to local
        await prefs.setString(FirestoreConstants.id, userChat.id);
        await prefs.setString(FirestoreConstants.nickname, userChat.nickname);
        await prefs.setString(FirestoreConstants.photoUrl, userChat.photoUrl);
        await prefs.setString(FirestoreConstants.aboutMe, userChat.aboutMe);
      }
      _status = Status.authenticated;
      notifyListeners();
      return true;
    }
  }
}
