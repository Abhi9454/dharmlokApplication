

import 'package:dharmlok/helpers/location_manager.dart';
import 'package:dharmlok/models/bal_vidya_model.dart';
import 'package:dharmlok/models/service_model.dart';
import 'package:dharmlok/services/bal_vidya_service.dart';
import 'package:dharmlok/services/dharmshala_service.dart';
import 'package:dharmlok/services/pooja_service.dart';
import 'package:dharmlok/services/termple_service.dart';

import 'package:flutter/cupertino.dart';

import '../helpers/enum.dart';
import '../helpers/error_handler.dart';
import '../helpers/read_user_data.dart';
import '../models/service_model.dart';
import '../models/state_model.dart';
import '../models/temple_model.dart';
import '../services/manage_profile_service.dart';


class DharmshalaFormPageViewModel extends ChangeNotifier {
  final DharmshalaService _dharmshalaService = DharmshalaService();
  Status _status = Status.init;
  final UserDetails getUser = UserDetails();
  final ManageProfileService _manageProfileService = ManageProfileService();
  String selectedState = 'Select state';
  List<String> states = [];

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

  Future<void> _setStateList(Map<String,dynamic> stateResponse) async {
    List<StateModel> stateListMap = [];
    states.clear();
    if(stateResponse['success'] == true){
      stateListMap = (stateResponse['message'] as List)
          .map((itemWord) => StateModel.fromJson(itemWord)).toList();
    }
    states.add('Select state');
    for(int i = 0; i < stateListMap.length; i++){
      states.add(stateListMap[i].stateName);
    }
    //_status = Status.success;
    notifyListeners();
  }



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

  late Map<String, dynamic> _enquiryMap;

  Map<String, dynamic> get enquiryMap => _enquiryMap;

  void _setError(ShowError error) {
    _error = error;
    notifyListeners();
  }

  setSelectedState(String value){
    selectedState = value;
    notifyListeners();
  }

  Future<void> _setEnquiryDetails(Map<String, dynamic> details) async {
    _enquiryMap = details;
    if(_enquiryMap['success'] == true){
      _status = Status.success;
    }
    else{
      _status = Status.failed;
    }
    notifyListeners();
  }



  getAllStates() async{
    try {
      // _status = Status.loading;
      _setStateList(await _manageProfileService.getAllStates(await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }

  addEnquiry(String name, String email,
      String date, String description, String duration, String numberOfPerson, String phone, String type) async{
    try {
      _status = Status.loading;
      _setEnquiryDetails(await _dharmshalaService.addEnquiry(name, email, date, description, duration, numberOfPerson,await getUser.getToken(), phone, type ));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }
}
