import 'package:dharmlok/models/pandit_details_model.dart';

import 'package:flutter/cupertino.dart';

import '../helpers/enum.dart';
import '../helpers/error_handler.dart';
import '../helpers/location_manager.dart';
import '../helpers/read_user_data.dart';
import '../services/pooja_service.dart';


class PanditDetailsViewModel extends ChangeNotifier {
  final PoojaService _poojaService = PoojaService();
  Status _status = Status.init;
  final UserDetails getUser = UserDetails();
  String category = 'Sanatan';

  Status get status => _status;

  late PanditDetails _panditDetails;

  PanditDetails get panditDetails => _panditDetails;



  final LocationManager _locationManager = LocationManager();

  String userLocation = '';

  getUserLocation() async{
    userLocation = await _locationManager.getLocationName();
    notifyListeners();
  }




  Future<void> _setPanditDetails(PanditDetails panditDetails) async {
    _panditDetails = panditDetails;
    _status = Status.success;
    notifyListeners();
  }

  late ShowError _error;

  ShowError get error => _error;

  void _setError(ShowError error) {
    _error = error;
    notifyListeners();
  }

  getPanditDetails(String id) async {
    try {
      _status = Status.loading;
      _setPanditDetails(await _poojaService.getPanditDetails(id,await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }
}
