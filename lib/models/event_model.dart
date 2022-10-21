class EventModel {
  EventModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.place,
    required this.type,
    required this.location,
    required this.cost,
    required this.bannerImageUrl,
    required this.relatedImageUrl,
    required this.approved,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
    required this.views,
    required this.active,
    required this.category,
    required this.createdAt,
    required this.v,
  });

  final String id;
  final String userId;
  final String title;
  final String description;
  final String place;
  final String type;
  final String location;
  final int cost;
  final String bannerImageUrl;
  final String relatedImageUrl;
  final int approved;
  final DateTime fromDate;
  final DateTime toDate;
  final String fromTime;
  final String toTime;
  final int views;
  final int active;
  final String category;
  final String createdAt;
  final int v;

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      EventModel(
        id: json["_id"],
        userId: json["userId"],
        title: json["title"],
        description: json["description"],
        place: json["place"],
        type: json["type"],
        location: json["location"],
        cost: json["cost"],
        bannerImageUrl: json["bannerImageUrl"],
        relatedImageUrl: json["relatedImageUrl"],
        approved: json["approved"],
        fromDate: DateTime.parse(json["fromDate"]),
        toDate: DateTime.parse(json["toDate"]),
        fromTime: json["fromTime"],
        toTime: json["toTime"],
        views: json["views"],
        active: json["active"],
        category: json["category"],
        createdAt: json["createdAt"],
        v: json["__v"],
      );
}