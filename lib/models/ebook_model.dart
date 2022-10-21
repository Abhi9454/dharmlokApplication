class EbookModel {
  EbookModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.category,
    required this.type,
    required this.language,
    required this.pdFuploadUrl,
    required this.thumbNailImageUrl,
    required this.active,
    required this.createdAt,
    required this.v,
  });

  final String id;
  final String userId;
  final String name;
  final String description;
  final String category;
  final String type;
  final String language;
  final String pdFuploadUrl;
  final String thumbNailImageUrl;
  final int active;
  final DateTime createdAt;
  final int v;

  factory EbookModel.fromJson(Map<String, dynamic> json) => EbookModel(
    id: json["_id"],
    userId: json["userId"],
    name: json["name"],
    description: json["description"],
    category: json["category"],
    type: json["type"],
    language: json["language"],
    pdFuploadUrl: json["PDFuploadUrl"],
    thumbNailImageUrl: json["thumbNailImageUrl"],
    active: json["active"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "name": name,
    "description": description,
    "category": category,
    "type": type,
    "language": language,
    "PDFuploadUrl": pdFuploadUrl,
    "thumbNailImageUrl": thumbNailImageUrl,
    "active": active,
    "createdAt": createdAt.toIso8601String(),
    "__v": v,
  };
}

