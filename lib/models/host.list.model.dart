// To parse this JSON data, do
//
//     final chatUserListModel = chatUserListModelFromJson(jsonString);

import 'dart:convert';

ChatUserListModel chatUserListModelFromJson(String str) =>
    ChatUserListModel.fromJson(json.decode(str));

String chatUserListModelToJson(ChatUserListModel data) =>
    json.encode(data.toJson());

class ChatUserListModel {
  String? status;
  String? message;
  Data? data;

  ChatUserListModel({
    this.status,
    this.message,
    this.data,
  });

  factory ChatUserListModel.fromJson(Map<String, dynamic> json) =>
      ChatUserListModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  List<HostList>? hostList;

  Data({
    this.hostList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        hostList: json["HostList"] == null
            ? []
            : List<HostList>.from(
                json["HostList"]!.map((x) => HostList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "HostList": hostList == null
            ? []
            : List<dynamic>.from(hostList!.map((x) => x.toJson())),
      };
}

class HostList {
  int? userId;
  int? uniqueId;
  String? name;
  int? liveStatus;
  int? likeStatus;
  String? profileImage;
  String? profileVideo;

  HostList({
    this.userId,
    this.uniqueId,
    this.name,
    this.liveStatus,
    this.likeStatus,
    this.profileImage,
    this.profileVideo,
  });

  factory HostList.fromJson(Map<String, dynamic> json) => HostList(
        userId: json["user_id"],
        uniqueId: json["unique_id"],
        name: json["name"],
        liveStatus: json["live_status"],
        likeStatus: json["like_status"],
        profileImage: json["profile_image"],
        profileVideo: json["profile_video"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "unique_id": uniqueId,
        "name": name,
        "live_status": liveStatus,
        "like_status": likeStatus,
        "profile_image": profileImage,
        "profile_video": profileVideo,
      };
}
