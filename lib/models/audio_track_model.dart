class AudioTrackModel {
  AudioTrackModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.category,
    required this.playlist,
    required this.bannerImageUrl,
    required this.audioUrl,
    required this.createdAt,
    required this.v,
  });

  final String id;
  final String userId;
  final String title;
  final String description;
  final String category;
  final String playlist;
  final String bannerImageUrl;
  final String audioUrl;
  final DateTime createdAt;
  final int v;

  factory AudioTrackModel.fromJson(Map<String, dynamic> json) => AudioTrackModel(
    id: json["_id"],
    userId: json["userId"],
    title: json["title"],
    description: json["description"],
    category: json["category"],
    playlist: json["playlist"],
    bannerImageUrl: json["bannerImageUrl"],
    audioUrl: json["audioUrl"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "title": title,
    "description": description,
    "category": category,
    "playlist": playlist,
    "bannerImageUrl": bannerImageUrl,
    "audioUrl": audioUrl,
    "createdAt": createdAt.toIso8601String(),
    "__v": v,
  };
}