class DharshanModel {
  DharshanModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.url,
    required this.category,
    required this.type,
    required this.rank,
    required this.createdAt,
    required this.v,
  });

  final String id;
  final String userId;
  final String title;
  final String description;
  final String url;
  final String category;
  final String type;
  final int rank;
  final DateTime createdAt;
  final int v;

  factory DharshanModel.fromJson(Map<String, dynamic> json) => DharshanModel(
    id: json["_id"],
    userId: json["userId"],
    title: json["title"],
    description: json["description"],
    url: json["url"],
    category: json["category"],
    type: json["type"],
    rank: json["rank"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "title": title,
    "description": description,
    "url": url,
    "category": category,
    "type": type,
    "rank": rank,
    "createdAt": createdAt.toIso8601String(),
    "__v": v,
  };
}