

import 'package:dharmlok/helpers/location_manager.dart';
import 'package:dharmlok/models/bal_vidya_model.dart';
import 'package:dharmlok/models/city_model.dart';
import 'package:dharmlok/models/service_model.dart';
import 'package:dharmlok/models/state_model.dart';
import 'package:dharmlok/services/bal_vidya_service.dart';
import 'package:dharmlok/services/manage_profile_service.dart';
import 'package:dharmlok/services/pooja_service.dart';
import 'package:dharmlok/services/termple_service.dart';
import 'package:dharmlok/services/vendor_service.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../helpers/enum.dart';
import '../helpers/error_handler.dart';
import '../helpers/read_user_data.dart';
import '../models/service_model.dart';
import '../models/temple_model.dart';
import '../models/vendor_model.dart';


class ManageProfileViewModel extends ChangeNotifier {
  final ManageProfileService _manageProfileService = ManageProfileService();
  final VendorService _vendorService = VendorService();
  Status _status = Status.init;
  final UserDetails getUser = UserDetails();
  List<String> states = [];
  List<String> cities = [];

  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  String profileImageUrl = '1662632016476.webp';

  String selectedState = 'Select state';
  String selectedCity = 'Select city';

  String imageUrl = '';

  final LocationManager _locationManager = LocationManager();

  late Map<String,dynamic> _vendorDetails;

  Map<String,dynamic> get vendorDetails => _vendorDetails;

  String userLocation = '';

  String errorMessage = '';

  getUserLocation() async{
    userLocation = await _locationManager.getLocationName();
    notifyListeners();
  }

  Status get status => _status;




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
    _status = Status.success;
    notifyListeners();
  }

  Future<void> _setCitiesList(Map<String,dynamic> cityResponse) async {
    List<CityModel> cityListMap = [];
    cityListMap.clear();
    if(cityResponse['success'] == true){
      cityListMap = (cityResponse['message'] as List)
          .map((itemWord) => CityModel.fromJson(itemWord)).toList();
    }
    for(int i = 0; i < cityListMap.length; i++){
      cities.add(cityListMap[i].cityName);
    }
    _status = Status.success;
    notifyListeners();
  }

  Future<void> _setUpdateResponse(Map<String,dynamic> updateResponse,BuildContext context) async {
    if(updateResponse['success'] == false){
      errorMessage = updateResponse['message'];
      Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );
      _status = Status.failed;
    }
    else{
      Fluttertoast.showToast(
          msg: "Profile Updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );
      _status = Status.success;
    }
    notifyListeners();
  }

  Future<void> _setVendorDetails(Map<String,dynamic> vendorResponse) async {
    _vendorDetails = vendorResponse;
    print('this is vendor Details response' + _vendorDetails.toString());
    fullName.text = _vendorDetails['message'][0]['name'];
    email.text = _vendorDetails['message'][0]['email'];
    phone.text = _vendorDetails['message'][0]['phone'];
    profileImageUrl = _vendorDetails['message'][0]['profileImageUrl'];
    address.text = _vendorDetails['message'][0]['address'] ?? '';
    selectedState = _vendorDetails['message'][0]['state'].toString().isNotEmpty ? _vendorDetails['message'][0]['state'] :'Select state';
    if(_vendorDetails['message'][0]['state'].toString().isNotEmpty){
      _status = Status.loading;
      setSelectedState(_vendorDetails['message'][0]['state']);
      selectedCity = _vendorDetails['message'][0]['city'].toString().isNotEmpty ? _vendorDetails['message'][0]['city'] :'Select city';
    }
    _status = Status.success;
    notifyListeners();
  }


  setSelectedState(String value){
    selectedState = value;
    cities.clear();
    cities.add('Select city');
    selectedCity = 'Select city';
    getAllCities(value);
    notifyListeners();
  }


  setSelectedCity(String value){
    selectedCity = value;
    notifyListeners();
  }

  late ShowError _error;

  ShowError get error => _error;

  void _setError(ShowError error) {
    _error = error;
    notifyListeners();
  }


  getAllStates() async{
    try {
      _status = Status.loading;
      _setStateList(await _manageProfileService.getAllStates(await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
      }
      notifyListeners();
  }

  getVendorDetails() async{
    try {
      _status = Status.loading;
      _setVendorDetails(await _vendorService.getDetails('',await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }

  getAllCities(String stateName) async{
    try {
      _status = Status.loading;
      _setCitiesList(await _manageProfileService.getAllCities(stateName,await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }


  updateUserDetails(String fullName, String email, String phone, String fullAddress, BuildContext context) async {
    try {
      _status = Status.loading;
      _setUpdateResponse(await _manageProfileService.updateProfile(profileImageUrl,fullName,email,phone,selectedCity,selectedState,fullAddress,await getUser.getToken()),context);
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }
}
