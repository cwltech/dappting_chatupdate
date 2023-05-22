// To parse this JSON data, do
//
//     final chatListModel = chatListModelFromJson(jsonString);

import 'dart:convert';

ChatListModel chatListModelFromJson(String str) =>
    ChatListModel.fromJson(json.decode(str));

String chatListModelToJson(ChatListModel data) => json.encode(data.toJson());

class ChatListModel {
  dynamic input;
  String? status;
  String? message;
  List<Datum>? data;

  ChatListModel({
    this.input,
    this.status,
    this.message,
    this.data,
  });

  factory ChatListModel.fromJson(Map<String, dynamic> json) => ChatListModel(
        input: json["input"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "input": input,
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? chatId;
  String? name;
  String? date;
  String? type;
  String? giftId;
  String? message;

  Datum({
    this.chatId,
    this.name,
    this.date,
    this.type,
    this.giftId,
    this.message,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        chatId: json["chat_id"],
        name: json["name"],
        date: json["date"],
        type: json["type"],
        giftId: json["gift_id"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "chat_id": chatId,
        "name": name,
        "date": date,
        "type": type,
        "gift_id": giftId,
        "message": message,
      };
}
