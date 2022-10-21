// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    required this.success,
    required this.biography,
    required this.photos,
    required this.videos,
  });

  final bool success;
  final Biography? biography;
  final int photos;
  final int videos;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    success: json["success"],
    biography: json["biography"] == null ? null : Biography.fromJson(json["biography"]),
    photos: json["photos"],
    videos: json["videos"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "biography": biography ?? biography?.toJson(),
    "photos": photos,
    "videos": videos,
  };
}

class Biography {
  Biography({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.userType,
    required this.typeVendor,
    required this.profileImageUrl,
    required this.description,
    required this.coverImageUrl,
    required this.category,
    required this.address,
    required this.city,
    required this.state,
    required this.active,
    required this.rank,
    required this.availability,
    required this.kycApproved,
  });

  final String id;
  final String name;
  final String phone;
  final String email;
  final String userType;
  final String typeVendor;
  final String profileImageUrl;
  final String description;
  final String coverImageUrl;
  final String category;
  final String address;
  final String city;
  final String state;
  final int active;
  final int rank;
  final int availability;
  final int kycApproved;

  factory Biography.fromJson(Map<String, dynamic> json) => Biography(
    id: json["_id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    userType: json["userType"],
    typeVendor: json["typeVendor"],
    profileImageUrl: json["profileImageUrl"],
    description: json["description"],
    coverImageUrl: json["coverImageUrl"],
    category: json["category"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    active: json["active"],
    rank: json["rank"],
    availability: json["availability"],
    kycApproved: json["kycApproved"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "userType": userType,
    "typeVendor": typeVendor,
    "profileImageUrl": profileImageUrl,
    "description": description,
    "coverImageUrl": coverImageUrl,
    "category": category,
    "address": address,
    "city": city,
    "state": state,
    "active": active,
    "rank": rank,
    "availability": availability,
    "kycApproved": kycApproved,
  };
}
