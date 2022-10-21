class AudioPlayListModel {
  AudioPlayListModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.createdAt,
    required this.v,
    required this.imageUrl,
    required this.playlist,
    required this.category,
  });

  final String id;
  final String userId;
  final String name;
  final DateTime createdAt;
  final int v;
  final String imageUrl;
  final List<AudioPlayListModel>? playlist;
  final String? category;

  factory AudioPlayListModel.fromJson(Map<String, dynamic> json) => AudioPlayListModel(
    id: json["_id"],
    userId: json["userId"],
    name: json["name"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
    imageUrl: json["imageUrl"],
    playlist: json["playlist"] == null ? null : List<AudioPlayListModel>.from(json["playlist"].map((x) => AudioPlayListModel.fromJson(x))),
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "name": name,
    "createdAt": createdAt.toIso8601String(),
    "__v": v,
    "imageUrl": imageUrl,
    "playlist": playlist == null ? null : List<dynamic>.from(playlist!.map((x) => x.toJson())),
    "category": category,
  };
}