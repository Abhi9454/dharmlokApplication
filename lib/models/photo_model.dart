class PhotoModel {
  final String title;
  final String description;
  final String imageUrl;

  PhotoModel(
      {required this.title,required this.description, required this.imageUrl
      });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}