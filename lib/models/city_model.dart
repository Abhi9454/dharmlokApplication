class CityModel {
  final String cityName;

  CityModel(
      {required this.cityName,
      });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      cityName: json['city_name'],
    );
  }
}