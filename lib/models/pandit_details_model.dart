import 'dart:convert';

PanditDetails panditDetailsFromJson(String str) => PanditDetails.fromJson(json.decode(str));

String panditDetailsToJson(PanditDetails data) => json.encode(data.toJson());

class PanditDetails {
  PanditDetails({
    required this.success,
    required this.message,
  });

  final bool success;
  final Message message;

  factory PanditDetails.fromJson(Map<String, dynamic> json) => PanditDetails(
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

  final String id;
  final String userId;
  final String name;
  final String services;
  final String type;
  final String description;
  final String price;
  final String city;
  final String state;
  final String imageUrl;
  final int active;
  final DateTime createdAt;
  final int v;

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
