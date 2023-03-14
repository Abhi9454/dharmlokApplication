// To parse this JSON data, do
//
//     final serviceDetails = serviceDetailsFromJson(jsonString);

import 'dart:convert';

ServiceDetailsModel serviceDetailsFromJson(String str) => ServiceDetailsModel.fromJson(json.decode(str));

String serviceDetailsToJson(ServiceDetailsModel data) => json.encode(data.toJson());

class ServiceDetailsModel {
  ServiceDetailsModel({
    required this.success,
    required this.message,
  });

  bool success;
  Message message;

  factory ServiceDetailsModel.fromJson(Map<String, dynamic> json) => ServiceDetailsModel(
    success: json["success"],
    message: Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message.toJson(),
  };
}

class Message {
  Message({
    required this.id,
    required this.userId,
    required this.name,
    required this.services,
    required this.type,
    required this.description,
    required this.price,
    required this.city,
    required this.state,
    required this.imageUrl,
    required this.active,
    required this.createdAt,
    required this.v,
  });

  String id;
  String userId;
  String name;
  String services;
  String type;
  String description;
  String price;
  String city;
  String state;
  String imageUrl;
  int active;
  DateTime createdAt;
  int v;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["_id"],
    userId: json["userId"],
    name: json["name"],
    services: json["services"],
    type: json["type"],
    description: json["description"],
    price: json["price"],
    city: json["city"],
    state: json["state"],
    imageUrl: json["imageUrl"],
    active: json["active"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "name": name,
    "services": services,
    "type": type,
    "description": description,
    "price": price,
    "city": city,
    "state": state,
    "imageUrl": imageUrl,
    "active": active,
    "createdAt": createdAt.toIso8601String(),
    "__v": v,
  };
}
