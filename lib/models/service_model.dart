class ServiceModel {
  ServiceModel({
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
    required this.city,
    required this.active,
    required this.rank,
    required this.availability,
    required this.serviceType,
    required this.serviceId,
    required this.serviceDetails,
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
  final String city;
  final int active;
  final int rank;
  final int availability;
  final String serviceType;
  final String serviceId;
  final ServiceDetails serviceDetails;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
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
    city: json["city"],
    active: json["active"],
    rank: json["rank"],
    availability: json["availability"],
    serviceType: json["serviceType"],
    serviceId: json["serviceId"],
    serviceDetails: ServiceDetails.fromJson(json["serviceDetails"]),
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
    "city": city,
    "active": active,
    "rank": rank,
    "availability": availability,
    "serviceType": serviceType,
    "serviceId": serviceId,
    "serviceDetails": serviceDetails.toJson(),
  };
}

class ServiceDetails {
  ServiceDetails({
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

  factory ServiceDetails.fromJson(Map<String, dynamic> json) => ServiceDetails(
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
