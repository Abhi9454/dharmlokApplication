class BalVidyaModel {
  final String PDFuploadUrl;
  final int active;
  final String category;
  final String description;
  final String language;
  final String name;
  final String linkType;
  final String thumbNailImageUrl;
  final String type;
  final String videoUrl;
  final String id;

  BalVidyaModel({
    required this.PDFuploadUrl,
    required this.active,
    required this.category,
    required this.description,
    required this.language,
    required this.name,
    required this.linkType,
    required this.thumbNailImageUrl,
    required this.type,
    required this.videoUrl,
    required this.id,
  });

  factory BalVidyaModel.fromJson(Map<String, dynamic> json) {
    return BalVidyaModel(
      PDFuploadUrl: json['PDFuploadUrl'],
      active: json['active'],
      category: json['category'],
      description: json['description'],
      language: json['language'],
      name: json['name'],
      linkType: json['linkType'],
      thumbNailImageUrl: json['thumbNailImageUrl'],
      type: json['type'],
      videoUrl: json['videoUrl'],
      id: json['_id'],
    );
  }
}
