

import 'package:dharmlok/helpers/location_manager.dart';
import 'package:dharmlok/models/bal_vidya_model.dart';
import 'package:dharmlok/services/bal_vidya_service.dart';
import 'package:dharmlok/services/termple_service.dart';

import 'package:flutter/cupertino.dart';

import '../helpers/enum.dart';
import '../helpers/error_handler.dart';
import '../helpers/read_user_data.dart';
import '../models/temple_model.dart';


class TempleViewModel extends ChangeNotifier {
  final TempleService _templeService = TempleService();
  Status _status = Status.init;
  final UserDetails getUser = UserDetails();
  String city = '';
  String state = '';

  String category = 'Sanatan';
  final LocationManager _locationManager = LocationManager();

  String userLocation = '';

  getUserLocation() async{
    userLocation = await _locationManager.getLocationName();
    notifyListeners();
  }

  Status get status => _status;

  List<TempleDetails> _myTempleList = [] ;

  List<TempleDetails> get myTempleList => _myTempleList;

  List<TempleDetails> _otherTempleList = [] ;

  List<TempleDetails> get otherTempleList => _otherTempleList;



  Future<void> _setTempleDetails(Map<String,dynamic> templeDetails) async {
    if(templeDetails['success'] == true){
      _myTempleList = templeDetails['myList'].map<TempleDetails>((json) => TempleDetails.fromJson(json))
          .toList();
      _otherTempleList = templeDetails['otherlist'].map<TempleDetails>((json) => TempleDetails.fromJson(json))
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

  updateCategory(String name){
    category = name;
    _myTempleList.clear();
    _otherTempleList.clear();
    getAllTemples();
    notifyListeners();
  }

  getAllTemples() async {
    try {
      _status = Status.loading;
      _setTempleDetails(await _templeService.getAllTemples(category,city,'en',userLocation,state,await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }
}
