// import 'package:flutter/material.dart';
//
// import 'chatuser.dart';
// import 'conversationList.dart';
//
// List<ChatUsers> chatUsers = [
//   ChatUsers(
//     name: "Jane Russel",
//     messageText: "Awesome Setup",
//     image: "assets/discover1.png",
//     time: "Now",
//   ),
//   ChatUsers(
//       name: "Glady's Murphy",
//       messageText: "That's Great",
//       image: "assets/discover2.png",
//       time: "Yesterday"),
//   ChatUsers(
//       name: "Jorge Henry",
//       messageText: "Hey where are you?",
//       image: "assets/discover3.png",
//       time: "31 Mar"),
//   ChatUsers(
//       name: "Philip Fox",
//       messageText: "Busy! Call me in 20 mins",
//       image: "assets/discover4.png",
//       time: "28 Mar"),
//   ChatUsers(
//       name: "Debra Hawkins",
//       messageText: "Thankyou, It's awesome",
//       image: "assets/discover5.png",
//       time: "23 Mar"),
//   ChatUsers(
//       name: "Jacob Pena",
//       messageText: "will update you in evening",
//       image: "assets/discover6.png",
//       time: "17 Mar"),
//   ChatUsers(
//       name: "Andrey Jones",
//       messageText: "Can you please share the file?",
//       image: "assets/discover1.png",
//       time: "24 Feb"),
//   ChatUsers(
//       name: "John Wick",
//       messageText: "How are you?",
//       image: "assets/discover4.png",
//       time: "18 Feb")
// ];
//
// class chatmessage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _chatmessage();
//   }
// }
//
// class _chatmessage extends State<chatmessage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             SafeArea(
//               child: Padding(
//                 padding: EdgeInsets.only(left: 16, right: 16, top: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text(
//                       "Message",
//                       style:
//                           TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 16, left: 16, right: 16),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: "Search...",
//                   hintStyle: TextStyle(color: Colors.grey.shade600),
//                   prefixIcon: Icon(
//                     Icons.search,
//                     color: Colors.grey.shade600,
//                     size: 20,
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey.shade100,
//                   contentPadding: EdgeInsets.all(8),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: BorderSide(color: Colors.grey.shade100)),
//                 ),
//               ),
//             ),
//             ListView.builder(
//               itemCount: chatUsers.length,
//               shrinkWrap: true,
//               padding: EdgeInsets.only(top: 16),
//               physics: NeverScrollableScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return ConversationList(
//                   name: chatUsers[index].name,
//                   messageText: chatUsers[index].messageText,
//                   imageUrl: chatUsers[index].image,
//                   time: chatUsers[index].time,
//                   isMessageRead: (index == 0 || index == 3) ? true : false,
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
