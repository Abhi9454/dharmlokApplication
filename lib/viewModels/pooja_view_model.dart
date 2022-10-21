

import 'package:dharmlok/helpers/location_manager.dart';
import 'package:dharmlok/models/bal_vidya_model.dart';
import 'package:dharmlok/models/service_model.dart';
import 'package:dharmlok/services/bal_vidya_service.dart';
import 'package:dharmlok/services/pooja_service.dart';
import 'package:dharmlok/services/termple_service.dart';

import 'package:flutter/cupertino.dart';

import '../helpers/enum.dart';
import '../helpers/error_handler.dart';
import '../helpers/read_user_data.dart';
import '../models/service_model.dart';
import '../models/temple_model.dart';


class PoojaViewModel extends ChangeNotifier {
  final PoojaService _poojaService = PoojaService();
  Status _status = Status.init;
  final UserDetails getUser = UserDetails();
  String city = '';
  String state = '';
  String services = '';
  String type = '';

  final LocationManager _locationManager = LocationManager();

  String userLocation = '';

  getUserLocation() async{
    userLocation = await _locationManager.getLocationName();
    notifyListeners();
  }

  Status get status => _status;

  List<ServiceModel> _myPoojaList = [] ;

  List<ServiceModel> get myPoojaList => _myPoojaList;

  List<ServiceModel> _otherPoojaList = [] ;

  List<ServiceModel> get otherPoojaList => _otherPoojaList;



  Future<void> _setServiceModel(Map<String,dynamic> serviceModel) async {
    if(serviceModel['success'] == true){
      _myPoojaList = serviceModel['myList'].map<ServiceModel>((json) => ServiceModel.fromJson(json))
          .toList();
      _otherPoojaList = serviceModel['otherlist'].map<ServiceModel>((json) => ServiceModel.fromJson(json))
          .toList();
    }
    _status = Status.success;
    notifyListeners();
  }

  late ShowError _error;

  ShowError get error => _error;

  void _setError(ShowError error) {
    _error = error;
    notifyListeners();
  }


  getAllPooja() async {
    try {
      _status = Status.loading;
      _setServiceModel(await _poojaService.getAllPooja(city,userLocation,services,state,type,await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }
}
