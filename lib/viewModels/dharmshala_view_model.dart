

import 'package:dharmlok/models/bal_vidya_model.dart';
import 'package:dharmlok/models/dharmshala_model.dart';
import 'package:dharmlok/services/bal_vidya_service.dart';
import 'package:dharmlok/services/dharmshala_service.dart';

import 'package:flutter/cupertino.dart';

import '../helpers/enum.dart';
import '../helpers/error_handler.dart';
import '../helpers/location_manager.dart';
import '../helpers/read_user_data.dart';


class DharmshalaViewModel extends ChangeNotifier {
  final DharmshalaService _dharmshalaService = DharmshalaService();
  Status _status = Status.init;
  final UserDetails getUser = UserDetails();
  String category = 'Sanatan';

  Status get status => _status;

  List<DharmshalaModel> _dharmshalaList = [] ;

  List<DharmshalaModel> get dharmshalaList => _dharmshalaList;

  final LocationManager _locationManager = LocationManager();

  String userLocation = '';

  getUserLocation() async{
    userLocation = await _locationManager.getLocationName();
    notifyListeners();
  }


  Future<void> _setDharmshalaDetails(List<DharmshalaModel> dharmshalaList) async {
    _dharmshalaList = dharmshalaList;
    _status = Status.success;
    notifyListeners();
  }

  late ShowError _error;

  ShowError get error => _error;

  void _setError(ShowError error) {
    _error = error;
    notifyListeners();
  }

  updateCategory(String name){
    category = name;
    _dharmshalaList.clear();
    getDharmshala();
    notifyListeners();
  }

  getDharmshala() async {
    try {
      _status = Status.loading;
      _setDharmshalaDetails(await _dharmshalaService.getDharmshala("","",'en','',await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }
}
