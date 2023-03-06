class VideoModel {
  final String title;
  final String description;
  final String videoUrl;

  VideoModel(
      {required this.title,required this.description, required this.videoUrl
      });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      title: json['title'],
      description: json['description'],
      videoUrl: json['videoUrl'],
    );
  }
}