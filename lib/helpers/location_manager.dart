import 'package:shared_preferences/shared_preferences.dart';

class LocationManager {
  late SharedPreferences preferences;

  Future<String> getLocationName() async {
    preferences = await SharedPreferences.getInstance();
    String location = preferences.getString('location') ?? '';
    return location;
  }

    setLocationName(String location) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString('location', location );
  }
}