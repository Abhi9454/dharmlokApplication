import 'package:dharmlok/helpers/location_manager.dart';
import 'package:dharmlok/services/location_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import 'package:shared_preferences/shared_preferences.dart';

class MainViewModel extends ChangeNotifier{

  bool isPermissionGranted = false;
  late LocationData locationDetails;
  Location currentLocation = Location();
  final LocationManager _locationManager = LocationManager();
  late SharedPreferences preferences;

    fetchUserLocation() async{
    if (await permission.Permission.location.status.isGranted) {
      isPermissionGranted = true;
      locationDetails = await currentLocation.getLocation();
      Map<String, dynamic> location = await LocationService().getLocationName(locationDetails.latitude.toString(), locationDetails.longitude.toString());
      if(location.isNotEmpty){
        _locationManager.setLocationName(location['message']);
      }
    }
    else{
      await [permission.Permission.location].request();
      _locationManager.setLocationName('');
    }
  }

  logout() async{
      preferences = await SharedPreferences.getInstance();
      preferences.clear();
  }

}