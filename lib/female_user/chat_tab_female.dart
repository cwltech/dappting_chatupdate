// import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
// import 'package:dapp/chatmessage.dart';
// import 'package:flutter/material.dart';
//
// import '../conversationList.dart';
// import '../invitevideocall.dart';
//
// class chat_tab extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _chat_tab();
//   }
// }
//
// class _chat_tab extends State<chat_tab> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         centerTitle: true,
//         leading: const Icon(
//           Icons.arrow_back_ios,
//           color: Colors.black,
//         ),
//         backgroundColor: Colors.transparent,
//         title: const Text.rich(
//           TextSpan(
//             children: [
//               TextSpan(
//                   text: "Message",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 18,
//                   )),
//             ],
//           ),
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 8.0),
//             child: Icon(
//               Icons.settings,
//               color: Colors.black,
//             ),
//           )
//         ],
//         elevation: 0.0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(3.0),
//               color: Colors.transparent,
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               child: ContainedTabBarView(
//                 tabBarProperties: TabBarProperties(
//                   //height: 32.0,
//                   labelColor: Colors.red,
//                   indicatorColor: const Color(0xff07D3DF),
//                   indicatorWeight: 1.0,
//                   unselectedLabelColor: Colors.grey[400],
//                 ),
//                 tabs: const [
//                   Text(
//                     'Appointment List',
//                     style: TextStyle(
//                       //color: Colors.red,
//                       fontSize: 13,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     'All Users',
//                     style: TextStyle(
//                       //color: Colors.red,
//                       fontSize: 13,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     'Vip Users',
//                     style: TextStyle(
//                       //color: Colors.red,
//                       fontSize: 13,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//                 views: [
//                   //wallet_w(),
//                   //credit_w()
//                   Container(
//                     color: Colors.white,
//                     child: const Center(
//                       child: Text("OPPS!!  Nobody here"),
//                     ),
//                   ),
//                   ListView.builder(
//                     itemCount: chatUsers.length,
//                     shrinkWrap: true,
//                     padding: const EdgeInsets.only(top: 16),
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return ConversationList(
//                         name: chatUsers[index].name,
//                         messageText: chatUsers[index].messageText,
//                         imageUrl: chatUsers[index].image,
//                         time: chatUsers[index].time,
//                         isMessageRead:
//                             (index == 0 || index == 3) ? true : false,
//                       );
//                     },
//                   ),
//                   ListView.builder(
//                     itemCount: chatUsers.length,
//                     shrinkWrap: true,
//                     padding: const EdgeInsets.only(top: 16),
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return ConversationList(
//                         name: chatUsers[index].name,
//                         messageText: chatUsers[index].messageText,
//                         imageUrl: chatUsers[index].image,
//                         time: chatUsers[index].time,
//                         isMessageRead:
//                             (index == 0 || index == 3) ? true : false,
//                       );
//                     },
//                   ),
//                 ],
//                 onChange: (index) => print(index),
//               ),
//             ),
//             // CallInvitationPage(
//             //   localUserID: 1011,
//             //   inivites: "",
//             //   username: "Vendor side",
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
