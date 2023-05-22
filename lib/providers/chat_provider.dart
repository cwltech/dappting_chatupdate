import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatListMessageProvider with ChangeNotifier {
  Map<String, dynamic> map = {};
  bool error = false;
  String errormessage = '';

  Map<String, dynamic> get _map => map;

  bool get _error => error;

  String get _errormessage => errormessage;

  Future<void> messagelist(String userID, String recieverID) async {
    // userID = '65';
    // recieverID = '2';
    print('userId= $userID and rId = $recieverID');
    String postUrl = "https://hookupindia.in/hookup/ApiController/chatList";
    var request = http.MultipartRequest("POST", Uri.parse(postUrl));
    var headers = {
      'Cookie': 'ci_session=594482e91c54716d61a4e5c727fbb4147184e3a7'
    };
    request.headers.addAll(headers);
    request.fields["sender_id"] = userID;
    request.fields["reciever_id"] = recieverID;

    // http.StreamedResponse response = await request.send();
    //
    // if (response.statusCode == 200) {
    //   print('helloo 777');
    //   debugPrint(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }

    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        if (response.statusCode == 200) {
          try {
            map = json.decode(onValue.body);
            print("Chat List Print ================> $map");
            error = false;
          } catch (e) {
            error = true;
            print("Errror Shittttttt! Resposne ================>$e");
            errormessage = e.toString();
            map = {};
          }
        } else {
          error = true;
          errormessage = "Please Check Your Internet Connection";
          map = {};
        }

        print('Map data = $map');
        notifyListeners();
      });
    });
  }

  void initializedvalue() {
    error = false;
    errormessage = "Something Worng";
    map = {};
    notifyListeners();
  }
}

class ChatProvider {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  ChatProvider(
      {required this.firebaseFirestore,
      required this.prefs,
      required this.firebaseStorage});

  String? getPref(String key) {
    return prefs.getString(key);
  }

  // Future<void> updateDataFirestore(String collectionPath, String docPath,
  //     Map<String, dynamic> dataNeedUpdate) {
  //   return firebaseFirestore
  //       .collection(collectionPath)
  //       .doc(docPath)
  //       .update(dataNeedUpdate);
  // }

// void sendMessage(String content, int type, String groupChatId,
//     String currentUserId, String peerId) {
//   DocumentReference documentReference = firebaseFirestore
//       .collection(FirestoreConstants.pathMessageCollection)
//       .doc(groupChatId)
//       .collection(groupChatId)
//       .doc(DateTime.now().millisecondsSinceEpoch.toString());
//
//   MessageChat messageChat = MessageChat(
//     idFrom: currentUserId,
//     idTo: peerId,
//     timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
//     content: content,
//     type: type,
//   );
//
//   FirebaseFirestore.instance.runTransaction((transaction) async {
//     transaction.set(
//       documentReference,
//       messageChat.toJson(),
//     );
//   });
// }
}

class TypeMessage {
  static const text = 0;
  static const image = 1;
  static const sticker = 2;
}
