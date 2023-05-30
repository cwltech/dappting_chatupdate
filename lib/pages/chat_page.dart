import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dapp/providers/keyboard_provider.dart';
import 'package:dapp/providers/profile_deatils_provider.dart';
import 'package:dapp/wallet.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/color_constants.dart';
import '../constants/firestore_constants.dart';
import '../providers/auth_provider.dart';
import '../providers/chat_provider.dart';
import '../widgets/widgets.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.arguments, required this.type})
      : super(key: key);

  final ChatPageArguments arguments;
  final type;

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final _formKey = GlobalKey<FormState>();

  List<QueryDocumentSnapshot> listMessage = [];
  int _limit = 20;
  int _limitIncrement = 20;
  String groupChatId = "";

  File? imageFile;
  bool isLoading = false;
  bool isShowSticker = false;
  String imageUrl = "";

  final TextEditingController textEditingController = TextEditingController();

  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  // late ChatProvider chatProvider;
  late AuthProvider authProvider;
  late virtual_gift_provider giftProvider;
  var gift;
  var image_of_gift;
  String? currentUserId;
  int _selectedIndex = 0;

  List<Widget> tabItems = [
    const Center(child: Text("0")),
    const Center(child: Text("1")),
    const Center(child: Text("2")),
    const Center(child: Text("3")),
    const Center(child: Text("4"))
  ];
  List<FlashyTabBarItem> items = [];

  void _fetchMessage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var getUserID = pref.getString(FirestoreConstants.id);

    final chatMessage = context.read<ChatListMessageProvider>();

    if (getUserID != null) {
      chatMessage.messageList(getUserID, widget.arguments.peerId);
    }
  }

  @override
  void initState() {
    super.initState();

    const oneSecond = Duration(seconds: 1);
    print(oneSecond);
    Timer.periodic(
        oneSecond,
        (Timer t) => setState(() {
              _fetchMessage();
            }));
    chatProvider = context.read<ChatProvider>();
    authProvider = context.read<AuthProvider>();
    giftProvider = context.read<virtual_gift_provider>();
    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);
    // context
    //     .read<ProfileDetailsProvider>()
    //     .profile_details_list(currentUserId);

    // readLocal();
  }

  _scrollListener() {
    if (!listScrollController.hasClients) return;
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange &&
        _limit <= listMessage.length) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  // void readLocal() {
  //   if (authProvider.getUserFirebaseId()?.isNotEmpty == true) {
  //     currentUserId = authProvider.getUserFirebaseId()!;
  //   } else {
  //     Navigator.of(context).pushAndRemoveUntil(
  //       MaterialPageRoute(builder: (context) => login()),
  //       (Route<dynamic> route) => false,
  //     );
  //   }
  //   String peerId = widget.arguments.peerId;
  //   if (currentUserId.compareTo(peerId) > 0) {
  //     groupChatId = '$currentUserId-$peerId';
  //   } else {
  //     groupChatId = '$peerId-$currentUserId';
  //   }
  //
  //   chatProvider.updateDataFirestore(
  //     FirestoreConstants.pathUserCollection,
  //     currentUserId,
  //     {FirestoreConstants.chattingWith: peerId},
  //   );
  //
  //   print("chatProvider ${FirestoreConstants.pathUserCollection}");
  // }

  // TODO : Get Image Function
  // Future getImage() async {
  //   ImagePicker imagePicker = ImagePicker();
  //   PickedFile? pickedFile;
  //
  //   pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     imageFile = File(pickedFile.path);
  //     if (imageFile != null) {
  //       setState(() {
  //         isLoading = true;
  //       });
  //       uploadFile();
  //     }
  //   }
  // }

  void getSticker() {
    giftProvider.gift_list();

    // Hide keyboard when sticker appear
    focusNode.unfocus();
    setState(() {
      isShowSticker = !isShowSticker;
    });
  }

  Widget gifts(int giftcount, var data, int selecteditem) {
    print(" peerId =========> ${widget.arguments.peerId}");

    context.read<profile_details_provider>().profile_details_list(
        currentUserId ?? authProvider.getUserFirebaseId().toString());

    return Consumer<profile_details_provider>(builder: (context, value, child) {
      return value.map["data"]["userData"] != null
          ? Center(
              child: GridView.builder(
                itemCount: giftcount,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return TextButton(
                    onPressed: () async {
                      if (widget.type == "user") {
                        print(
                            "coinmap ${value.map["data"]["userData"]["coins"]}");
                        Future.delayed(const Duration(seconds: 2));
                        print(
                            "coinmap ${value.map["data"]["userData"]["coins"]}");
                        if (value.map["data"]["userData"]["coins"] <
                            int.parse(data["GiftList"][index]["gift_credit"])) {
                          showModalBottomSheet<void>(
                            //useRootNavigator: true,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return //Container(
                                  // height:
                                  //     MediaQuery.of(context).size.height * 0.9,
                                  // child:
                                  mybalance();
                            },
                          );
                        } else {
                          print(
                              "Image Gift --------->${data["GiftList"][index]["gift_image"]}");
                          onSendMessage(data["GiftList"][index]["gift_image"],
                              TypeMessage.sticker);
                          coin_deduction(
                              currentUserId ??
                                  authProvider.getUserFirebaseId().toString(),
                              widget.arguments.peerId,
                              data["GiftList"][index]["gift_credit"],
                              "",
                              "virtual_gift");
                          chatingDetails(
                              currentUserId ??
                                  authProvider.getUserFirebaseId().toString(),
                              widget.arguments.peerId,
                              "1",
                              data["GiftList"][index]["gift_image"],
                              data["GiftList"][index]["gift_id"].toString());
                        }
                      }
                    },
                    child: Image.network(
                      data["GiftList"][index]["gift_image"],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            )
          : Container();
    });
  }

  // Future uploadFile() async {
  //   String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   UploadTask uploadTask = chatProvider.uploadFile(imageFile!, fileName);
  //   try {
  //     TaskSnapshot snapshot = await uploadTask;
  //     imageUrl = await snapshot.ref.getDownloadURL();
  //     setState(() {
  //       isLoading = false;
  //       onSendMessage(imageUrl, TypeMessage.image);
  //     });
  //   } on FirebaseException catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Fluttertoast.showToast(msg: e.message ?? e.toString());
  //   }
  // }

  coin_deduction(String userId, String host_id, String coins, String sec,
      String plan_type) async {
    String postUrl =
        "https://hookupindia.in/hookup/ApiController/coinDeduction";
    print("stringrequest");
    var request = http.MultipartRequest("POST", Uri.parse(postUrl));
    request.fields['user_id'] = userId;
    request.fields['host_id'] = host_id;
    request.fields['coins'] = coins;
    request.fields['sec'] = sec;
    request.fields['plan_type'] = plan_type;
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          // Navigator.pop(context);
          print("onValue${onValue.body}");
          Map mapRes = json.decode(onValue.body);
          var success = mapRes["status"];
          var msg = mapRes["message"];
          print("Hello Message -------- > $msg");
          if (success == "1") {
            print("resultt $mapRes");
          } else {}
        } catch (e) {
          print("response$e");
        }
      });
    });
  }

  // TODO : Chat API For Sending
  chatingDetails(String senderid, String recieverid, String type,
      String message, String giftid) async {
    String postUrl = "https://hookupindia.in/hookup/ApiController/chat";

    var request = http.MultipartRequest("POST", Uri.parse(postUrl));
    request.fields['sender_id'] = senderid;
    request.fields['reciever_id'] = recieverid;
    request.fields['type'] = type;
    request.fields['message'] = message;
    request.fields['gift_id'] = giftid;

    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) async {
        try {
          // Navigator.pop(context);

          Map mapRes = json.decode(onValue.body);
          print("onValue${onValue.body}");
          var success = mapRes["status"];

          if (success == "1") {
            SharedPreferences pref = await SharedPreferences.getInstance();
            var gettingID = pref.getString(FirestoreConstants.id);
            var nickNameID = pref.getString(FirestoreConstants.nickname);
            // var recID = pref.getString(FirestoreConstants.content);
            print(
                "Check Receiver User ID 📥📥📥📥📥📥-------> ${widget.arguments.peerId}");
            print("User Nickname --------------->$nickNameID");
            print(
                "Check Sender User ID 📤📤📤📤📤📤 ---------------> $gettingID");
            print("resultt $mapRes");
          } else {}
        } catch (e) {
          print("response$e");
        }
      });
    });
  }

  late ChatProvider chatProvider;

  void onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      chatProvider.sendMessage(content, type, groupChatId,
          currentUserId ?? 'currentUserID', widget.arguments.peerId);
      if (listScrollController.hasClients) {
        listScrollController.animateTo(0,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send', backgroundColor: ColorConstants.greyColor);
    }
  }

  // bool isLastMessageLeft(int index) {
  //   if ((index > 0 &&
  //           listMessage[index - 1].get(FirestoreConstants.idFrom) ==
  //               currentUserId) ||
  //       index == 0) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // bool isLastMessageRight(int index) {
  //   if ((index > 0 &&
  //           listMessage[index - 1].get(FirestoreConstants.idFrom) !=
  //               currentUserId) ||
  //       index == 0) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    }
    // else {
    //   chatProvider.updateDataFirestore(
    //     FirestoreConstants.pathUserCollection,
    //     currentUserId,
    //     {FirestoreConstants.chattingWith: null},
    //   );
    //   Navigator.pop(context);
    // }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    context.read<virtual_gift_provider>().gift_list();

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Center(
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Back",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
        ],
        backgroundColor: const Color(0xffCC0000),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Material(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            clipBehavior: Clip.hardEdge,
            child: widget.arguments.peerAvatar != null
                ? Image.network(
                    widget.arguments.peerAvatar,
                    fit: BoxFit.cover,
                    width: 40,
                    height: 40,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: ColorConstants.themeColor,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, object, stackTrace) {
                      return const Icon(
                        Icons.account_circle,
                        size: 40,
                        color: ColorConstants.greyColor,
                      );
                    },
                  )
                : const Icon(
                    Icons.account_circle,
                    size: 40,
                    color: ColorConstants.greyColor,
                  ),
          ),
        ),
        title: Row(
          children: [
            Text(
              widget.arguments.peerNickname,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              widget.arguments.peerId,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
        //centerTitle: true,
      ),
      body: SafeArea(
        child: WillPopScope(
          onWillPop: onBackPress,
          child: Stack(
            children: <Widget>[
              Opacity(
                  opacity: 0.9,
                  child: Image.asset('assets/homeheart.png',
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height * 0.5,
                      fit: BoxFit.cover)),
              Column(
                children: <Widget>[
                  // List of messages
                  buildListMessage(),

                  // Sticker
                  isShowSticker ? showSticker() : const SizedBox.shrink(),

                  // Input content
                  messageInput(),
                ],
              ),

              // Loading
              showLoading()
            ],
          ),
        ),
      ),
    );
  }

  // TODO : Sticker Section
  Widget showSticker() {
    return Expanded(child:
        Consumer<virtual_gift_provider>(builder: (context, value, child) {
      print(
          "Sticker List👍👍👍👍👍👍👍👌==============> ${value.map["data"]["CategoryList"][_selectedIndex]["GiftList"]}");

      return value.map.isEmpty && !value.error
          ? const Center(child: Center(child: CircularProgressIndicator()))
          : value.error
              ? const Text("Opps something went wrong")
              : value.map["data"]["CategoryList"] != null
                  ? Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: ColorConstants.greyColor2,
                                  width: 0.5)),
                          color: Colors.white),
                      padding: const EdgeInsets.all(5),
                      height: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.37,
                            child: Scaffold(
                              body: Center(
                                child: gifts(
                                    value
                                        .map["data"]["CategoryList"]
                                            [_selectedIndex]["GiftList"]
                                        .length,
                                    value.map["data"]["CategoryList"]
                                        [_selectedIndex],
                                    _selectedIndex),
                                //child: tabItems[_selectedIndex],
                              ),
                              bottomNavigationBar: FlashyTabBar(
                                animationCurve: Curves.linear,
                                selectedIndex: _selectedIndex,
                                iconSize: 30,
                                showElevation: false,
                                // use this to remove appBar's elevation
                                onItemSelected: (index) => setState(() {
                                  _selectedIndex = index;
                                }),
                                items: [
                                  FlashyTabBarItem(
                                    icon: const Icon(CupertinoIcons.gift),
                                    title: Text(
                                      value.map["data"]["CategoryList"]
                                          [_selectedIndex]["category_name"],
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  FlashyTabBarItem(
                                    icon: const Icon(CupertinoIcons.gift),
                                    title: Text(
                                      value.map["data"]["CategoryList"]
                                          [_selectedIndex]["category_name"],
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  FlashyTabBarItem(
                                    icon: const Icon(CupertinoIcons.gift),
                                    title: Text(
                                      value.map["data"]["CategoryList"]
                                          [_selectedIndex]["category_name"],
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  FlashyTabBarItem(
                                    icon: const Icon(CupertinoIcons.gift),
                                    title: Text(
                                      value.map["data"]["CategoryList"]
                                          [_selectedIndex]["category_name"],
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  FlashyTabBarItem(
                                    icon: const Icon(
                                      CupertinoIcons.gift,
                                    ),
                                    title: Text(
                                        value.map["data"]["CategoryList"]
                                            [_selectedIndex]["category_name"],
                                        style: const TextStyle(fontSize: 10)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
    }));
  }

  //TODO : Show Loading
  Widget showLoading() {
    return Positioned(
      child: isLoading ? LoadingView() : const SizedBox.shrink(),
    );
  }

  // TODO : Text Field For Message(Message)
  Widget messageInput() {
    onSendMessagesFunction() async {
      if (_formKey.currentState!.validate()) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        var userID = pref.getString(FirestoreConstants.id);

        print("User ID From Share 📤📤📤📤📤📤---------> $userID");
        print("User To 📥📥📥📥📥📥 -----------> ${widget.arguments.peerId}");
        print("Message 📄📄📄📄📄 =========> ${TypeMessage.text}");
        print("Message Print 🖨 -------------> ${textEditingController.text}");
        print("Sticker Type =====> ${TypeMessage.sticker}");
        chatingDetails(
            userID.toString(),
            widget.arguments.peerId,
            TypeMessage.text.toString(),
            textEditingController.text,
            TypeMessage.sticker.toString());
        setState(() {
          textEditingController.clear();
        });
      }
    }

    return Container(
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(color: ColorConstants.greyColor2, width: 0.5)),
          color: Colors.white),
      child: Row(
        children: <Widget>[
          // TODO : Button Send Image Button
          // Material(
          //   color: Colors.white,
          //   child: Container(
          //     margin: const EdgeInsets.symmetric(horizontal: 1),
          //     child: IconButton(
          //       icon: const Icon(Icons.image),
          //       onPressed: getImage,
          //       color: ColorConstants.primaryColor,
          //     ),
          //   ),
          // ),

          Material(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: const Icon(Icons.face),
                // TODO : Get Sticker
                onPressed: getSticker,
                color: isShowSticker
                    ? const Color(0xffCC0000)
                    : ColorConstants.primaryColor,
              ),
            ),
          ),

          // TODO: TextField For Chat
          Flexible(
            child: Container(
              child: Form(
                key: _formKey,
                child: TextField(
                  style: const TextStyle(
                      color: ColorConstants.primaryColor, fontSize: 15),
                  controller: textEditingController,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Type your message...',
                    hintStyle: TextStyle(color: ColorConstants.greyColor),
                  ),
                  focusNode: focusNode,
                  autofocus: true,
                ),
              ),
            ),
          ),

          // TODO:  Button send message
          Material(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              color: ColorConstants.primaryColor,
              child: IconButton(
                onPressed: onSendMessagesFunction,
                icon: const Icon(
                  Icons.send,
                  color: Color(0xffCC0000),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //*** ======================> Text Message Show Section <====================== ***///
  buildListMessage() {
    return Expanded(child:
        Consumer<ChatListMessageProvider>(builder: (context, state, child) {
      final dataList = state.map["data"];
      return state.map.isNotEmpty
          ? ListView.separated(
              reverse: true,
              controller: listScrollController,
              itemCount: dataList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: widget.arguments.peerId ==
                                dataList[index]["user_id"]
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(10),
                            width: 225,
                            decoration: BoxDecoration(
                                color: widget.arguments.peerId !=
                                        dataList[index]["user_id"]
                                    ? const Color(0xFF07D3DF)
                                    : const Color(0xFFC50808),
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    trailing: Text(
                                      dataList[index]["gift_id"],
                                      overflow: TextOverflow.visible,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    title: Text(
                                      dataList[index]["message"],
                                      overflow: TextOverflow.visible,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(left: 75),
                                      child: Text(
                                        dataList[index]["date"],
                                        overflow: TextOverflow.visible,
                                        style: const TextStyle(
                                            fontSize: 9, color: Colors.black),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ]),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Padding(padding: EdgeInsets.only(bottom: 10));
              },
            )
          : const Center(
              child: Text(" 'Start The Chat With Your Partner 😊..' "));
    }));
  }
}

class ChatPageArguments {
  final String peerId;
  final String peerAvatar;
  final String peerNickname;

  ChatPageArguments(
      {required this.peerId,
      required this.peerAvatar,
      required this.peerNickname});
}
