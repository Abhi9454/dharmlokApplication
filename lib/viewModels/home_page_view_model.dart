import 'package:flutter/cupertino.dart';

import '../helpers/location_manager.dart';

class HomePageViewModel extends ChangeNotifier{

  final LocationManager _locationManager = LocationManager();
  String userLocation = '';

  getUserLocation() async{
    userLocation = await _locationManager.getLocationName();
    notifyListeners();
  }

}