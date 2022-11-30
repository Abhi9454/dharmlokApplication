class TempleDetails {
  TempleDetails({
    required this.id,
    required this.userId,
    required this.bannerImageUrl,
    required this.city,
    required this.description,
    required this.location,
    required this.name,
    required this.relatedImageUrl,
    required this.state,
    required this.category,
    required this.language,
    required this.active,
    required this.createdAt,
    required this.v,
    required this.latitude,
    required this.longitude,
  });

  final String id;
  final String userId;
  final String bannerImageUrl;
  final String city;
  final String description;
  final String location;
  final String name;
  final String relatedImageUrl;
  final String state;
  final String category;
  final String language;
  final int active;
  final DateTime createdAt;
  final int v;
  final String latitude;
  final String longitude;

  factory TempleDetails.fromJson(Map<String, dynamic> json) => TempleDetails(
    id: json["_id"],
    userId: json["userId"],
    bannerImageUrl: json["bannerImageUrl"],
    city: json["city"],
    description: json["description"],
    location: json["location"],
    name: json["name"],
    relatedImageUrl: json["relatedImageUrl"],
    state: json["state"],
    category: json["category"],
    language: json["language"],
    active: json["active"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
    latitude: json["latitude"] ?? '',
    longitude: json["longitude"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "bannerImageUrl": bannerImageUrl,
    "city": city,
    "description": description,
    "location": location,
    "name": name,
    "relatedImageUrl": relatedImageUrl,
    "state": state,
    "category": category,
    "language": language,
    "active": active,
    "createdAt": createdAt.toIso8601String(),
    "__v": v,
    "latitude": latitude,
    "longitude": longitude,
  };
}
