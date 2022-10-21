class PostModel {
  PostModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.description,
    required this.imageUrl,
    required this.videoUrl,
    required this.postType,
    required this.like,
    required this.comment,
    required this.userType,
    required this.isLiked,
    required this.createdAt,
    required this.v,
  });

  final String id;
  final String userId;
  final String userName;
  final String userImage;
  final String description;
  final String imageUrl;
  final String videoUrl;
  final String postType;
  final int like;
  final int comment;
  final int userType;
  final bool isLiked;
  final DateTime createdAt;
  final int v;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      PostModel(
        id: json["_id"],
        userId: json["userId"],
        userName: json["userName"],
        userImage: json["userImage"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        videoUrl: json["videoUrl"],
        postType: json["postType"],
        like: json["like"],
        comment: json["comment"],
        userType: json["userType"],
        isLiked: json["isLiked"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );
}